//
//  ProvideGoldmine.swift
//  provide
//
//  Created by Kevin Munc on 09/19/18.
//

import Foundation
import Alamofire

public class ProvideGoldmine: NSObject {

    private let api: ProvideApiClient

    // API Paths
    let accounts = "/accounts"
    let bridges = "/bridges"
    let connectors = "/connectors"
    let contracts = "/contracts"
    let networks = "/networks"
    let oracles = "/oracles"
    let tokens = "/tokens"
    let transactions = "/transactions"
    let wallets = "/wallets"

    public init(_ client: ProvideApiClient = ProvideApiClient()) {
        self.api = client
        super.init()
    }
    // MARK: - Account Methods

    public func listAccounts(parameters: Parameters,
                             successHandler: @escaping PrvdApiSuccessHandler,
                             failureHandler: @escaping PrvdApiFailureHandler) throws {
        guard let url = api.buildGoldmineUrl(path: accounts) else { throw ProvideError.invalidUrl(path: wallets) }

        let request = Alamofire.request(url,
                                        method: .get,
                                        parameters: parameters,
                                        encoding: JSONEncoding.prettyPrinted,
                                        headers: api.apiHeaders())
        api.get(request, successHandler: { (result) in
            successHandler(result as AnyObject)
        }) { (response, result, error) in
            failureHandler(response, result, error)
        }
    }
    
    public func fetchAccountBalance(accountId: String,
                                    tokenId: String,
                                    successHandler: @escaping PrvdApiSuccessHandler,
                                    failureHandler: @escaping PrvdApiFailureHandler) throws {
        let compoundPath = "\(accounts)/\(accountId)/balances/\(tokenId)"
        guard let url = api.buildGoldmineUrl(path: compoundPath) else { throw ProvideError.invalidUrl(path: compoundPath) }
        
        let request = Alamofire.request(url,
                                        method: .get,
                                        headers: api.apiHeaders())
        api.get(request, successHandler: { (result) in
            successHandler(result as AnyObject)
        }) { (response, result, error) in
            failureHandler(response, result, error)
        }
    }

    public func fetchAccountDetails(accountId: String,
                                    successHandler: @escaping PrvdApiSuccessHandler,
                                    failureHandler: @escaping PrvdApiFailureHandler) throws {
        let compoundPath = "\(accounts)/\(accountId)"
        guard let url = api.buildGoldmineUrl(path: compoundPath) else { throw ProvideError.invalidUrl(path: compoundPath) }
        
        let request = Alamofire.request(url,
                                        method: .get,
                                        headers: api.apiHeaders())
        api.get(request, successHandler: { (result) in
            successHandler(result as AnyObject)
        }) { (response, result, error) in
            failureHandler(response, result, error)
        }
    }

    public func createAccount(parameters: Parameters,
                              successHandler: @escaping PrvdApiSuccessHandler,
                              failureHandler: @escaping PrvdApiFailureHandler) throws {
        guard let url = api.buildGoldmineUrl(path: accounts) else { throw ProvideError.invalidUrl(path: wallets) }
        
        let request = Alamofire.request(url,
                                        method: .post,
                                        parameters: parameters,
                                        encoding: JSONEncoding.prettyPrinted,
                                        headers: api.apiHeaders())
        api.post(request, successHandler: { (result) in
            successHandler(result as AnyObject)
        }) { (response, result, error) in
            failureHandler(response, result, error)
        }
    }
    
    // MARK: - Bridge Methods
    
    public func listBridges(parameters: Parameters,
                            successHandler: @escaping PrvdApiSuccessHandler,
                            failureHandler: @escaping PrvdApiFailureHandler) throws {
        guard let url = api.buildGoldmineUrl(path: bridges) else { throw ProvideError.invalidUrl(path: bridges) }
        
        let request = Alamofire.request(url,
                                        method: .get,
                                        parameters: parameters,
                                        encoding: JSONEncoding.prettyPrinted,
                                        headers: api.apiHeaders())
        api.get(request, successHandler: { (result) in
            successHandler(result as AnyObject)
        }) { (response, result, error) in
            failureHandler(response, result, error)
        }
    }
    
