//
//  KeyChainService.swift
//  provide
//
//  Created by Kevin Munc on 09/20/18.
//

import Foundation
import UICKeyChainStore

// TODO: bolster this; look at removing the 3rd party dependency.
class KeyChainService {
    
    static let shared = KeyChainService()
    private let uicStore = UICKeyChainStore()
    
    private let authTokenKey = "auth-token"
    // NOTE: just supporting a single dapp's API token and wallet signing identity at a time for now. 
    private let appApiTokenKey = "api-token"
    private let appWalletIdKey = "wallet-identifier"
    
    private var cachedAuthToken: String? // TODO: rename to authToken
    private var cachedAppApiToken: String?
    private var cachedAppWalletId: String?
    
    subscript(key: String) -> String? {
        get {
            return uicStore[key]
        }
        set {
            uicStore[key] = newValue
        }
    }
    
    var authToken: String? {
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
    
    var appApiToken: String? {
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
    
    var appWalletId: String? {
        get {
            if let walletId = cachedAppWalletId {
                return walletId
            } else if let tokenString = self[appWalletIdKey] {
                cachedAppWalletId = tokenString
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
    
    
    func clearStoredUserData() {
        authToken = nil
        appApiToken = nil
        appWalletId = nil
        
        uicStore.removeAllItems()
    }

}
