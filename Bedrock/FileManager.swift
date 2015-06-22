//
//  FileManager.swift
//  Bedrock
//
//  Created by Robert Widmann on 6/15/15.
//  Copyright (c) 2015 Bedrock. All rights reserved.
//

import Darwin.POSIX.sys

struct FileManager {
	static func fileExists(path: String) -> (fileExists: Bool, isDirectory: Bool) {
		/// Path length, even after symbolic link resolution, must never exceed PATH_MAX.
		let p = path.substringToIndex(advance(path.startIndex, Int(PATH_MAX))).fileSystemRepresentation()
		var st = stat()
		// Check for a symbolic link first.
		if lstat(p, &st) < 0 {
			return (false, false)
		}

		// Don't touch symlinks.  They will expand and do terrible things sometimes.
		if st.st_mode == S_IFLNK {
			return (true, false)
		}

		// Stat a real path.
		if stat(p, &st) < 0 {
			return (false, false)
		}

		return (true, st.st_mode == S_IFDIR)
	}

	static func changeDirectory(path: String) -> Bool {
		let p = path.substringToIndex(advance(path.startIndex, Int(PATH_MAX))).fileSystemRepresentation()
		return (chdir(p) == 0)
	}

	static func contentsOfDirectory(path: String) -> [String] {
		let p = path.substringToIndex(advance(path.startIndex, Int(PATH_MAX))).fileSystemRepresentation()

		let dir : UnsafeMutablePointer<DIR> = opendir(p);
		let name_max = pathconf(p, _PC_NAME_MAX)
		let buf : UnsafeMutablePointer<dirent> = UnsafeMutablePointer<dirent>.alloc(name_max + 1)
		var de : UnsafeMutablePointer<dirent> = nil

		// We ain't takin' none of that POSIX crap
		if dir == nil || name_max == 0 || buf == nil {
			return []
		}

		var res : [String] = []
		while readdir_r(dir, buf, &de) == 0 && de != nil {
			if let name = withUnsafePointer(&de.memory.d_name, {
				return String.fromCString(UnsafePointer($0))
			}) {
				res.append(name)
			}
		}

		closedir(dir)
		return res
	}
}