    public func fetchBridgeDetails(bridgeId: String,
                                   successHandler: @escaping PrvdApiSuccessHandler,
                                   failureHandler: @escaping PrvdApiFailureHandler) throws {
        let compoundPath = "\(bridges)/\(bridgeId)"
        guard let url = api.buildGoldmineUrl(path: compoundPath) else { throw ProvideError.invalidUrl(path: compoundPath) }
        
        let request = Alamofire.request(url,
                                        method: .get,
                                        headers: api.apiHeaders())
        api.get(request, successHandler: { (result) in
            successHandler(result as AnyObject)
        }) { (response, result, error) in
            failureHandler(response, result, error)
        }
    }
    
    public func createBridge(parameters: Parameters,
                             successHandler: @escaping PrvdApiSuccessHandler,
                             failureHandler: @escaping PrvdApiFailureHandler) throws {
        guard let url = api.buildGoldmineUrl(path: bridges) else { throw ProvideError.invalidUrl(path: bridges) }
        
        let request = Alamofire.request(url,
                                        method: .post,
                                        parameters: parameters,
                                        encoding: JSONEncoding.prettyPrinted,
                                        headers: api.apiHeaders())
        api.post(request, successHandler: { (result) in
            successHandler(result as AnyObject)
        }) { (response, result, error) in
            failureHandler(response, result, error)
        }
    }
    
    // MARK: - Connector Methods
    
    public func listConnectors(parameters: Parameters,
                               successHandler: @escaping PrvdApiSuccessHandler,
                               failureHandler: @escaping PrvdApiFailureHandler) throws {
        guard let url = api.buildGoldmineUrl(path: connectors) else { throw ProvideError.invalidUrl(path: connectors) }
        
        let request = Alamofire.request(url,
                                        method: .get,
                                        parameters: parameters,
                                        encoding: JSONEncoding.prettyPrinted,
                                        headers: api.apiHeaders())
        api.get(request, successHandler: { (result) in
            successHandler(result as AnyObject)
        }) { (response, result, error) in
            failureHandler(response, result, error)
        }
    }
    
    public func fetchConnectorDetails(connectorId: String,
                                      successHandler: @escaping PrvdApiSuccessHandler,
                                      failureHandler: @escaping PrvdApiFailureHandler) throws {
        let compoundPath = "\(bridges)/\(connectorId)"
        guard let url = api.buildGoldmineUrl(path: compoundPath) else { throw ProvideError.invalidUrl(path: compoundPath) }
        
        let request = Alamofire.request(url,
                                        method: .get,
                                        headers: api.apiHeaders())
        api.get(request, successHandler: { (result) in
            successHandler(result as AnyObject)
        }) { (response, result, error) in
            failureHandler(response, result, error)
        }
    }
    
    public func createConnector(parameters: Parameters,
                                successHandler: @escaping PrvdApiSuccessHandler,
                                failureHandler: @escaping PrvdApiFailureHandler) throws {
        guard let url = api.buildGoldmineUrl(path: bridges) else { throw ProvideError.invalidUrl(path: bridges) }
        
        let request = Alamofire.request(url,
                                        method: .post,
                                        parameters: parameters,
                                        encoding: JSONEncoding.prettyPrinted,
                                        headers: api.apiHeaders())
        api.post(request, successHandler: { (result) in
            successHandler(result as AnyObject)
        }) { (response, result, error) in
            failureHandler(response, result, error)
        }
    }
    
    public func deleteConnector(connectorId: String,
                                successHandler: @escaping PrvdApiSuccessHandler,
                                failureHandler: @escaping PrvdApiFailureHandler) throws {
        let compoundPath = "\(bridges)/\(connectorId)"
        guard let url = api.buildGoldmineUrl(path: compoundPath) else { throw ProvideError.invalidUrl(path: compoundPath) }
        
        let request = Alamofire.request(url,
                                        method: .delete,
                                        headers: api.apiHeaders())
        api.delete(request, successHandler: { (result) in
            successHandler(result as AnyObject)
        }) { (response, result, error) in
            failureHandler(response, result, error)
        }
    }
    
    // MARK: - Contract Methods
    
