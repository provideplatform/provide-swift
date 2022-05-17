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
//  ProvideKeychainService.swift
//  provide
//
//  Created by Kevin Munc on 09/20/18.
//

import Foundation
import UICKeyChainStore

open class ProvideKeychainService {
    
    public static let shared = ProvideKeychainService()
    private let uicStore = UICKeyChainStore()
    
    private let authTokenKey = "auth-token"
    // NOTE: just supporting a single dapp's API token and wallet signing identity at a time for now.
    private let appIdTokenKey = "app-identifier"
    private let appApiTokenKey = "api-token"
    private let appAccountIdKey = "account-identifier"
    private let appWalletIdKey = "wallet-identifier"

    private var cachedAuthToken: String?
    private var cachedAppId: String?
    private var cachedAppApiToken: String?
    private var cachedAppAccountId: String?
    private var cachedAppWalletId: String?
    
    subscript(key: String) -> String? {
        get {
            return uicStore[key]
        }
        set {
            uicStore[key] = newValue
        }
    }
    
    public var authToken: String? {
        get {
            if let token = cachedAuthToken {
                return token
            } else if let tokenString = self[authTokenKey] {
                cachedAuthToken = tokenString
                return cachedAuthToken
            } else {
                return nil
            }
        }
        set {
            self[authTokenKey] = newValue
            cachedAuthToken = nil
        }
    }
    
    public var appId: String? {
        get {
            if let identifier = cachedAppId {
                return identifier
            } else if let appIdString = self[appIdTokenKey] {
                cachedAppId = appIdString
                return cachedAppId
            } else {
                return nil
            }
        }
        set {
            self[appIdTokenKey] = newValue
            cachedAppId = nil
        }
    }
    
    public var appApiToken: String? {
        get {
            if let token = cachedAppApiToken {
                return token
            } else if let tokenString = self[appApiTokenKey] {
                cachedAppApiToken = tokenString
                return cachedAppApiToken
            } else {
                return nil
            }
        }
        set {
            self[appApiTokenKey] = newValue
            cachedAppApiToken = nil
        }
    }
    
    public var appAccountId: String? {
        get {
            if let identifier = cachedAppAccountId {
                return identifier
            } else if let accountIdString = self[appAccountIdKey] {
                cachedAppAccountId = accountIdString
                return cachedAppAccountId
            } else {
                return nil
            }
        }
        set {
            self[appAccountIdKey] = newValue
            cachedAppAccountId = nil
        }
    }
    
    public var appWalletId: String? {
        get {
            if let identifier = cachedAppWalletId {
                return identifier
            } else if let walletIdString = self[appWalletIdKey] {
                cachedAppWalletId = walletIdString
                return cachedAppWalletId
            } else {
                return nil
            }
        }
        set {
            self[appWalletIdKey] = newValue
            cachedAppWalletId = nil
        }
    }
    
    public func clearStoredUserData() {
        authToken = nil
        appId = nil
        appApiToken = nil
        appAccountId = nil
        appWalletId = nil
        
        uicStore.removeAllItems()
    }

}
