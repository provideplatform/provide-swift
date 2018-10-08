//
//  ViewController.swift
//  provide
//
//  Created by kthomas on 09/18/2018.
//  Copyright (c) 2018 kthomas. All rights reserved.
//

import UIKit
import Provide

class ViewController: UIViewController {
    
    var networkId: String!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let storedNetworkId = UserDefaults.standard.object(forKey: networkIdKey) as? String {
            networkId = storedNetworkId
        }
        getApplications()
    }
    
    // MARK: - Private Methods
    
    private func getApplications() {
        try? ProvideIdent().listApplications(successHandler: { [weak self] (result) in
            if let result = result as? Array<[String : Any]> {
                print("PRVD: This network has \(result.count) applications")
                print("PRVD: first application: \(result.first!)")
                if let app = result.first, let appId = app["id"] as? String {
                    print("PRVD: Storing application ID: \(appId)")
                    UserDefaults.standard.set(appId, forKey: applicationIdKey)
                    self?.getAppApiTokens()
                } else {
                    print("PRVD: Unable to parse out the first application")
                }
            } else {
                print("PRVD: Unexpected data result = \(String(describing: result))")
            }
        }) { (response, result, error) in
            print("PRVD: Error = \(String(describing: error))")
        }
    }
    
    private func getAppApiTokens() {
        guard let appId = UserDefaults.standard.object(forKey: applicationIdKey) as? String else { return }
        
        try? ProvideIdent().listApplicationTokens(appId: appId, successHandler: { [weak self] (result) in
            if let result = result as? Data {
                let deserialized = try? JSONSerialization.jsonObject(with: result, options: .allowFragments)
                if let deserialized = deserialized as? Array<[String : Any]> {
                    print("PRVD: This app has \(deserialized.count) api tokens")
                    if let tokenDict = deserialized.first, let token = tokenDict["token"] as? String {
                        print("PRVD: Storing application API token: \(token)")
                        ProvideKeychainService.shared.appApiToken = token
                        self?.doEverythingElse()
                    } else {
                        print("PRVD: Unable to parse out the first application")
                    }
                } else {
                    print("PRVD: Unexpected result = \(result)")
                }
            } else {
                print("PRVD: Unexpected data result = \(String(describing: result))")
            }
        }) { (response, result, error) in
            print("PRVD: Error = \(String(describing: error))")
        }
    }
    
    private func doEverythingElse() {
//        processNetworkStatus()
        processNetworkTokens()
        processNetworkTransactions()
        processNetworkNodes()
        /** 501: Not Implemented:
        processNetworkBlocks()
        processNetworkBridges()
        processNetworkOracles()
        */
//        executeContract()
    }
    
    private func processNetworkStatus() {
        try? ProvideGoldmine(apiClient()).fetchNetworkStatus(networkId: networkId, successHandler: { (result) in
            if let result = result as? Data {
                let deserialized = try? JSONSerialization.jsonObject(with: result, options: .allowFragments)
                if let deserialized = deserialized as? [String : Any] {
                    print("PRVD: (\(#function)) This network status = \(deserialized)")
                } else {
                    print("PRVD: (\(#function)) Unexpected result = \(result)")
                }
            } else {
                print("PRVD: (\(#function)) Unexpected data result = \(String(describing: result))")
            }
        }) { (response, result, error) in
            print("PRVD: \(#file):\(#line) \(#function) \nError = \(String(describing: error)) " +
                "\nResponse = \(String(describing: response)) \nResult = \(String(describing: result))")
        }
    }
    
    
    private func processNetworkTransactions() {
        let params = [String : Any]()
        try? ProvideGoldmine(apiClient()).listNetworkTransactions(networkId: networkId, parameters: params, successHandler: { (result) in
            if let result = result as? Data {
                let deserialized = try? JSONSerialization.jsonObject(with: result, options: .allowFragments)
                if let deserialized = deserialized as? Array<[String : Any]> {
                    print("PRVD: This network has \(deserialized.count) transactions")
                } else {
                    print("PRVD: Unexpected result = \(result)")
                }
            } else {
                print("PRVD: Unexpected data result = \(String(describing: result))")
            }
        }) { (response, result, error) in
            print("PRVD: Error = \(String(describing: error))")
        }
    }
    
    private func processNetworkTokens() {
        let params = [String : Any]()
        try? ProvideGoldmine(apiClient()).listNetworkTokens(networkId: networkId, parameters: params, successHandler: { (result) in
            if let result = result as? Data {
                let deserialized = try? JSONSerialization.jsonObject(with: result, options: .allowFragments)
                if let deserialized = deserialized as? Array<[String : Any]> {
                    print("PRVD: This network has \(deserialized.count) tokens")
                } else {
                    print("PRVD: Unexpected result = \(result)")
                }
            } else {
                print("PRVD: Unexpected data result = \(String(describing: result))")
            }
        }) { (response, result, error) in
            print("PRVD: Error = \(String(describing: error))")
        }
    }
    
    private func processNetworkNodes() {
        let params = [String : Any]()
        try? ProvideGoldmine(apiClient()).listNetworkNodes(networkId: networkId, parameters: params, successHandler: { (result) in
            if let result = result as? Data {
                let deserialized = try? JSONSerialization.jsonObject(with: result, options: .allowFragments)
                if let deserialized = deserialized as? Array<[String : Any]> {
                    print("PRVD: This network has \(deserialized.count) nodes")
                } else {
                    print("PRVD: Unexpected result = \(result)")
                }
            } else {
                print("PRVD: Unexpected data result = \(String(describing: result))")
            }
        }) { (response, result, error) in
            print("PRVD: Error = \(String(describing: error))")
        }
    }
    
    private func processNetworkBlocks() {
        let params = [String : Any]()
        try? ProvideGoldmine(apiClient()).listNetworkBlocks(networkId: networkId, parameters: params, successHandler: { (result) in
            if let result = result as? Data {
                let deserialized = try? JSONSerialization.jsonObject(with: result, options: .allowFragments)
                if let deserialized = deserialized as? Array<[String : Any]> {
                    print("PRVD: This network has \(deserialized.count) blocks")
                } else {
                    print("PRVD: Unexpected result = \(result)")
                }
            } else {
                print("PRVD: Unexpected data result = \(String(describing: result))")
            }
        }) { (response, result, error) in
            print("PRVD: Error = \(String(describing: error))")
        }
    }
    
    private func processNetworkBridges() {
        let params = [String : Any]()
        try? ProvideGoldmine(apiClient()).listNetworkBridges(networkId: networkId, parameters: params, successHandler: { (result) in
            if let result = result as? Data {
                let deserialized = try? JSONSerialization.jsonObject(with: result, options: .allowFragments)
                if let deserialized = deserialized as? Array<[String : Any]> {
                    print("PRVD: This network has \(deserialized.count) bridges")
                } else {
                    print("PRVD: Unexpected result = \(result)")
                }
            } else {
                print("PRVD: Unexpected data result = \(String(describing: result))")
            }
        }) { (response, result, error) in
            print("PRVD: Error = \(String(describing: error))")
        }
    }
    
    private func processNetworkOracles() {
        let params = [String : Any]()
        try? ProvideGoldmine(apiClient()).listNetworkOracles(networkId: networkId, parameters: params, successHandler: { (result) in
            if let result = result as? Data {
                let deserialized = try? JSONSerialization.jsonObject(with: result, options: .allowFragments)
                if let deserialized = deserialized as? Array<[String : Any]> {
                    print("PRVD: This network has \(deserialized.count) oracles")
                } else {
                    print("PRVD: Unexpected result = \(result)")
                }
            } else {
                print("PRVD: Unexpected data result = \(String(describing: result))")
            }
        }) { (response, result, error) in
            print("PRVD: Error = \(String(describing: error))")
        }
    }
    
    private func executeContract() {
        let params: [String : Any] = [
            "walletId" : "your-wallet-id",
            "method" : "nameOfFunctionInYourContract",
            "value" : 0,
            "params" : ["the", "arguments", "to", "your", "specified", "contract", "method"]
        ]
        try? ProvideGoldmine(apiClient()).executeContract(
            contractId: "your-contract-id",
            parameters: params,
            successHandler: { (result) in
                if let result = result as? Data {
                    let deserialized = try? JSONSerialization.jsonObject(with: result, options: .allowFragments)
                    if let deserialized = deserialized as? [String : Any] {
                        print("PRVD: contract execution result = \(deserialized)")
                    } else {
                        print("PRVD: Unexpected result = \(result)")
                    }
                } else {
                    print("PRVD: Unexpected data result = \(String(describing: result))")
                }
        }, failureHandler: { (response, result, error) in
            print("PRVD: Error = \(String(describing: error))")
        })
    }
    
    // MARK: - Helper Methods
    
    private func apiClient() -> ProvideApiClient {
        return ProvideApiClient(ProvideKeychainService.shared.appApiToken!)
    }

}
