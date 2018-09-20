//
//  ProvideIdent.swift
//  provide
//
//  Created by Kevin Munc on 09/19/18.
//

import Foundation
import Alamofire

public class ProvideIdent: NSObject {
    
    private let api: ProvideApiClient
    
    // API Paths
    // TODO: Consider making these enum cases (a la Moya?)
    let authenticate = "authenticate"
    let createAppication = "applications"
    
    public init(_ client: ProvideApiClient = ProvideApiClient()) {
        self.api = client
        super.init()
    }
    
    public func authenticate(email: String, password: String,
                             successHandler: @escaping PrvdApiSuccessHandler,
                             failureHandler: @escaping PrvdApiFailureHandler) throws {
        guard let url = api.buildIdentUrl(path: authenticate) else { throw ProvideError.invalidUrl(path: authenticate) }
        
        let request = Alamofire.request(url,
                                        method: .post,
                                        parameters: ["email": email, "password": password],
                                        encoding: JSONEncoding.prettyPrinted,
                                        headers: nil)
        api.post(request, successHandler: { (result) in
            successHandler(result)
        }) { (response, result, error) in
            failureHandler(response, result, error)
        }
    }
    
    public func createApplication(name: String, networkId: String,
                                  successHandler: @escaping PrvdApiSuccessHandler,
                                  failureHandler: @escaping PrvdApiFailureHandler) throws {
        guard let url = api.buildIdentUrl(path: createAppication) else { throw ProvideError.invalidUrl(path: createAppication) }

        let request = Alamofire.request(url,
                                        method: .post,
                                        parameters: ["name": name, "network_id": networkId],
                                        encoding: JSONEncoding.prettyPrinted,
                                        headers: nil)
        api.post(request, successHandler: { (result) in
            successHandler(result)
        }) { (response, result, error) in
            failureHandler(response, result, error)
        }
    }
    
}
