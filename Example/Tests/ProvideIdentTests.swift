//
//  ProvideIdentTests.swift
//  provide_Example
//
//  Created by Kevin Munc on 09/19/18.
//  Copyright © 2018 Provide. All rights reserved.
//

import XCTest
import provide
@testable import provide_Example

class ProvideIdentTests: XCTestCase {
    
    // MARK: - Authenticate Tests
    
    func testAuthenticateSuccess() throws {
        let email = "valid@email.com"
        let stub = StubApiClient()
        let exp = expectation(description: "Completion block called")
        
        try ProvideIdent(stub).authenticate(email: email, password: "Soop3rSuhkyuur", successHandler: { (result) in
            exp.fulfill()
        }, failureHandler: { (response, result, error) in
            exp.fulfill()
            XCTFail("Authentication should have passed.")
        })
        
        waitForExpectations(timeout: 5) { (error) in
            if let error = error {
                print("Error: \(error)")
            } else {
                XCTAssertTrue(true, "There should not have been an error")
                XCTAssertNotNil(stub.mostRecentRequest)
                XCTAssertTrue(stub.mostRecentRequest!.debugDescription.contains(email))
            }
        }
    }
    
    func testAuthenticateFailure() throws {
        let email = "nope@noway.not"
        let stub = StubApiClient()
        stub.postShouldSucceed = false
        let exp = expectation(description: "Completion block called")
        
        try ProvideIdent(stub).authenticate(email: email, password: "S3cr3tTurk3y!", successHandler: { (result) in
            exp.fulfill()
            XCTFail("Authentication should have failed.")
        }, failureHandler: { (response, result, error) in
            exp.fulfill()
        })
        
        waitForExpectations(timeout: 5) { (error) in
            if let error = error {
                print("Error: \(error)")
            } else {
                XCTAssertTrue(true, "There should not have been an error")
                XCTAssertNotNil(stub.mostRecentRequest)
                XCTAssertTrue(stub.mostRecentRequest!.debugDescription.contains(email))
            }
        }
    }
    
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
