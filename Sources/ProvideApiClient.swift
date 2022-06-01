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
//  ProvideApiClient.swift
//  provide
//
//  Created by Kevin Munc on 09/19/18.
//

import Foundation
import Alamofire

public typealias PrvdApiSuccessHandler = (AnyObject?) -> Void
public typealias PrvdApiFailureHandler = (HTTPURLResponse?, AnyObject?, NSError?) -> Void

/**
 * Override in your Xcode scheme's Run arguments, if needed.
 *
 * Value should include protocol, host and optionally port for the microservice host keys.
 * Hosts must not include trailing slash nor any path.
 */
enum ApiEnvironmentVariables: String {
    case identScheme = "prvd_ident_scheme"
    case identHost = "prvd_ident_host"
    case identPort = "prvd_ident_port"
    case identVersion = "prvd_ident_version"
    case goldmineScheme = "prvd_goldmine_scheme"
    case goldmineHost = "prvd_goldmine_host"
    case goldminePort = "prvd_goldmine_port"
    case goldmineVersion = "prvd_goldmine_version"
}

enum ProvideError: Error {
    case invalidUrl(path: String)
    case unexpectedResponse(message: String)
}

open class ProvideApiClient: NSObject {
    
    private var apiToken: String = ""
    // Microservice defaults (production)
    private var identScheme = "https"
    private var goldmineScheme = "https"
    private var identHost = "ident.provide.services"
    private var goldmineHost = "goldmine.provide.services"
    private var identPort = 443
    private var goldminePort = 443
    private var identVersion = "v1"
    private var goldmineVersion = "v1"
    
    public init(_ apiToken: String = "") {
        self.apiToken = apiToken
        // Check for environment variable overrides
        if let identProtocol = ProcessInfo.processInfo.environment[ApiEnvironmentVariables.identScheme.rawValue] {
            identScheme = identProtocol
        }
        if let goldmineProtocol = ProcessInfo.processInfo.environment[ApiEnvironmentVariables.goldmineScheme.rawValue] {
            goldmineScheme = goldmineProtocol
        }
        if let identBase = ProcessInfo.processInfo.environment[ApiEnvironmentVariables.identHost.rawValue] {
            identHost = identBase
        }
        if let goldmineBase = ProcessInfo.processInfo.environment[ApiEnvironmentVariables.goldmineHost.rawValue] {
            goldmineHost = goldmineBase
        }
        if let identPortString = ProcessInfo.processInfo.environment[ApiEnvironmentVariables.identPort.rawValue],
            let identPortNumber = Int(identPortString) {
            identPort = identPortNumber
        }
        if let goldminePortString = ProcessInfo.processInfo.environment[ApiEnvironmentVariables.goldminePort.rawValue],
            let goldminePortNumber = Int(goldminePortString) {
            goldminePort = goldminePortNumber
        }
        super.init()
    }
    
    // MARK: - HTTP Verb Methods
    
    open func get(_ request: DataRequest,
                  successHandler: @escaping PrvdApiSuccessHandler,
                  failureHandler: @escaping PrvdApiFailureHandler) {
        KTApiService.shared.execute(request,
                                    successHandler: successHandler,
                                    failureHandler: failureHandler)
    }
    
    open func post(_ request: DataRequest,
                   successHandler: @escaping PrvdApiSuccessHandler,
                   failureHandler: @escaping PrvdApiFailureHandler) {
        KTApiService.shared.execute(request,
                                    successHandler: successHandler,
                                    failureHandler: failureHandler)
    }
    
    open func put(_ request: DataRequest,
                  successHandler: @escaping PrvdApiSuccessHandler,
                  failureHandler: @escaping PrvdApiFailureHandler) {
        KTApiService.shared.execute(request,
                                    successHandler: successHandler,
                                    failureHandler: failureHandler)
    }
    
    open func delete(_ request: DataRequest,
                     successHandler: @escaping PrvdApiSuccessHandler,
                     failureHandler: @escaping PrvdApiFailureHandler) {
        KTApiService.shared.execute(request,
                                    successHandler: successHandler,
                                    failureHandler: failureHandler)
    }
    
    // MARK: - Helper Methods
    
    
    open func buildIdentUrl(path: String, queryString: String? = nil, baseScheme: String? = nil, baseHost: String? = nil, hostPort: Int? = nil, apiBasePath: String? = nil) -> URL? {
        var url = URLComponents()
        if let baseScheme = baseScheme, let baseHost = baseHost {
            url.scheme = baseScheme
            url.host = baseHost
        } else {
            url.scheme = identScheme
            url.host = identHost
        }
        if let hostPort = hostPort {
            url.port = hostPort
        } else if identPort != 80 && identPort != 443 {
            url.port = identPort
        }
        if let apiBasePath = apiBasePath {
            url.path = "\(apiBasePath)\(path)"
        } else {
            url.path = "/api/\(identVersion)\(path)"
        }
        if let queryString = queryString {
            url.query = queryString
        }
        return url.url
    }
    
    open func buildGoldmineUrl(path: String, queryString: String? = nil, baseScheme: String? = nil, baseHost: String? = nil, hostPort: Int? = nil, apiBasePath: String? = nil) -> URL? {
        var url = URLComponents()
        if let baseScheme = baseScheme, let baseHost = baseHost {
            url.scheme = baseScheme
            url.host = baseHost
        } else {
            url.scheme = goldmineScheme
            url.host = goldmineHost
        }
        if let hostPort = hostPort {
            url.port = hostPort
        } else if goldminePort != 80 && goldminePort != 443 {
            url.port = goldminePort
        }
        if let apiBasePath = apiBasePath {
            url.path = "\(apiBasePath)\(path)"
        } else {
            url.path = "/api/\(goldmineVersion)\(path)"
        }
        if let queryString = queryString {
            url.query = queryString
        }
        return url.url
    }
    
    open func authHeaders() -> [String : String]? {
        if let authToken = ProvideKeychainService.shared.authToken {
            return [
                "user-agent" : "provide-swift client",
                "authorization" : "bearer \(authToken)"
            ]
        } else {
            return [
                "user-agent" : "provide-swift client",
                "token-state" : "tokens missing"
            ]
        }
    }
    
    open func apiHeaders(overriddenApiToken: String = "") -> [String : String]? {
        // Use method-injected API token, if one is given
        let givenValue = overriddenApiToken.trimmingCharacters(in: .whitespacesAndNewlines)
        if givenValue != "" {
            return [
                "user-agent" : "provide-swift client",
                "authorization" : "bearer \(givenValue)"
            ]
        }
        // Use constructor-injected API token, if present
        if self.apiToken.trimmingCharacters(in: .whitespacesAndNewlines) != "" {
            return [
                "user-agent" : "provide-swift client",
                "authorization" : "bearer \(self.apiToken)"
            ]
        }
        // else
        print("No API token available for header! Returning nil.")
        return nil
    }
    
}
