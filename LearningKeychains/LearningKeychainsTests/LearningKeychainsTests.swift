//
//  LearningKeychainsTests.swift
//  LearningKeychainsTests
//
//  Created by Sarin Swift on 4/29/19.
//  Copyright © 2019 sarinswift. All rights reserved.
//

import XCTest
import KeychainSwift

@testable import LearningKeychains

class LearningKeychainsTests: XCTestCase {
    
    let keychain = KeychainSwift()

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // GIVEN
        keychain.set("Red", forKey: "setID")
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testKeychainGet() {
        // Test if retrieving a value with Keychain works.
        
        // WHEN and THEN
        XCTAssertEqual(keychain.get("setID"), "Red")
    }
    
    func testKeychainDelete() {
        // Test if deleting a value with Keychain works.
        
        keychain.delete("setID")
        XCTAssertEqual(keychain.get("setID"), nil)
    }
    
    func testKeychainUpdate() {
        // Test if updating a value with Keychain works, you will need an initial value and compare the new value with the old one.
        
        keychain.set("Blueee", forKey: "setID")
        XCTAssertEqual(keychain.get("setID"), "Blueee")
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