    public func listContracts(parameters: Parameters,
                              successHandler: @escaping PrvdApiSuccessHandler,
                              failureHandler: @escaping PrvdApiFailureHandler) throws {
        guard let url = api.buildGoldmineUrl(path: contracts) else { throw ProvideError.invalidUrl(path: contracts) }
        
        let request = Alamofire.request(url,
                                        method: .get,
                                        parameters: parameters,
                                        encoding: JSONEncoding.prettyPrinted,
                                        headers: api.apiHeaders())
        api.get(request, successHandler: { (result) in
            successHandler(result as AnyObject)
        }) { (response, result, error) in
            failureHandler(response, result, error)
        }
    }
    
    public func fetchContractDetails(contractId: String,
                                     successHandler: @escaping PrvdApiSuccessHandler,
                                     failureHandler: @escaping PrvdApiFailureHandler) throws {
        let compoundPath = "\(contracts)/\(contractId)"
        guard let url = api.buildGoldmineUrl(path: compoundPath) else { throw ProvideError.invalidUrl(path: compoundPath) }
        
        let request = Alamofire.request(url,
                                        method: .get,
                                        headers: api.apiHeaders())
        api.get(request, successHandler: { (result) in
            successHandler(result as AnyObject)
        }) { (response, result, error) in
            failureHandler(response, result, error)
        }
    }
    
    public func createContract(parameters: Parameters,
                               successHandler: @escaping PrvdApiSuccessHandler,
                               failureHandler: @escaping PrvdApiFailureHandler) throws {
        guard let url = api.buildGoldmineUrl(path: contracts) else { throw ProvideError.invalidUrl(path: contracts) }
        
        let request = Alamofire.request(url,
                                        method: .post,
                                        parameters: parameters,
                                        encoding: JSONEncoding.prettyPrinted,
                                        headers: api.apiHeaders())
        api.post(request, successHandler: { (result) in
            successHandler(result as AnyObject)
        }) { (response, result, error) in
            failureHandler(response, result, error)
        }
    }
    
    public func executeContract(contractId: String,
                                parameters: Parameters,
                                successHandler: @escaping PrvdApiSuccessHandler,
                                failureHandler: @escaping PrvdApiFailureHandler) throws {
        let compoundPath = "\(contracts)/\(contractId)/execute"
        guard let url = api.buildGoldmineUrl(path: compoundPath) else { throw ProvideError.invalidUrl(path: compoundPath) }
        
        let request = Alamofire.request(url,
                                        method: .post,
                                        parameters: parameters,
                                        encoding: JSONEncoding.prettyPrinted,
                                        headers: api.apiHeaders())
        api.post(request, successHandler: { (result) in
            successHandler(result as AnyObject)
        }) { (response, result, error) in
            failureHandler(response, result, error)
        }
    }
    
    // MARK: - Oracle Methods
    
    public func createOracle(parameters: Parameters,
                             successHandler: @escaping PrvdApiSuccessHandler,
                             failureHandler: @escaping PrvdApiFailureHandler) throws {
        guard let url = api.buildGoldmineUrl(path: oracles) else { throw ProvideError.invalidUrl(path: oracles) }
        
        let request = Alamofire.request(url,
                                        method: .post,
                                        parameters: parameters,
                                        encoding: JSONEncoding.prettyPrinted,
                                        headers: api.apiHeaders())
        api.post(request, successHandler: { (result) in
            successHandler(result as AnyObject)
        }) { (response, result, error) in
            failureHandler(response, result, error)
        }
    }
    
    public func listOracles(parameters: Parameters,
                            successHandler: @escaping PrvdApiSuccessHandler,
                            failureHandler: @escaping PrvdApiFailureHandler) throws {
        guard let url = api.buildGoldmineUrl(path: oracles) else { throw ProvideError.invalidUrl(path: oracles) }
        
        let request = Alamofire.request(url,
                                        method: .get,
                                        parameters: parameters,
                                        encoding: JSONEncoding.prettyPrinted,
                                        headers: api.apiHeaders())
        api.get(request, successHandler: { (result) in
            successHandler(result as AnyObject)
        }) { (response, result, error) in
            failureHandler(response, result, error)
        }
    }
    
