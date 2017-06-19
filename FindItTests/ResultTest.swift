//
//  ResultTest.swift
//  FindItTests
//
//  Created by Eystein Bye on 19/06/2017.
//  Copyright © 2017 CoreML. All rights reserved.
//

import XCTest
import Vision

class ResultTest: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testDontKnowCase() {
        let confidence: VNConfidence = 0.05
        let object: String = "Flower"
        let result = Result.objectFromConfidence(confidence: confidence, object: object)
        
        XCTAssertEqual(result, "I don´t know what this is")
    }
    
    func testNotSureCase() {
        let confidence: VNConfidence = 0.1
        let object: String = "Flower"
        let result = Result.objectFromConfidence(confidence: confidence, object: object)
        
        XCTAssertEqual(result, "Could this be Flower?")
    }
    
    func testMustBeCase() {
        let confidence: VNConfidence = 0.4
        let object: String = "Flower"
        let result = Result.objectFromConfidence(confidence: confidence, object: object)
        
        XCTAssertEqual(result, "This must be Flower")
    }
    
    func testSureThing() {
        let confidence: VNConfidence = 0.9
        let object: String = "Flower"
        let result = Result.objectFromConfidence(confidence: confidence, object: object)
        
        XCTAssertEqual(result, "This is Flower")
    }
    
}
