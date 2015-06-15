//
//  FileManager.swift
//  Bedrock
//
//  Created by Robert Widmann on 6/15/15.
//  Copyright (c) 2015 Bedrock. All rights reserved.
//

import Darwin.POSIX.sys

struct FileManager {
	static func fileExists(path: String) -> Bool {
		/// Path length, even after symbolic link resolution, must never exceed PATH_MAX.
		let p = path.substringToIndex(advance(path.startIndex, Int(PATH_MAX))).fileSystemRepresentation()
		var st = stat()
		// Check for a symbolic link first.
		if lstat(p, &st) < 0 {
			return false
		}

		// Don't touch symlinks.  They will expand and do terrible things sometimes.
		if st.st_mode == S_IFLNK {
			return true
		}

		// Stat a real path.
		if stat(p, &st) < 0 {
			return false
		}

		return true
	}
}
