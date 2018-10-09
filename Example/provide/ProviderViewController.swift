//
//  ViewController.swift
//  provide
//
//  Created by kthomas on 09/18/2018.
//  Copyright (c) 2018 kthomas. All rights reserved.
//

import UIKit
import provide

class ProviderViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @available(iOS 2.0, *)
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    // Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
    // Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

    @available(iOS 2.0, *)
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "memberCellReuseIdentifier")
        cell?.textLabel?.text = ""
        cell?.detailTextLabel?.text = ""

        var memberContractId: String!

        if indexPath.row == 0 {
            memberContractId = member1ContractId
        } else if indexPath.row == 1 {
            memberContractId = member2ContractId
        }

        getBalance(memberContractId: memberContractId) { (response) in
            cell?.detailTextLabel?.text = String(describing: response)
        }

        return cell!
    }


//    @available(iOS 2.0, *)
//    optional public func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath)
//
//    @available(iOS 6.0, *)
//    optional public func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int)
//
//    @available(iOS 6.0, *)
//    optional public func tableView(_ tableView: UITableView, willDisplayFooterView view: UIView, forSection section: Int)
//
//    @available(iOS 6.0, *)
//    optional public func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath)
//
//    @available(iOS 6.0, *)
//    optional public func tableView(_ tableView: UITableView, didEndDisplayingHeaderView view: UIView, forSection section: Int)
//
//    @available(iOS 6.0, *)
//    optional public func tableView(_ tableView: UITableView, didEndDisplayingFooterView view: UIView, forSection section: Int)
//
//    @available(iOS 2.0, *)
//    optional public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
//
//    @available(iOS 2.0, *)
//    optional public func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat
//
//    @available(iOS 2.0, *)
//    optional public func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat
//
//    @available(iOS 7.0, *)
//    optional public func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat
//
//    @available(iOS 7.0, *)
//    optional public func tableView(_ tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat
//
//    @available(iOS 7.0, *)
//    optional public func tableView(_ tableView: UITableView, estimatedHeightForFooterInSection section: Int) -> CGFloat
//
//    @available(iOS 2.0, *)
//    optional public func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?
//
//    @available(iOS 2.0, *)
//    optional public func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView?
//
//    @available(iOS 2.0, *)
//    optional public func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath)
//
//    @available(iOS 6.0, *)
//    optional public func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool
//
//    @available(iOS 6.0, *)
//    optional public func tableView(_ tableView: UITableView, didHighlightRowAt indexPath: IndexPath)
//
//    @available(iOS 6.0, *)
//    optional public func tableView(_ tableView: UITableView, didUnhighlightRowAt indexPath: IndexPath)
//
//    @available(iOS 2.0, *)
//    optional public func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath?
//
//    @available(iOS 3.0, *)
//    optional public func tableView(_ tableView: UITableView, willDeselectRowAt indexPath: IndexPath) -> IndexPath?
//
//    @available(iOS 2.0, *)
//    optional public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
//
//    @available(iOS 3.0, *)
//    optional public func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath)
//
//    @available(iOS 2.0, *)
//    optional public func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle
//
//    @available(iOS 3.0, *)
//    optional public func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String?
//
//    @available(iOS 8.0, *)
//    optional public func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]?
//
//    @available(iOS 11.0, *)
//    optional public func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration?
//
//    @available(iOS 11.0, *)
//    optional public func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration?
//
//    @available(iOS 2.0, *)
//    optional public func tableView(_ tableView: UITableView, shouldIndentWhileEditingRowAt indexPath: IndexPath) -> Bool
//
//    @available(iOS 2.0, *)
//    optional public func tableView(_ tableView: UITableView, willBeginEditingRowAt indexPath: IndexPath)
//
//    @available(iOS 2.0, *)
//    optional public func tableView(_ tableView: UITableView, didEndEditingRowAt indexPath: IndexPath?)
//
//    @available(iOS 2.0, *)
//    optional public func tableView(_ tableView: UITableView, targetIndexPathForMoveFromRowAt sourceIndexPath: IndexPath, toProposedIndexPath proposedDestinationIndexPath: IndexPath) -> IndexPath
//
//    @available(iOS 2.0, *)
//    optional public func tableView(_ tableView: UITableView, indentationLevelForRowAt indexPath: IndexPath) -> Int
//
//    @available(iOS 5.0, *)
//    optional public func tableView(_ tableView: UITableView, shouldShowMenuForRowAt indexPath: IndexPath) -> Bool
//
//    @available(iOS 5.0, *)
//    optional public func tableView(_ tableView: UITableView, canPerformAction action: Selector, forRowAt indexPath: IndexPath, withSender sender: Any?) -> Bool
//
//    @available(iOS 5.0, *)
//    optional public func tableView(_ tableView: UITableView, performAction action: Selector, forRowAt indexPath: IndexPath, withSender sender: Any?)
//
//    @available(iOS 9.0, *)
//    optional public func tableView(_ tableView: UITableView, canFocusRowAt indexPath: IndexPath) -> Bool
//
//    @available(iOS 9.0, *)
//    optional public func tableView(_ tableView: UITableView, shouldUpdateFocusIn context: UITableViewFocusUpdateContext) -> Bool
//
//    @available(iOS 9.0, *)
//    optional public func tableView(_ tableView: UITableView, didUpdateFocusIn context: UITableViewFocusUpdateContext, with coordinator: UIFocusAnimationCoordinator)
//
//    @available(iOS 9.0, *)
//    optional public func indexPathForPreferredFocusedView(in tableView: UITableView) -> IndexPath?
//
//    @available(iOS 11.0, *)
//    optional public func tableView(_ tableView: UITableView, shouldSpringLoadRowAt indexPath: IndexPath, with context: UISpringLoadedInteractionContext) -> Bool




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