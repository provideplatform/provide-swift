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
    
    public init(_ client: ProvideApiClient = ProvideApiClient()) {
        self.api = client
        super.init()
    }
    
    public func authenticate(email: String, password: String,
                             successHandler: @escaping PrvdApiSuccessHandler,
                             failureHandler: @escaping PrvdApiFailureHandler) throws {
        guard let url = api.buildUrl(path: "authenticate") else { throw ProvideError.invalidUrl(path: "authenticate") }
        
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
    
}
