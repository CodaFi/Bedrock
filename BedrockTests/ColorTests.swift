//
//  ColorTests.swift
//  Bedrock
//
//  Created by Robert S Mozayeni on 6/12/15.
//  Copyright (c) 2015 Robert Mozayeni. All rights reserved.
//

import XCTest
import Bedrock

class ColorTests: XCTestCase {
    func testColor() {
        let color = Color(red: 0, green: 0, blue: 0, alpha: 0)
        XCTAssertEqual(color.redComponent, 0, "IDEK") //Example
    }

}
