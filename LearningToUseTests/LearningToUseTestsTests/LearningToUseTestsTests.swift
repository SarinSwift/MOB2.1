//
//  LearningToUseTestsTests.swift
//  LearningToUseTestsTests
//
//  Created by Sarin Swift on 4/8/19.
//  Copyright © 2019 sarinswift. All rights reserved.
//

import XCTest
@testable import LearningToUseTests
import UIKit

class LearningToUseTestsTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

//    func testPerformanceExample() {
//        // This is an example of a performance test case.
//        self.measure {
//            // Put the code you want to measure the time of here.
//        }
//    }

    // Test1
    func testTitle() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateInitialViewController() as! ViewController
        vc.viewDidLoad() // Need to instantiate the view so it will set the values or else
        
//        XCTAssertEqual("Practice Project", vc.title) // This would fail
        XCTAssertEqual("Testing With Swift!", vc.title) // This would pass becasue it matches the one we correctly created
    }
    
    func testTextfieldPlaceholder() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateInitialViewController() as! ViewController
        vc.viewDidLoad()
        
        XCTAssertEqual("placeholder", vc.insertNumTextField.placeholder)
    }
    
    func testNumOfVowels() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateInitialViewController() as! ViewController
        vc.viewDidLoad()
        
        XCTAssertEqual(2, vc.vowelsInAString(string: "SArIn"))
    }
    
    func testMakeTitle() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateInitialViewController() as! ViewController
        vc.viewDidLoad()
        
        XCTAssertEqual("Sarin Liking Tests", vc.makeTitle(string: "Sarin liking tests"))
    }

}
