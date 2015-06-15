//
//  IndexSetTests.swift
//  Bedrock
//
//  Created by Robert Widmann on 6/14/15.
//  Copyright © 2015 Robert Mozayeni. All rights reserved.
//

import XCTest
import Bedrock

class IndexSetTests: XCTestCase {
	func testEmptyIndexSet() {
		let s = IndexSet<Int>()
		XCTAssert(s.count == 0)
		XCTAssert(s.containsIndex(0) == false)
	}

	func testSingletonSet() {
		let s = IndexSet(index: 5)
		XCTAssert(s.count == 1)
		XCTAssert(s.containsIndex(5))
		XCTAssert(s.containsIndex(6) == false)
	}

	func testRangeSet() {
		let r = 0..<5
		let s = IndexSet(indexesInRange: r)
		XCTAssert(s.count == r.count)
		XCTAssert(s.containsIndex(0))
		XCTAssert(s.containsIndex(1))
		XCTAssert(s.containsIndex(2))
		XCTAssert(s.containsIndex(3))
		XCTAssert(s.containsIndex(4))
		XCTAssert(s.containsIndex(5) == false)
	}

	func testAddingAnIndex() {
		let s = IndexSet<Int>()
		XCTAssert(s.count == 0)
		XCTAssert(s.containsIndex(6) == false)

		let splus = s.indexSetByAddingIndex(6)
		XCTAssert(splus.count == 1)
		XCTAssert(splus.containsIndex(6))
	}

	func testAddingARange() {
		let s = IndexSet<Int>()
		XCTAssert(s.count == 0)
		XCTAssert(s.containsIndex(6) == false)

		let splus = s.indexSetByAddingRange(6..<10)
		XCTAssert(splus.count == 4)
		XCTAssert(splus.containsIndex(6))
		XCTAssert(splus.containsIndex(7))
		XCTAssert(splus.containsIndex(8))
		XCTAssert(splus.containsIndex(9))
		XCTAssert(splus.containsIndex(10) == false)
	}

	func testAggregate() {
		let s = IndexSet<Int>()

		let splus = s.indexSetByAddingRange(1..<3).indexSetByAddingRange(4..<6).indexSetByAddingIndex(11)
		XCTAssert(splus.containsIndex(1))
		XCTAssert(splus.containsIndex(2))
		XCTAssert(splus.containsIndex(3) == false)
		XCTAssert(splus.containsIndex(4))
		XCTAssert(splus.containsIndex(5))
		XCTAssert(splus.containsIndex(11))
	}
}
