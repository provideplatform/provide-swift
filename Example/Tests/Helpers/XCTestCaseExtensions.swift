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
    
    func unexpectedPass(_ expectation: XCTestExpectation, file: StaticString = #file, line: UInt = #line) {
        expectation.fulfill()
        XCTFail("Request should have failed", file: file, line: line)
    }
    
    func expectedFail(_ expectation: XCTestExpectation) {
        expectation.fulfill()
    }
    
    func unexpectedFail(_ expectation: XCTestExpectation, file: StaticString = #file, line: UInt = #line) {
        expectation.fulfill()
        XCTFail("Request should have passed.", file: file, line: line)
    }
    
}
