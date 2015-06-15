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
    func testExample() {
        let color = Color(red: 0, green: 0, blue: 0, alpha: 0)
        XCTAssertEqual(color.redComponent, 0, "IDEK") //Example
    }
    
    func testHexInit() {
        scope {
            let color = Color(hex: 0xFFFFFF0)
            XCTAssertTrue(color == nil, "Hex init should be nil with out-of-range input") //XCTAssertNil doesn't work with structs
        }
        
        scope {
            let color = Color(hex: 0xFFFFFF)
            XCTAssertTrue(color != nil, "Should form from hex properly")
            let (r,g,b,a) = color!.colorsA()
            XCTAssertEqual(r == g, b == a)
            XCTAssertEqual(r, 1.0)

        }
                
        scope {
            let color = Color(hex: 0x000000)
            XCTAssertTrue(color != nil, "Should form from hex properly")
            let (r2,g2,b2,a2) = color!.colorsA()
            XCTAssertEqual(r2 == g2, g2 == b2)
            XCTAssertEqual(r2, 0)
            XCTAssertEqual(a2, 1)
        }
        
    }

}

func scope(x: Void -> Void) {
    x()
}