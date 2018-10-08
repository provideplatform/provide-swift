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
    case identHost = "prvd_ident_host"
    case goldmineHost = "prvd_goldmine_host"
    case identVersion = "prvd_ident_version"
    case goldmineVersion = "prvd_goldmine_version"
}

enum ProvideError: Error {
    case invalidUrl(path: String)
    case unexpectedResponse(message: String)
}

open class ProvideApiClient: NSObject {
    
    private var apiToken: String = ""
    // Default microservice values
    private var identHost = "https://ident.provide.services"
    private var goldmineHost = "https://goldmine.provide.services"
    private var identVersion = "v1"
    private var goldmineVersion = "v1"
    
    public init(_ apiToken: String = "") {
        self.apiToken = apiToken
        // Check for environment variable overrides
        if let identBase = ProcessInfo.processInfo.environment[ApiEnvironmentVariables.identHost.rawValue] {
            identHost = identBase
        }
        if let goldmineBase = ProcessInfo.processInfo.environment[ApiEnvironmentVariables.goldmineHost.rawValue] {
            goldmineHost = goldmineBase
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
    
    open func buildIdentUrl(path: String, baseUrl: URL? = nil) -> URL? {
        // Bang this since an invalid host is a non-starter
        var hostBase = URL(string: "\(identHost)/api/\(identVersion)/")!
        if let baseUrl = baseUrl {
            // local override
            hostBase = baseUrl
        }
        return buildUrl(path: path, baseUrl: hostBase)
    }
    
    open func buildGoldmineUrl(path: String, baseUrl: URL? = nil) -> URL? {
        // Bang this since an invalid host is a non-starter
        var hostBase = URL(string: "\(goldmineHost)/api/\(goldmineVersion)/")!
        if let baseUrl = baseUrl {
            // local override
            hostBase = baseUrl
        }
        return buildUrl(path: path, baseUrl: hostBase)
    }
    
    private func buildUrl(path: String, baseUrl: URL) -> URL? {
        // TODO: guard let encodedPath = path.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else { return nil }
        
        return URL(string: path, relativeTo: baseUrl)
    }
    
    open func authHeaders() -> HTTPHeaders? { // [String : String]
        if let authToken = KeychainService.shared.authToken {
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
    
    open func apiHeaders(overrideApiToken: String = "") -> HTTPHeaders? {
        // Use method-injected API token, if one is given
        if apiToken.trimmingCharacters(in: .whitespacesAndNewlines) != "" {
            return [
                "user-agent" : "provide-swift client",
                "authorization" : "bearer \(apiToken)"
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
