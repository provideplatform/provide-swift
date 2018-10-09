//
//  Health4Future.swift
//  provide_Example
//
//  Created by Kyle Thomas on 10/8/18.
//  Copyright © 2018 Provide. All rights reserved.
//

import provide

//    contribute $200
//    for member 1:  (wallet Id)
//    Quarter: 1, year 2018

let member1Addr = "0x43F08f1534dD81a116DdE7A510BB1C78C24d2314"
let member1ContractId = "e48a6492-1b16-463d-807a-c5c2bb5ebd4d"

let member2Addr = "0x157CdF5340Ca2768bF3Ca2f07A6aB083344c08fB"
let member2ContractId = "39215834-0853-42eb-894d-7c63ebfc688f"

public typealias H4FNumericContractApiSuccessHandler = (Double?) -> Void
//public typealias PrvdApiFailureHandler = (HTTPURLResponse?, AnyObject?, NSError?) -> Void

// Insurer methods

func contributeToMember(member: String, amount: Int) {
    // 0x157CdF5340Ca2768bF3Ca2f07A6aB083344c08fB
    try? ProvideGoldmine(apiClient).executeContract(contractId: "e581ad78-b08f-48ed-a626-7d9f9c697e04", parameters: [ "wallet_id": "abcff7e5-9c48-4176-9f8b-927bb79430e6", "method": "contributeToFuture", "value": 0, "params": [amount, member, 2, 2018] ], successHandler: { (result) in
        // Process result
    }, failureHandler: { (response, result, error) in
        // Handle error
    })
}


// Member

func getBalance(memberContractId: String, onSuccess: @escaping H4FNumericContractApiSuccessHandler) {
    try? ProvideGoldmine(apiClient).executeContract(contractId: memberContractId, parameters: [ "wallet_id": "abcff7e5-9c48-4176-9f8b-927bb79430e6", "method": "getBalance", "value": 0, "params": [] ], successHandler: { (result) in

        let deserialized = try? JSONSerialization.jsonObject(with: result as! Data, options: .allowFragments)
        if let deserialized = deserialized as? [String : Any] {
            if let balance = deserialized["response"] as? Double {
                onSuccess(balance)
            } else {
                print("PRVD: Unable to parse out the first application")
            }
        } else {
            print("PRVD: Unexpected result = \(String(describing: result))")
        }


    }, failureHandler: { (response, result, error) in
        // Handle error
    })
}

func getTotalPct(memberContractId: String, onSuccess: @escaping H4FNumericContractApiSuccessHandler) {
    try? ProvideGoldmine(apiClient).executeContract(contractId: memberContractId, parameters: [ "wallet_id": "abcff7e5-9c48-4176-9f8b-927bb79430e6", "method": "getTotalPct", "value": 0, "params": [] ], successHandler: { (result) in

        let deserialized = try? JSONSerialization.jsonObject(with: result as! Data, options: .allowFragments)
        if let deserialized = deserialized as? [String : Any] {
            if let balance = deserialized["response"] as? Double {
                onSuccess(balance)
            } else {
                print("PRVD: Unable to parse out the first application")
            }
        } else {
            print("PRVD: Unexpected result = \(String(describing: result))")
        }


    }, failureHandler: { (response, result, error) in
        // Handle error
    })
}

// Employer

func getEmployerBalance(onSuccess: @escaping H4FNumericContractApiSuccessHandler) {
    let employerContractId = "f6e032bb-701a-4b67-b1d9-0887286012f6"
    try? ProvideGoldmine(apiClient).executeContract(contractId: employerContractId, parameters: [ "wallet_id": "abcff7e5-9c48-4176-9f8b-927bb79430e6", "method": "getBalance", "value": 0, "params": [] ], successHandler: { (result) in

        let deserialized = try? JSONSerialization.jsonObject(with: result as! Data, options: .allowFragments)
        if let deserialized = deserialized as? [String : Any] {
            if let balance = deserialized["response"] as? Double {
                onSuccess(balance)
            } else {
                print("PRVD: Unable to parse out the first application")
            }
        } else {
            print("PRVD: Unexpected result = \(result)")
        }
    }, failureHandler: { (response, result, error) in
        // Handle error
    })
}

func cashOut() {
    let employerContractId = "f6e032bb-701a-4b67-b1d9-0887286012f6"
    try? ProvideGoldmine(apiClient).executeContract(contractId: employerContractId, parameters: [ "wallet_id": "abcff7e5-9c48-4176-9f8b-927bb79430e6", "method": "cashOut", "value": 0, "params": [] ], successHandler: { (result) in
        // Process result
    }, failureHandler: { (response, result, error) in
        // Handle error
    })
}


// Retirement provider

func getParticipantBalance(participant: String, onSuccess: @escaping H4FNumericContractApiSuccessHandler) {
    let providerContractId = "02f054b3-6cf7-4d99-ab83-6c0ac11024ed"
    try? ProvideGoldmine(apiClient).executeContract(contractId: providerContractId, parameters: [ "wallet_id": "abcff7e5-9c48-4176-9f8b-927bb79430e6", "method": "getParticipantBalance", "value": 0, "params": [participant] ], successHandler: { (result) in

        let deserialized = try? JSONSerialization.jsonObject(with: result as! Data, options: .allowFragments)
        if let deserialized = deserialized as? [String : Any] {
            if let balance = deserialized["response"] as? Double {
                onSuccess(balance)
            } else {
                print("PRVD: Unable to parse out the first application")
            }
        } else {
            print("PRVD: Unexpected result = \(result)")
        }
    }, failureHandler: { (response, result, error) in
        // Handle error
    })
}

private var apiClient: ProvideApiClient {
    return ProvideApiClient(ProvideKeychainService.shared.appApiToken!)
}
