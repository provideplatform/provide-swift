//
//  ProvideApiClient.swift
//  provide
//
//  Created by Kevin Munc on 09/19/18.
//

import Foundation
import Alamofire
// TODO: do we need? AlamofireObjectMapper REMOVE pod if not / if can.

public typealias PrvdApiSuccessHandler = (AnyObject?) -> Void
public typealias PrvdApiFailureHandler = (HTTPURLResponse?, AnyObject?, NSError?) -> Void

enum ProvideError: Error {
    case invalidUrl(path: String)
}

open class ProvideApiClient: NSObject {
    
    // TODO: revisit making these closures optional...
    
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
     * Note: this does *not* currently handle URL encoding of the given `path`. // TODO: address this later.
     */
    open func buildUrl(path: String, baseUrl: URL = URL(string: "https://ident.provide.services/api/v1/")!) -> URL? {
        // guard let encodedPath = path.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else { return nil }
        
        return URL(string: path, relativeTo: baseUrl)
    }
    
    // MARK: Private Methods
    
    // FIXME: implement this
    private func headers() -> Dictionary<String, String> {
        return [:]
    }
    
}
