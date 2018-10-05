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

enum ProvideError: Error {
    case invalidUrl(path: String)
    case unexpectedResponse(message: String)
}

open class ProvideApiClient: NSObject {
    
    private var apiToken: String = ""
    
    public init(_ apiToken: String = "") {
        self.apiToken = apiToken
        super.init()
    }
    
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
    
    /**
     * Note: these do *not* currently handle URL encoding of the given `path`.
     */
    open func buildIdentUrl(path: String, baseUrl: URL = URL(string: "https://ident.provide.services/api/v1/")!) -> URL? {
        return buildUrl(path: path, baseUrl: baseUrl)
    }
    
    open func buildGoldmineUrl(path: String, baseUrl: URL = URL(string: "https://goldmine.provide.services/api/v1/")!) -> URL? {
        return buildUrl(path: path, baseUrl: baseUrl)
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