    public func fetchOracleDetails(oracleId: String,
                                   successHandler: @escaping PrvdApiSuccessHandler,
                                   failureHandler: @escaping PrvdApiFailureHandler) throws {
        let compoundPath = "\(oracles)/\(oracleId)"
        guard let url = api.buildGoldmineUrl(path: compoundPath) else { throw ProvideError.invalidUrl(path: compoundPath) }
        
        let request = Alamofire.request(url,
                                        method: .get,
                                        headers: api.apiHeaders())
        api.get(request, successHandler: { (result) in
            successHandler(result as AnyObject)
        }) { (response, result, error) in
            failureHandler(response, result, error)
        }
    }
    
    // MARK: - Token Methods
    
    public func createToken(parameters: Parameters,
                            successHandler: @escaping PrvdApiSuccessHandler,
                            failureHandler: @escaping PrvdApiFailureHandler) throws {
        guard let url = api.buildGoldmineUrl(path: tokens) else { throw ProvideError.invalidUrl(path: tokens) }
        
        let request = Alamofire.request(url,
                                        method: .post,
                                        parameters: parameters,
                                        encoding: JSONEncoding.prettyPrinted,
                                        headers: api.apiHeaders())
        api.post(request, successHandler: { (result) in
            successHandler(result as AnyObject)
        }) { (response, result, error) in
            failureHandler(response, result, error)
        }
    }
    
    public func listTokens(parameters: Parameters,
                           successHandler: @escaping PrvdApiSuccessHandler,
                           failureHandler: @escaping PrvdApiFailureHandler) throws {
        guard let url = api.buildGoldmineUrl(path: tokens) else { throw ProvideError.invalidUrl(path: tokens) }
        
        let request = Alamofire.request(url,
                                        method: .get,
                                        parameters: parameters,
                                        encoding: JSONEncoding.prettyPrinted,
                                        headers: api.apiHeaders())
        api.get(request, successHandler: { (result) in
            successHandler(result as AnyObject)
        }) { (response, result, error) in
            failureHandler(response, result, error)
        }
    }
    
    public func fetchTokenDetails(tokenId: String,
                                  successHandler: @escaping PrvdApiSuccessHandler,
                                  failureHandler: @escaping PrvdApiFailureHandler) throws {
        let compoundPath = "\(tokens)/\(tokenId)"
        guard let url = api.buildGoldmineUrl(path: compoundPath) else { throw ProvideError.invalidUrl(path: compoundPath) }
        
        let request = Alamofire.request(url,
                                        method: .get,
                                        headers: api.apiHeaders())
        api.get(request, successHandler: { (result) in
            successHandler(result as AnyObject)
        }) { (response, result, error) in
            failureHandler(response, result, error)
        }
    }
    
    // MARK: - Transaction Methods
    
    public func createTransaction(parameters: Parameters,
                                  successHandler: @escaping PrvdApiSuccessHandler,
                                  failureHandler: @escaping PrvdApiFailureHandler) throws {
        guard let url = api.buildGoldmineUrl(path: transactions) else { throw ProvideError.invalidUrl(path: transactions) }
        
        let request = Alamofire.request(url,
                                        method: .post,
                                        parameters: parameters,
                                        encoding: JSONEncoding.prettyPrinted,
                                        headers: api.apiHeaders())
        api.post(request, successHandler: { (result) in
            successHandler(result as AnyObject)
        }) { (response, result, error) in
            failureHandler(response, result, error)
        }
    }
    
    public func listTransactions(parameters: Parameters,
                                 successHandler: @escaping PrvdApiSuccessHandler,
                                 failureHandler: @escaping PrvdApiFailureHandler) throws {
        guard let url = api.buildGoldmineUrl(path: transactions) else { throw ProvideError.invalidUrl(path: transactions) }
        
        let request = Alamofire.request(url,
                                        method: .get,
                                        parameters: parameters,
                                        encoding: JSONEncoding.prettyPrinted,
                                        headers: api.apiHeaders())
        api.get(request, successHandler: { (result) in
            successHandler(result as AnyObject)
        }) { (response, result, error) in
            failureHandler(response, result, error)
        }
    }
    
