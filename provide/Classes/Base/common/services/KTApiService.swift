//
//  KTApiService.swift
//  KTSwiftExtensions
//
//  Created by Kyle Thomas on 7/9/16.
//  Copyright © 2016 Kyle Thomas. All rights reserved.
//

import Foundation

import Alamofire
import AlamofireObjectMapper
import ObjectMapper

public typealias KTApiSuccessHandler = (AnyObject?) -> Void
public typealias KTApiFailureHandler = (HTTPURLResponse?, AnyObject?, NSError?) -> Void

public class KTApiService: NSObject {
    public static let shared = KTApiService()

    private var dispatchQueue: DispatchQueue!

    public required override init() {
        super.init()

        dispatchQueue = DispatchQueue(label: "api.dispatchQueue", attributes: .concurrent)
    }

    public func objectClassForPath(_ path: String) -> AnyClass? {
        var path = path
        let parts = path.split(separator: "/").map { String($0) }
        if parts.count > 5 {
            path = [parts[3], parts[5]].joined(separator: "/")
            path = path.components(separatedBy: "/").last!
        } else if parts.count > 3 {
            path = [parts[1], parts[3]].joined(separator: "/")
            path = path.components(separatedBy: "/").last!
        } else {
            path = parts[1]
        }
        if path =~ "^(.*)s$" {
            path = String(path.prefix(upTo: path.index(before: path.endIndex)))
        }

        let targetName = Bundle.main.infoDictionary?["CFBundleName"] ?? ""
        return NSClassFromString("\(targetName).\(path.capitalized)")
    }

    public func execute(_ request: DataRequest, successHandler: @escaping KTApiSuccessHandler, failureHandler: @escaping KTApiFailureHandler) {
        request.responseJSON(queue: dispatchQueue) { response in
            let error = response.result.error

            if error == nil {
                let statusCode = response.response!.statusCode
                let requestDurationMillis = response.timeline.requestDuration * 1000.0
                logInfo("Network request successful [status: \(statusCode); request duration: \(requestDurationMillis)ms; total duration: \(requestDurationMillis)]:\n\(request)")

                if let value = response.result.value {
                    if statusCode == 204 {
                        DispatchQueue.main.async {
                            successHandler(nil)
                        }
                        return
                    }

                    if let clazz = self.objectClassForPath(request.request?.url?.path ?? "") as? KTModel.Type {
                        var obj: AnyObject?

                        if statusCode < 300 {
                            if let val = value as? [String: AnyObject] {
                                let map = Map(mappingType: .fromJSON, JSON: val, toObject: true, context: nil)
                                obj = clazz.init()
                                (obj as! KTModel).mapping(map: map)
                            } else if let val = value as? [[String: AnyObject]] {
                                var objects = [KTModel]()
                                for v in val {
                                    let map = Map(mappingType: .fromJSON, JSON: v, toObject: true, context: nil)
                                    let objInstance = clazz.init()
                                    objInstance.mapping(map: map)
                                    objects.append(objInstance)
                                }
                                obj = objects as AnyObject
                            }

                            DispatchQueue.main.async {
                                successHandler(obj)
                            }
                        } else {
                            logWarn("Parsed response with \(statusCode) status code")

                            switch statusCode {
                            case 401:
                                KTNotificationCenter.post(name: .ApplicationUserShouldLogout)

                            default:
                                break
                            }

                            if let val = value as? [String: AnyObject] {
                                let map = Map(mappingType: .fromJSON, JSON: val, toObject: true, context: nil)
                                obj = KTError()
                                (obj as! KTModel).mapping(map: map)

                                log("\(statusCode) response included error payload:\n\(String(describing: (obj as! KTModel).toJSONString()))")
                            }

                            DispatchQueue.main.async {
                                failureHandler(response.response, obj, nil)
                            }
                        }
                    } else {
                        request.responseData { dataResponse in
                            if statusCode < 300 {
                                DispatchQueue.main.async {
                                    successHandler(dataResponse.result.value as AnyObject?)
                                }
                            } else {
                                logWarn("Parsed data response with \(statusCode) status code")
                                DispatchQueue.main.async {
                                    failureHandler(dataResponse.response, nil, nil)
                                }
                            }
                        }
                    }
                }
            } else if let error = error as NSError? {
                if error.code == -6006 {
                    request.responseData { dataResponse in
                        let statusCode = dataResponse.response!.statusCode

                        if statusCode < 300 {
                            DispatchQueue.main.async {
                                successHandler(dataResponse.result.value as AnyObject?)
                            }
                        } else {
                            logWarn("Parsed data response with \(statusCode) status code")
                            DispatchQueue.main.async {
                                failureHandler(dataResponse.response, nil, nil)
                            }
                        }
                    }
                } else {
                    logWarn("Error with network request:\n\(request); \(error); retrying...")
                    self.execute(Alamofire.request(request.request!), successHandler: successHandler, failureHandler: failureHandler)
                }
            }
        }
    }
}

extension NSNotification.Name {
    static let ApplicationUserShouldLogout = NSNotification.Name("ApplicationUserShouldLogout")
    static let ApplicationWillRequestMediaAuthorization = Notification.Name("ApplicationWillRequestMediaAuthorization")
}
