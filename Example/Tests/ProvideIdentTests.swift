//
//  ProvideIdentTests.swift
//  provide_Example
//
//  Created by Kevin Munc on 09/19/18.
//  Copyright © 2018 Provide. All rights reserved.
//

import XCTest
import provide

class ProvideIdentTests: XCTestCase {
    
    // TEST: figure out how to reduce duplication with the expectations, closures?
    
    // MARK: - Authenticate Tests
    
    func testAuthenticateSuccess() throws {
        let email = "valid@email.com"
        let stub = StubApiClient()
        let exp = expectation(description: "Completion block called")
        
        try ProvideIdent(stub).authenticate(email: email, password: "Soop3rSuhkyuur", successHandler: { (result) in
            exp.fulfill()
        }, failureHandler: { (response, result, error) in
            exp.fulfill()
            XCTFail("Request should have passed.")
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
            XCTFail("Request should have failed.")
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
    
    // MARK: - Create Application Tests
    
    func testCreateApplicatoinSuccess() throws {
        let name = "Created by a Unit Test"
        let networkId = "guid for a uuid"
        let stub = StubApiClient()
        let exp = expectation(description: "Completion block called")
        
        try ProvideIdent(stub).createApplication(name: name, networkId: networkId, successHandler: { (result) in
            exp.fulfill()
        }, failureHandler: { (response, result, error) in
            exp.fulfill()
            XCTFail("Request should have passed.")
        })
        
        waitForExpectations(timeout: 5) { (error) in
            if let error = error {
                print("Error: \(error)")
            } else {
                XCTAssertTrue(true, "There should not have been an error")
                XCTAssertNotNil(stub.mostRecentRequest)
                XCTAssertTrue(stub.mostRecentRequest!.debugDescription.contains(name))
                XCTAssertTrue(stub.mostRecentRequest!.debugDescription.contains(networkId))
            }
        }
    }
    
    func testCreateApplicationFailure() throws {
        let name = "Created by a Unit Test"
        let networkId = "guid for a uuid"
        let stub = StubApiClient()
        stub.postShouldSucceed = false
        let exp = expectation(description: "Completion block called")
        
        try ProvideIdent(stub).createApplication(name: name, networkId: networkId, successHandler: { (result) in
            exp.fulfill()
            XCTFail("Request should have failed.")
        }, failureHandler: { (response, result, error) in
            exp.fulfill()
        })
        
        waitForExpectations(timeout: 5) { (error) in
            if let error = error {
                print("Error: \(error)")
            } else {
                XCTAssertTrue(true, "There should not have been an error")
                XCTAssertNotNil(stub.mostRecentRequest)
                XCTAssertTrue(stub.mostRecentRequest!.debugDescription.contains(name))
                XCTAssertTrue(stub.mostRecentRequest!.debugDescription.contains(networkId))
            }
        }
    }
    
}
