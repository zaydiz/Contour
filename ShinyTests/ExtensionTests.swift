//
//  ExtensionTests.swift
//  ShinyTests
//
//  Created by Anton Novoselov on 20.04.2021.
//

import XCTest
import SwiftUI
@testable import Shiny

class ExtensionTests: XCTestCase {
    
    func testBundleDecodingAwards() {
        let awards = Bundle.main.decode([Award].self, from: "Awards.json")
        XCTAssertFalse(awards.isEmpty, "Awards.json should decode to a non-empty array.")
    }
    
    func testDecodingString() {
        let bundle = Bundle(for: ExtensionTests.self)
        let data = bundle.decode(String.self, from: "DecodableString.json")
        XCTAssertEqual(data, "The rain in Spain falls mainly on the Spaniards.", "The string must match the content of DecodableString.json.")
    }
    
    func testDecodingDictionary() {
        let bundle = Bundle(for: ExtensionTests.self)
        let data = bundle.decode([String: Int].self, from: "DecodableDictionary.json")
        XCTAssertEqual(data.count, 3, "There should be three items decoded from DecodableDictionary.json.")
        XCTAssertEqual(data["One"], 1, "The dictionary should contain Int to String mappings.")
    }
    
    func testBindingOnChange() {
        // Given
        var onChangeFunctionRun = false

        func exampleFunctionToCall() {
            onChangeFunctionRun = true
        }

        var storedValue = ""

        let binding = Binding(
            get: { storedValue },
            set: { storedValue = $0 }
        )

        let changedBinding = binding.onChange(exampleFunctionToCall)

        // When
        changedBinding.wrappedValue = "Test"

        // Then
        XCTAssertTrue(onChangeFunctionRun, "The onChange() function was not run.")
    }
    
    
}
