//
//  KeychainServiceTests.swift
//  provide_Example
//
//  Created by Kevin Munc on 09/21/18.
//  Copyright © 2018 Provide. All rights reserved.
//

import XCTest
import provide

public class KeychainServiceTests: XCTestCase {
    
    public override func setUp() {
        super.setUp()
        
        // Clean slate start.
        KeychainService.shared.clearStoredUserData()
    }
    
    public override func tearDown() {
        KeychainService.shared.clearStoredUserData()
        
        super.tearDown()
    }
    
    public func testCycle() {
        let authToken = "auth token"
        let appId = "app ID"
        let appApiToken = "app API token"
        let appWalletId = "app wallet ID"
        
        XCTAssertNil(KeychainService.shared.authToken)
        XCTAssertNil(KeychainService.shared.appId)
        XCTAssertNil(KeychainService.shared.appApiToken)
        XCTAssertNil(KeychainService.shared.appWalletId)
        
        KeychainService.shared.authToken = authToken
        KeychainService.shared.appId = appId
        KeychainService.shared.appApiToken = appApiToken
        KeychainService.shared.appWalletId = appWalletId
        
        XCTAssertNotNil(KeychainService.shared.authToken)
        XCTAssertNotNil(KeychainService.shared.appId)
        XCTAssertNotNil(KeychainService.shared.appApiToken)
        XCTAssertNotNil(KeychainService.shared.appWalletId)
        
        XCTAssertEqual(authToken, KeychainService.shared.authToken)
        XCTAssertEqual(appId, KeychainService.shared.appId)
        XCTAssertEqual(appApiToken, KeychainService.shared.appApiToken)
        XCTAssertEqual(appWalletId, KeychainService.shared.appWalletId)
    }
    
}
