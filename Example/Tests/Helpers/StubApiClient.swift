//
//  StubApiClient.swift
//  provide_Example
//
//  Created by Kevin Munc on 09/20/18.
//  Copyright © 2018 Provide. All rights reserved.
//

import Provide
import Alamofire
class StubApiClient: ProvideApiClient {
    
    var mostRecentRequest: DataRequest?
    
    // Get Stubs
    var getShouldBeOverriden = true
    var getShouldSucceed = true
    var getSuccessResult: AnyObject?
    var getFailureResponse: HTTPURLResponse?
    var getFailureResult: AnyObject?
    var getFailureError: NSError?
    
    // Post Stubs
    var postShouldBeOverriden = true
    var postShouldSucceed = true
    var postSuccessResult: AnyObject?
    var postFailureResponse: HTTPURLResponse?
    var postFailureResult: AnyObject?
    var postFailureError: NSError?
    
    // Put Stubs
    var putShouldBeOverriden = true
    var putShouldSucceed = true
    var putSuccessResult: AnyObject?
    var putFailureResponse: HTTPURLResponse?
    var putFailureResult: AnyObject?
    var putFailureError: NSError?
    
    // Delete Stubs
    var deleteShouldBeOverriden = true
    var deleteShouldSucceed = true
    var deleteSuccessResult: AnyObject?
    var deleteFailureResponse: HTTPURLResponse?
    var deleteFailureResult: AnyObject?
    var deleteFailureError: NSError?
    
    // MARK: - Overriden Methods with Stubbing
    //         (and where is metaprogramming when I need it?)
    
    override func get(_ request: DataRequest,
                      successHandler: @escaping PrvdApiSuccessHandler,
                      failureHandler: @escaping PrvdApiFailureHandler) {
        mostRecentRequest = request
        
        if !getShouldBeOverriden {
            super.get(request, successHandler: successHandler, failureHandler: failureHandler)
            return
        }
        
        if getShouldSucceed {
            successHandler(getSuccessResult)
        } else {
            failureHandler(getFailureResponse, getFailureResult, getFailureError)
        }
    }
    
    override func post(_ request: DataRequest,
                       successHandler: @escaping PrvdApiSuccessHandler,
                       failureHandler: @escaping PrvdApiFailureHandler) {
        mostRecentRequest = request
        
        if !postShouldBeOverriden {
            super.post(request, successHandler: successHandler, failureHandler: failureHandler)
            return
        }
        
        if postShouldSucceed {
            successHandler(postSuccessResult)
        } else {
            failureHandler(postFailureResponse, postFailureResult, postFailureError)
        }
    }
    
    override func put(_ request: DataRequest,
                      successHandler: @escaping PrvdApiSuccessHandler,
                      failureHandler: @escaping PrvdApiFailureHandler) {
        mostRecentRequest = request
        
        if !putShouldBeOverriden {
            super.put(request, successHandler: successHandler, failureHandler: failureHandler)
            return
        }
        
        if putShouldSucceed {
            successHandler(putSuccessResult)
        } else {
            failureHandler(putFailureResponse, putFailureResult, putFailureError)
        }
    }
    
    override func delete(_ request: DataRequest,
                         successHandler: @escaping PrvdApiSuccessHandler,
                         failureHandler: @escaping PrvdApiFailureHandler) {
        mostRecentRequest = request
        
        if !deleteShouldBeOverriden {
            super.delete(request, successHandler: successHandler, failureHandler: failureHandler)
            return
        }
        
        if deleteShouldSucceed {
            successHandler(deleteSuccessResult)
        } else {
            failureHandler(deleteFailureResponse, deleteFailureResult, deleteFailureError)
        }
    }
    
}