    public func fetchTransactionDetails(transactionId: String,
                                        successHandler: @escaping PrvdApiSuccessHandler,
                                        failureHandler: @escaping PrvdApiFailureHandler) throws {
        let compoundPath = "\(transactions)/\(transactionId)"
        guard let url = api.buildGoldmineUrl(path: compoundPath) else { throw ProvideError.invalidUrl(path: compoundPath) }
        
        let request = Alamofire.request(url,
                                        method: .get,
                                        headers: api.apiHeaders())
        api.get(request, successHandler: { (result) in
            successHandler(result as AnyObject)
        }) { (response, result, error) in
            failureHandler(response, result, error)
        }
    }
    
    // MARK: - Wallet Methods
    
    public func fetchWalletDetails(walletId: String,
                                   successHandler: @escaping PrvdApiSuccessHandler,
                                   failureHandler: @escaping PrvdApiFailureHandler) throws {
        let compoundPath = "\(wallets)/\(walletId)"
        guard let url = api.buildGoldmineUrl(path: compoundPath) else { throw ProvideError.invalidUrl(path: compoundPath) }
        
        let request = Alamofire.request(url,
                                        method: .get,
                                        headers: api.apiHeaders())
        api.get(request, successHandler: { (result) in
            successHandler(result as AnyObject)
        }) { (response, result, error) in
            failureHandler(response, result, error)
        }
    }

    public func listWallets(parameters: Parameters,
                            successHandler: @escaping PrvdApiSuccessHandler,
                            failureHandler: @escaping PrvdApiFailureHandler) throws {
        guard let url = api.buildGoldmineUrl(path: wallets) else { throw ProvideError.invalidUrl(path: wallets) }
        
        let request = Alamofire.request(url,
                                        method: .get,
                                        parameters: parameters,
                                        encoding: JSONEncoding.prettyPrinted,
                                        headers: api.apiHeaders())
        api.get(request, successHandler: { (result) in
            successHandler(result as AnyObject)
        }) { (response, result, error) in
            failureHandler(response, result, error)
        }
    }
    
    public func createWallet(parameters: Parameters,
                             successHandler: @escaping PrvdApiSuccessHandler,
                             failureHandler: @escaping PrvdApiFailureHandler) throws {
        guard let url = api.buildGoldmineUrl(path: wallets) else { throw ProvideError.invalidUrl(path: wallets) }
        
        let request = Alamofire.request(url,
                                        method: .post,
                                        parameters: parameters,
                                        encoding: JSONEncoding.prettyPrinted,
                                        headers: api.apiHeaders())
        api.post(request, successHandler: { (result) in
            successHandler(result as AnyObject)
        }) { (response, result, error) in
            failureHandler(response, result, error)
        }
    }
    
}

extension ProvideGoldmine {
    
    // MARK: - Network Methods
    
    // MARK: Network CRUD Methods
    
