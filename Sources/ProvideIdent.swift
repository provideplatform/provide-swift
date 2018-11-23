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
    // SUGGEST: Consider making these enum cases (a la Moya?)
    let authenticate = "/authenticate"
    let applications = "/applications"
    let tokens = "/tokens"
    let users = "/users"
    
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
                                        encoding: JSONEncoding.prettyPrinted,
                                        headers: ["user-agent" : "provide-swift client"])
        api.post(request, successHandler: { (result) in
            if let result = result as? Data {
                let deserialized = try? JSONSerialization.jsonObject(with: result, options: .allowFragments)
                if let deserialized = deserialized as? [String : Any],
                    let topToken = deserialized["token"] as? [String : Any],
                    let tokenValue = topToken["token"] as? String {
                    ProvideKeychainService.shared.authToken = tokenValue
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
            ProvideKeychainService.shared.clearStoredUserData()
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
                                        headers: api.authHeaders())
        api.post(request, successHandler: { (result) in
            if let result = result as? Data {
                let deserialized = try? JSONSerialization.jsonObject(with: result, options: .allowFragments)
                if let deserialized = deserialized as? [String : Any], let appId = deserialized["id"] as? String {
                    ProvideKeychainService.shared.appId = appId
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
                                        headers: api.authHeaders())
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
    
    public func updateApplication(parameters: Parameters,
                                  successHandler: @escaping PrvdApiSuccessHandler,
                                  failureHandler: @escaping PrvdApiFailureHandler) throws {
        guard let url = api.buildIdentUrl(path: applications) else { throw ProvideError.invalidUrl(path: applications) }
        
        let request = Alamofire.request(url,
                                        method: .put,
                                        parameters: parameters,
                                        encoding: JSONEncoding.prettyPrinted,
                                        headers: api.authHeaders())
        api.put(request, successHandler: { (result) in
            successHandler(result as AnyObject)
        }) { (response, result, error) in
            failureHandler(response, result, error)
        }
    }
    
    public func fetchApplicationDetails(appId: String,
                                        successHandler: @escaping PrvdApiSuccessHandler,
                                        failureHandler: @escaping PrvdApiFailureHandler) throws {
        let compoundPath = "\(applications)/\(appId)"
        guard let url = api.buildIdentUrl(path: compoundPath) else { throw ProvideError.invalidUrl(path: compoundPath) }
        
        let request = Alamofire.request(url,
                                        method: .get,
                                        headers: api.authHeaders())
        api.get(request, successHandler: { (result) in
            successHandler(result as AnyObject)
        }) { (response, result, error) in
            failureHandler(response, result, error)
        }
    }
    
    // MARK: - Token Methods
    
    public func listApplicationTokens(appId: String,
                                      successHandler: @escaping PrvdApiSuccessHandler,
                                      failureHandler: @escaping PrvdApiFailureHandler) throws {
        let compoundPath = "\(applications)/\(appId)/tokens"
        guard let url = api.buildIdentUrl(path: compoundPath) else { throw ProvideError.invalidUrl(path: compoundPath) }
        
        let request = Alamofire.request(url,
                                        method: .get,
                                        headers: api.authHeaders())
        api.get(request, successHandler: { (result) in
            successHandler(result as AnyObject)
        }) { (response, result, error) in
            failureHandler(response, result, error)
        }
    }
    
    public func listTokens(parameters: Parameters,
                           successHandler: @escaping PrvdApiSuccessHandler,
                           failureHandler: @escaping PrvdApiFailureHandler) throws {
        guard let url = api.buildIdentUrl(path: tokens) else { throw ProvideError.invalidUrl(path: tokens) }
        
        let request = Alamofire.request(url,
                                        method: .get,
                                        parameters: parameters,
                                        encoding: JSONEncoding.prettyPrinted,
                                        headers: api.authHeaders())
        api.get(request, successHandler: { (result) in
            successHandler(result as AnyObject)
        }) { (response, result, error) in
            failureHandler(response, result, error)
        }
    }
    
    public func fetchTokensDetails(tokenId: String,
                                   successHandler: @escaping PrvdApiSuccessHandler,
                                   failureHandler: @escaping PrvdApiFailureHandler) throws {
        let compoundPath = "\(tokens)/\(tokenId)"
        guard let url = api.buildIdentUrl(path: compoundPath) else { throw ProvideError.invalidUrl(path: compoundPath) }
        
        let request = Alamofire.request(url,
                                        method: .get,
                                        headers: api.authHeaders())
        api.get(request, successHandler: { (result) in
            successHandler(result as AnyObject)
        }) { (response, result, error) in
            failureHandler(response, result, error)
        }
    }
    
    public func deleteToken(tokenId: String,
                            successHandler: @escaping PrvdApiSuccessHandler,
                            failureHandler: @escaping PrvdApiFailureHandler) throws {
        let compoundPath = "\(tokens)/\(tokenId)"
        guard let url = api.buildIdentUrl(path: compoundPath) else { throw ProvideError.invalidUrl(path: compoundPath) }
        
        let request = Alamofire.request(url,
                                        method: .delete,
                                        headers: api.authHeaders())
        api.delete(request, successHandler: { (result) in
            successHandler(result as AnyObject)
        }) { (response, result, error) in
            failureHandler(response, result, error)
        }
    }
    
    // MARK: - User Methods
    
    public func createUser(parameters: Parameters,
                           successHandler: @escaping PrvdApiSuccessHandler,
                           failureHandler: @escaping PrvdApiFailureHandler) throws {
        guard let url = api.buildIdentUrl(path: users) else { throw ProvideError.invalidUrl(path: users) }
        
        let request = Alamofire.request(url,
                                        method: .post,
                                        parameters: parameters,
                                        encoding: JSONEncoding.prettyPrinted,
                                        headers: api.authHeaders())
        api.post(request, successHandler: { (result) in
            successHandler(result as AnyObject)
        }) { (response, result, error) in
            failureHandler(response, result, error)
        }
    }
    
    public func listUsers(successHandler: @escaping PrvdApiSuccessHandler,
                          failureHandler: @escaping PrvdApiFailureHandler) throws {
        guard let url = api.buildIdentUrl(path: users) else { throw ProvideError.invalidUrl(path: users) }
        
        let request = Alamofire.request(url,
                                        method: .get,
                                        headers: api.authHeaders())
        api.get(request, successHandler: { (result) in
            successHandler(result as AnyObject)
        }) { (response, result, error) in
            failureHandler(response, result, error)
        }
    }
    
    public func fetchUserDetails(userId: String,
                                 successHandler: @escaping PrvdApiSuccessHandler,
                                 failureHandler: @escaping PrvdApiFailureHandler) throws {
        let compoundPath = "\(users)/\(userId)"
        guard let url = api.buildIdentUrl(path: compoundPath) else { throw ProvideError.invalidUrl(path: compoundPath) }
        
        let request = Alamofire.request(url,
                                        method: .get,
                                        headers: api.authHeaders())
        api.get(request, successHandler: { (result) in
            successHandler(result as AnyObject)
        }) { (response, result, error) in
            failureHandler(response, result, error)
        }
    }
    
    public func updateUser(userId: String,
                           parameters: Parameters, 
                           successHandler: @escaping PrvdApiSuccessHandler,
                           failureHandler: @escaping PrvdApiFailureHandler) throws {
        let compoundPath = "\(users)/\(userId)"
        guard let url = api.buildIdentUrl(path: compoundPath) else { throw ProvideError.invalidUrl(path: compoundPath) }
        
        let request = Alamofire.request(url,
                                        method: .put,
                                        parameters: parameters,
                                        encoding: JSONEncoding.prettyPrinted,
                                        headers: api.authHeaders())
        api.put(request, successHandler: { (result) in
            successHandler(result as AnyObject)
        }) { (response, result, error) in
            failureHandler(response, result, error)
        }
    }
    
}
