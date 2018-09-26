//
//  ViewController.swift
//  provide
//
//  Created by kthomas on 09/18/2018.
//  Copyright (c) 2018 kthomas. All rights reserved.
//

import UIKit
import provide

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        login()
    }
    
    // MARK: - Private Methods
    
    private func doEverythingElse() {
        processTransactions()
        executeContract()
    }
    
    private func login() {
        // --------------------------------------------
        // NOTE: Replace these with your own credentials.
        //       Go to https://console.provide.services/#/signup if you need an account.
        let email = "YOUR_PROVIDE_EMAIL_ADRESS"
        let password = "YOUR_PROVIDE_PASSWORD"
        // NOTE: Do _NOT_ commit your credentials.
        // --------------------------------------------
        performAuthentication(email: email, password: password)
    }
    
    private func performAuthentication(email: String, password: String) {
        try? ProvideIdent().authenticate(email: email,
                                         password: password,
                                         successHandler:
            { [weak self] (result) in
                if let authToken = result as? String {
                    print("PRVD: Acquired auth token")
                    KeychainService.shared.authToken = authToken
                    
                    self?.doEverythingElse()
                    
                } else {
                    print("PRVD: Unexpected result = \(String(describing: result))")
                }
        }) { (response, result, error) in
            print("PRVD: Error = \(String(describing: error))")
        }
    }
    
    private func processTransactions() {
        let networkId = "024ff1ef-7369-4dee-969c-1918c6edb5d4"
        let params = [String : Any]()
        try? ProvideGoldmine().listNetworkTransactions(networkId: networkId, parameters: params, successHandler: { (result) in
            if let result = result as? Data {
                let deserialized = try? JSONSerialization.jsonObject(with: result, options: .allowFragments)
                if let deserialized = deserialized as? Array<[String : Any]> {
                    print("PRVD: This network has \(deserialized.count) transactions")
                } else {
                    print("PRVD: Unexpected data result = \(result)")
                }
            } else {
                print("PRVD: Unexpected non-data result = \(String(describing: result))")
            }
        }) { (respose, result, error) in
            print("PRVD: Error = \(String(describing: error))")
        }
    }
    
    private func executeContract() {
        let params: [String : Any] = ["walletId" : "45951aca-d420-4464-989a-3483b4878098", // "d3982e7c-3739-413c-9638-7fc9b33b75a2",
                                      "method" : "Transfer",
                                      "value" : 0,
                                      "params" : ["what", "are", "these?", "qwerty", "dvorak", "colemak", "foo", "bar", "baz", 42, 123]]
        try? ProvideGoldmine().executeContract(
            contractId: "a6f28e8f-a681-4264-a53f-305755a380e6", // "878954fb-d676-4809-8f95-67a2a8d483a3",
            parameters: params,
            successHandler: { (result) in
                if let result = result as? Data {
                    let deserialized = try? JSONSerialization.jsonObject(with: result, options: .allowFragments)
                    if let deserialized = deserialized as? [String : Any] {
                        print("PRVD: contract execution result = \(deserialized)")
                    } else {
                        print("PRVD: Unexpected data result = \(result)")
                    }
                } else {
                    print("PRVD: Unexpected non-data result = \(String(describing: result))")
                }
        }, failureHandler: { (response, result, error) in
            print("PRVD: Error = \(String(describing: error))")
        })
    }

}
