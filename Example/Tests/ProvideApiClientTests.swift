//
//  ProvideApiClientTests.swift
//  provide_Tests
//
//  Created by Kevin Munc on 09/20/18.
//  Copyright © 2018 Provide. All rights reserved.
//

import XCTest
import provide
// @testable import provide_Example

class ProvideApiClientTests: XCTestCase {

    // MARK: - Helper Tests
    
    func testBuildUrl() {
        performTestForBuildUrl(path: "path-to-resource")
    }
    
    func testBuildUrlWithQueryString() {
        performTestForBuildUrl(path: "path-to-resource?key=value&with=a%20space")
    }
    
    func testBuildUrlWithUnescapedQueryString() {
        let base = URL(string: "https://sub.domain.tld/")
        XCTAssertNotNil(base)
        let path = "path-to-resource?key=value&with=a space" // "path-to-✊🦃👀"
        let result = ProvideApiClient().buildUrl(path: path, baseUrl: base!)
        // TEST: update once conditional URL encoding is supported: XCTAssertEqual(result?.absoluteString, "\(base!)\(path)")
        XCTAssertNil(result)
    }
    
    // MARK: - Helper Methods
    
    func performTestForBuildUrl(path: String, function: String = #function, line: Int = #line) {
        let base = URL(string: "https://sub.domain.tld/")
        XCTAssertNotNil(base)
        let result = ProvideApiClient().buildUrl(path: path, baseUrl: base!)
        XCTAssertEqual(result?.absoluteString, "\(base!)\(path)")
    }

}