    public func listNetworks(parameters: Parameters,
                             successHandler: @escaping PrvdApiSuccessHandler,
                             failureHandler: @escaping PrvdApiFailureHandler) throws {
        guard let url = api.buildGoldmineUrl(path: networks) else { throw ProvideError.invalidUrl(path: networks) }
        
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
    
    public func fetchNetworkDetails(networkId: String,
                                    successHandler: @escaping PrvdApiSuccessHandler,
                                    failureHandler: @escaping PrvdApiFailureHandler) throws {
        let compoundPath = "\(networks)/\(networkId)"
        guard let url = api.buildGoldmineUrl(path: compoundPath) else { throw ProvideError.invalidUrl(path: compoundPath) }
        
        let request = Alamofire.request(url,
                                        method: .get,
                                        headers: api.authHeaders())
        api.get(request, successHandler: { (result) in
            successHandler(result as AnyObject)
        }) { (response, result, error) in
            failureHandler(response, result, error)
        }
    }
    
    public func createNetwork(parameters: Parameters,
                              successHandler: @escaping PrvdApiSuccessHandler,
                              failureHandler: @escaping PrvdApiFailureHandler) throws {
        guard let url = api.buildGoldmineUrl(path: networks) else { throw ProvideError.invalidUrl(path: networks) }
        
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
    
    public func updateNetwork(networkId: String,
                              parameters: Parameters,
                              successHandler: @escaping PrvdApiSuccessHandler,
                              failureHandler: @escaping PrvdApiFailureHandler) throws {
        let compoundPath = "\(networks)/\(networkId)"
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
    
    
    // MARK: Network Methods with Other Types
    
    public func listNetworkAccounts(networkId: String,
                                    parameters: Parameters,
                                    successHandler: @escaping PrvdApiSuccessHandler,
                                    failureHandler: @escaping PrvdApiFailureHandler) throws {
        let compoundPath = "\(networks)/\(networkId)/accounts"
        guard let url = api.buildGoldmineUrl(path: compoundPath) else { throw ProvideError.invalidUrl(path: compoundPath) }
        
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
    
    public func listNetworkBlocks(networkId: String,
                                  parameters: Parameters,
                                  successHandler: @escaping PrvdApiSuccessHandler,
                                  failureHandler: @escaping PrvdApiFailureHandler) throws {
        let compoundPath = "\(networks)/\(networkId)/blocks"
        guard let url = api.buildGoldmineUrl(path: compoundPath) else { throw ProvideError.invalidUrl(path: compoundPath) }
        
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
    
    public func listNetworkBridges(networkId: String,
                                   parameters: Parameters,
                                   successHandler: @escaping PrvdApiSuccessHandler,
                                   failureHandler: @escaping PrvdApiFailureHandler) throws {
        let compoundPath = "\(networks)/\(networkId)/bridges"
        guard let url = api.buildGoldmineUrl(path: compoundPath) else { throw ProvideError.invalidUrl(path: compoundPath) }
        
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
    
    public func listNetworkConnectors(networkId: String,
                                      parameters: Parameters,
                                      successHandler: @escaping PrvdApiSuccessHandler,
                                      failureHandler: @escaping PrvdApiFailureHandler) throws {
        let compoundPath = "\(networks)/\(networkId)/connectors"
        guard let url = api.buildGoldmineUrl(path: compoundPath) else { throw ProvideError.invalidUrl(path: compoundPath) }
        
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
    
    public func listNetworkContracts(networkId: String,
                                     parameters: Parameters,
                                     successHandler: @escaping PrvdApiSuccessHandler,
                                     failureHandler: @escaping PrvdApiFailureHandler) throws {
        let compoundPath = "\(networks)/\(networkId)/contracts"
        guard let url = api.buildGoldmineUrl(path: compoundPath) else { throw ProvideError.invalidUrl(path: compoundPath) }
        
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
    
    public func listNetworkOracles(networkId: String,
                                   parameters: Parameters,
                                   successHandler: @escaping PrvdApiSuccessHandler,
                                   failureHandler: @escaping PrvdApiFailureHandler) throws {
        let compoundPath = "\(networks)/\(networkId)/oracles"
        guard let url = api.buildGoldmineUrl(path: compoundPath) else { throw ProvideError.invalidUrl(path: compoundPath) }
        
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
    
    public func listNetworkTokens(networkId: String,
                                  parameters: Parameters,
                                  successHandler: @escaping PrvdApiSuccessHandler,
                                  failureHandler: @escaping PrvdApiFailureHandler) throws {
        let compoundPath = "\(networks)/\(networkId)/tokens"
        guard let url = api.buildGoldmineUrl(path: compoundPath) else { throw ProvideError.invalidUrl(path: compoundPath) }
        
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
    
    public func listNetworkTransactions(networkId: String,
                                        parameters: Parameters,
                                        successHandler: @escaping PrvdApiSuccessHandler,
                                        failureHandler: @escaping PrvdApiFailureHandler) throws {
        let compoundPath = "\(networks)/\(networkId)/transactions"
        guard let url = api.buildGoldmineUrl(path: compoundPath) else { throw ProvideError.invalidUrl(path: compoundPath) }
        
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
    
    public func fetchNetworkStatus(networkId: String,
                                   successHandler: @escaping PrvdApiSuccessHandler,
                                   failureHandler: @escaping PrvdApiFailureHandler) throws {
        let compoundPath = "\(networks)/\(networkId)/status"
        guard let url = api.buildGoldmineUrl(path: compoundPath) else { throw ProvideError.invalidUrl(path: compoundPath) }
        
        let request = Alamofire.request(url,
                                        method: .get,
                                        headers: api.authHeaders())
        api.get(request, successHandler: { (result) in
            successHandler(result as AnyObject)
        }) { (response, result, error) in
            failureHandler(response, result, error)
        }
    }
    
    public func fetchNetworkContractDetails(networkId: String,
                                            contractId: String,
                                            successHandler: @escaping PrvdApiSuccessHandler,
                                            failureHandler: @escaping PrvdApiFailureHandler) throws {
        let compoundPath = "\(networks)/\(networkId)/contracts/\(contractId)"
        guard let url = api.buildGoldmineUrl(path: compoundPath) else { throw ProvideError.invalidUrl(path: compoundPath) }
        
        let request = Alamofire.request(url,
                                        method: .get,
                                        headers: api.authHeaders())
        api.get(request, successHandler: { (result) in
            successHandler(result as AnyObject)
        }) { (response, result, error) in
            failureHandler(response, result, error)
        }
    }
    
    public func fetchNetworkTransactionDetails(networkId: String,
                                               transactionId: String,
                                               successHandler: @escaping PrvdApiSuccessHandler,
                                               failureHandler: @escaping PrvdApiFailureHandler) throws {
        let compoundPath = "\(networks)/\(networkId)/transactions/\(transactionId)"
        guard let url = api.buildGoldmineUrl(path: compoundPath) else { throw ProvideError.invalidUrl(path: compoundPath) }
        
        let request = Alamofire.request(url,
                                        method: .get,
                                        headers: api.authHeaders())
        api.get(request, successHandler: { (result) in
            successHandler(result as AnyObject)
        }) { (response, result, error) in
            failureHandler(response, result, error)
        }
    }
    
    // MARK: Network Node Methods
    
    public func listNetworkNodes(networkId: String,
                                 parameters: Parameters,
                                 successHandler: @escaping PrvdApiSuccessHandler,
                                 failureHandler: @escaping PrvdApiFailureHandler) throws {
        let compoundPath = "\(networks)/\(networkId)/nodes"
        guard let url = api.buildGoldmineUrl(path: compoundPath) else { throw ProvideError.invalidUrl(path: compoundPath) }
        
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
    
    public func fetchNetworkNodeDetails(networkId: String,
                                        nodeId: String,
                                        successHandler: @escaping PrvdApiSuccessHandler,
                                        failureHandler: @escaping PrvdApiFailureHandler) throws {
        let compoundPath = "\(networks)/\(networkId)/nodes/\(nodeId)"
        guard let url = api.buildGoldmineUrl(path: compoundPath) else { throw ProvideError.invalidUrl(path: compoundPath) }
        
        let request = Alamofire.request(url,
                                        method: .get,
                                        headers: api.authHeaders())
        api.get(request, successHandler: { (result) in
            successHandler(result as AnyObject)
        }) { (response, result, error) in
            failureHandler(response, result, error)
        }
    }
    
    public func createNetworkNode(networkId: String,
                                  parameters: Parameters,
                                  successHandler: @escaping PrvdApiSuccessHandler,
                                  failureHandler: @escaping PrvdApiFailureHandler) throws {
        let compoundPath = "\(networks)/\(networkId)/nodes"
        guard let url = api.buildGoldmineUrl(path: compoundPath) else { throw ProvideError.invalidUrl(path: compoundPath) }
        
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
    
    public func fetchNetworkNodeLogs(networkId: String,
                                     nodeId: String,
                                     successHandler: @escaping PrvdApiSuccessHandler,
                                     failureHandler: @escaping PrvdApiFailureHandler) throws {
        let compoundPath = "\(networks)/\(networkId)/nodes/\(nodeId)/logs"
        guard let url = api.buildGoldmineUrl(path: compoundPath) else { throw ProvideError.invalidUrl(path: compoundPath) }
        
        let request = Alamofire.request(url,
                                        method: .get,
                                        headers: api.authHeaders())
        api.get(request, successHandler: { (result) in
            successHandler(result as AnyObject)
        }) { (response, result, error) in
            failureHandler(response, result, error)
        }
    }
    
    public func deleteNetworkNodes(networkId: String,
                                   nodeId: String,
                                   successHandler: @escaping PrvdApiSuccessHandler,
                                   failureHandler: @escaping PrvdApiFailureHandler) throws {
        let compoundPath = "\(networks)/\(networkId)/nodes/\(nodeId)"
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
    
}
