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
    let applications = "applications"
    
    public init(_ client: ProvideApiClient = ProvideApiClient()) {
        self.api = client
        super.init()
    }
    
    // MARK: - Authentication Methods
    
    public func authenticate(email: String, password: String,
                             successHandler: @escaping PrvdApiSuccessHandler,
                             failureHandler: @escaping PrvdApiFailureHandler) throws {
        guard let url = api.buildIdentUrl(path: authenticate) else { throw ProvideError.invalidUrl(path: authenticate) }
        
        let request = Alamofire.request(url,
                                        method: .post,
                                        parameters: ["email": email, "password": password],
                                        encoding: JSONEncoding.prettyPrinted)
        api.post(request, successHandler: { (result) in
            if let result = result as? Data {
                let deserialized = try? JSONSerialization.jsonObject(with: result, options: .allowFragments)
                if let deserialized = deserialized as? [String : Any],
                    let topToken = deserialized["token"] as? [String : Any],
                    let tokenValue = topToken["token"] as? String {
                    KeychainService.shared.authToken = tokenValue
                    successHandler(tokenValue as AnyObject)
                } else {
                    let error = ProvideError.unexpectedResponse(message: "Unable to extract authentication token from response.")
                    failureHandler(nil, result as AnyObject, error as NSError)
                }
            } else {
                let error = ProvideError.unexpectedResponse(message: "Response data was nil or not of type Data.")
                failureHandler(nil, result as AnyObject, error as NSError)
            }
        }) { (response, result, error) in
            KeychainService.shared.clearStoredUserData()
            failureHandler(response, result, error)
        }
    }
    
    // MARK: - Application Methods
    
    public func createApplication(name: String, networkId: String,
                                  successHandler: @escaping PrvdApiSuccessHandler,
                                  failureHandler: @escaping PrvdApiFailureHandler) throws {
        guard let url = api.buildIdentUrl(path: applications) else { throw ProvideError.invalidUrl(path: applications) }

        let request = Alamofire.request(url,
                                        method: .post,
                                        parameters: ["name": name, "network_id": networkId],
                                        encoding: JSONEncoding.prettyPrinted,
                                        headers: api.headers())
        api.post(request, successHandler: { (result) in
            if let result = result as? Data {
                let deserialized = try? JSONSerialization.jsonObject(with: result, options: .allowFragments)
                if let deserialized = deserialized as? [String : Any], let appId = deserialized["id"] as? String {
                    KeychainService.shared.appId = appId
                    successHandler(deserialized as AnyObject)
                } else {
                    let error = ProvideError.unexpectedResponse(message: "Unable to extract application ID from response.")
                    failureHandler(nil, result as AnyObject, error as NSError)
                }
            } else {
                let error = ProvideError.unexpectedResponse(message: "Response data was nil or not of type Data.")
                failureHandler(nil, result as AnyObject, error as NSError)
            }
        }) { (response, result, error) in
            failureHandler(response, result, error)
        }
    }
    
    public func listApplications(successHandler: @escaping PrvdApiSuccessHandler,
                                 failureHandler: @escaping PrvdApiFailureHandler) throws {
        guard let url = api.buildIdentUrl(path: applications) else { throw ProvideError.invalidUrl(path: applications) }
        
        let request = Alamofire.request(url,
                                        method: .get,
                                        headers: api.headers())
        api.get(request, successHandler: { (result) in
            if let result = result as? Data {
                let deserialized = try? JSONSerialization.jsonObject(with: result, options: .allowFragments)
                if let deserialized = deserialized as? Array<[String : Any]> {
                    successHandler(deserialized as AnyObject)
                } else {
                    let error = ProvideError.unexpectedResponse(message: "Unable to extract list of dapps from response.")
                    failureHandler(nil, result as AnyObject, error as NSError)
                }
            } else {
                let error = ProvideError.unexpectedResponse(message: "Response data was nil or not of type Data.")
                failureHandler(nil, result as AnyObject, error as NSError)
            }
        }) { (response, result, error) in
            failureHandler(response, result, error)
        }
    }
    
}
