// Copyright 2017-2022 Provide Technologies Inc.
// 
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
// 
//     http://www.apache.org/licenses/LICENSE-2.0
// 
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

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
