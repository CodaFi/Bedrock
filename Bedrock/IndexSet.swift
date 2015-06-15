//
//  IndexSet.swift
//  Bedrock
//
//  Created by Robert Widmann on 6/14/15.
//  Copyright © 2015 Robert Mozayeni. All rights reserved.
//

/// An `IndexSet` is an immutable collection of unique Index Types.
public struct IndexSet<T: protocol<ForwardIndexType, Comparable>> {
	public var count : Int {
		return _ranges.reduce(0, combine: { (total, r) in countRange(r) + total })
	}

	/// Creates an empty index set.
	public init() {
		_ranges = []
	}

	/// Creates an index set with an index.
	public init(index: T) {
		self = IndexSet().indexSetByAddingIndex(index)
	}

	/// Creates an index set with an index range.
	public init(indexesInRange : Range<T>) {
		self = IndexSet().indexSetByAddingRange(indexesInRange)
	}

	/// Creates an index set that contains all the indexes of the receiver plus a given index.
	public func indexSetByAddingIndex(i: T) -> IndexSet<T> {
		return self.indexSetByAddingRange(i...i)
	}

	/// Creates an index set that contains all the indexes of the receiver plus a given range.
	public func indexSetByAddingRange(r: Range<T>) -> IndexSet<T> {
		let idx = insertionIndexForIndex(r.startIndex, rightBound: _ranges.count - 1)
		var copiedRanges = _ranges
		copiedRanges.insert(r, atIndex: idx)
		mergeRangesUpToIndex(&copiedRanges, idx: idx)
		if idx > 0 {
			mergeRangesAroundIndex(&copiedRanges, idx: idx - 1)
		}
		if idx < (self.count - 1) {
			mergeRangesAroundIndex(&copiedRanges, idx: idx)
		}
		return IndexSet(copiedRanges)
	}

	/// Indicates whether the index set contains a specific index.
	public func containsIndex(i: T) -> Bool {
		return self.rangeIndexForIndex(i, rightBound: _ranges.count - 1) != -1
	}

	private let _ranges : Array<Range<T>>
}


/// MARK: Private Bits

/// NSIndexSet is really a bunch of NSRanges stuck up in series.  We have to take extra care when
/// inserting or removing ranges that we don't perturb their neighbors, or split and merge them as
/// necessary.  Every index in the set belongs somewhere in some range.
extension IndexSet {
	private init(_ ranges: Array<Range<T>>) {
		_ranges = ranges
	}

	private func mergeRangesAroundIndex(inout mRanges: [Range<T>], idx: Int) {
		if idx >= mRanges.count - 1 {
			return
		}

		// If we don't quite stretch to reach the start of the next range we're done.
		if advance(mRanges[idx].endIndex, 1) != mRanges[idx + 1].startIndex {
			return
		}
		removeRanges(&mRanges, idx: idx + 1, count: 1)
	}

	/// Tries to find the rightmost range a range at the given position can be merged into, then 
	/// merges it.
	private func mergeRangesUpToIndex(inout ranges: [Range<T>], idx: Int) {
		let targetRange = ranges[idx]

		var rightmostRangeindex = idx
		for var i = idx; i < ranges.count; i++ {
			// Search until we can search no more
			if !rangeIntersectsRange(ranges[i], other: targetRange) {
				break
			}
			rightmostRangeindex = i
		}

		// No sense in merging ourself
		if rightmostRangeindex == idx {
			return
		}

		// Merge
		let r = unionRanges(targetRange, ranges[rightmostRangeindex])
		removeRanges(&ranges, idx: idx + 1, count: rightmostRangeindex - idx)
		ranges[idx] = r
	}

	/// Mostly for convenience.
	private func removeRanges(inout ranges: [Range<T>], idx: Int, count: Int) {
		ranges.removeRange((idx + count)..<ranges.endIndex)
	}

	/// Searches the ranges for the position of the range containing the index.
	///
	/// On error this function returns -1.  It is _not helpful_ for insertion.  Use 
	/// `insertionIndexForIndex` for that.
	private func rangeIndexForIndex(idx: T, leftBound: Int = 0, rightBound: Int) -> Int {
		if self.count == 0 {
			return -1
		}

		let mid = (leftBound + rightBound) / 2
		let midRange = _ranges[mid]

		if leftBound == rightBound {
			if midRange.contains(idx) {
				return leftBound
			} else {
				return -1
			}
		}

		if midRange.contains(idx) {
			return mid
		}

		/// Look ma, a binary search.
		if idx < midRange.startIndex {
			return self.rangeIndexForIndex(idx, leftBound: leftBound, rightBound: mid)
		} else {
			return self.rangeIndexForIndex(idx, leftBound: mid + 1, rightBound: rightBound)
		}
	}

	/// Searches the ranges for the first position of a range that could contain the index.
	private func insertionIndexForIndex(idx: T, leftBound: Int = 0, rightBound: Int) -> Int {
		if self.count == 0 {
			return 0
		}

		let mid = (leftBound + rightBound) / 2
		let midRange = _ranges[mid]
		if leftBound == rightBound {
			if idx <= midRange.endIndex {
				return leftBound
			} else {
				return leftBound + 1
			}
		}

		if idx <= midRange.endIndex {
			return self.insertionIndexForIndex(idx, leftBound: leftBound, rightBound: mid)
		} else {
			return self.insertionIndexForIndex(idx, leftBound: mid + 1, rightBound: rightBound)
		}
	}
}

private func countRange<T: ForwardIndexType>(r: Range<T>) -> Int {
	var count = 0
	for _ in r {
		count++
	}
	return count
}

/// Because no Foundation.
private func rangeIntersectsRange<T: protocol<ForwardIndexType, Comparable>>(range: Range<T>, other: Range<T>) -> Bool {
	if range.endIndex <= other.startIndex {
		return true
	} else if range.startIndex <= other.endIndex {
		return true
	}
	return false
}

/// Turns out Comparable Ranges are Monoids.
private func unionRanges<T: protocol<ForwardIndexType, Comparable>>(xs: Range<T>...) -> Range<T> {
	return xs.reduce(xs[0], combine: { (rng, next) in (min(rng.startIndex, next.startIndex)...max(rng.startIndex, next.startIndex)) })
}
