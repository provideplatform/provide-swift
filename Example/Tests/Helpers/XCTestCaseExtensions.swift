//
//  XCTestCaseExtensions.swift
//  provide_Tests
//
//  Created by Kevin Munc on 09/20/18.
//  Copyright © 2018 Provide. All rights reserved.
//

import XCTest

extension XCTestCase {
    
    // MARK: - Expectation Helpers
    
    func expectedPass(_ expectation: XCTestExpectation) {
        expectation.fulfill()
    }
    
    func unexpectedPass(_ expectation: XCTestExpectation) {
        expectation.fulfill()
        XCTFail("Request should have failed.")
    }
    
    func expectedFail(_ expectation: XCTestExpectation) {
        expectation.fulfill()
    }
    
    func unexpectedFail(_ expectation: XCTestExpectation) {
        expectation.fulfill()
        XCTFail("Request should have passed.")
    }
    
}
