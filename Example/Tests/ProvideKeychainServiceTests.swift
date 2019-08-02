//
//  ProvideKeychainServiceTests.swift
//  provide_Example
//
//  Created by Kevin Munc on 09/21/18.
//  Copyright © 2018 Provide. All rights reserved.
//

import XCTest
import provide

public class ProvideKeychainServiceTests: XCTestCase {
    
    public override func setUp() {
        super.setUp()
        
        // Clean slate start.
        ProvideKeychainService.shared.clearStoredUserData()
    }
    
    public override func tearDown() {
        ProvideKeychainService.shared.clearStoredUserData()
        
        super.tearDown()
    }
    
    public func testCycle() {
        let authToken = "auth token"
        let appId = "app ID"
        let appApiToken = "app API token"
        let appWalletId = "app wallet ID"
        
        XCTAssertNil(ProvideKeychainService.shared.authToken)
        XCTAssertNil(ProvideKeychainService.shared.appId)
        XCTAssertNil(ProvideKeychainService.shared.appApiToken)
        XCTAssertNil(ProvideKeychainService.shared.appWalletId)
        
        ProvideKeychainService.shared.authToken = authToken
        ProvideKeychainService.shared.appId = appId
        ProvideKeychainService.shared.appApiToken = appApiToken
        ProvideKeychainService.shared.appWalletId = appWalletId
        
        XCTAssertNotNil(ProvideKeychainService.shared.authToken)
        XCTAssertNotNil(ProvideKeychainService.shared.appId)
        XCTAssertNotNil(ProvideKeychainService.shared.appApiToken)
        XCTAssertNotNil(ProvideKeychainService.shared.appWalletId)
        
        XCTAssertEqual(authToken, ProvideKeychainService.shared.authToken)
        XCTAssertEqual(appId, ProvideKeychainService.shared.appId)
        XCTAssertEqual(appApiToken, ProvideKeychainService.shared.appApiToken)
        XCTAssertEqual(appWalletId, ProvideKeychainService.shared.appWalletId)
    }
    
}
