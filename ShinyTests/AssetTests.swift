//
//  AssetTests.swift
//  ShinyTests
//
//  Created by Anton Novoselov on 19.04.2021.
//

import XCTest
@testable import Shiny

class AssetTests: XCTestCase {
    func testColorsExist() {
        for color in Project.colors {
            XCTAssertNotNil(UIColor(named: color), "Failed to load color '\(color)' from asset catalog.")
        }
    }
    
    func testJSONLoadsCorrectly() {
        XCTAssertTrue(Award.allAwards.isEmpty == false, "Failed to load awards from JSON.")
    }
}
