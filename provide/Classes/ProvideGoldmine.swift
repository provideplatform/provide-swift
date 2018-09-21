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
    let bridges = "bridges"
    let connectors = "connectors"
    let contracts = "contracts"
    let networks = "networks"
    let oracles = "oracles"
    let tokens = "tokens"
    let transactions = "transactions"
    let wallets = "wallets"
    
    public init(_ client: ProvideApiClient = ProvideApiClient()) {
        self.api = client
        super.init()
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
                                        headers: api.headers())
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
                                        headers: api.headers())
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
                                        headers: api.headers())
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
                                        headers: api.headers())
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
                                        headers: api.headers())
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
                                        headers: api.headers())
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
                                        headers: api.headers())
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
                                        headers: api.headers())
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
                                        headers: api.headers())
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
                                        headers: api.headers())
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
                                        headers: api.headers())
        api.post(request, successHandler: { (result) in
            successHandler(result as AnyObject)
        }) { (response, result, error) in
            failureHandler(response, result, error)
        }
    }
    
    // MARK: - Network Methods
    
    
    
    // FIXME: do the millions of them (extension?)
    
    
    
    // MARK: - Oracle Methods
    
    public func createOracle(parameters: Parameters,
                             successHandler: @escaping PrvdApiSuccessHandler,
                             failureHandler: @escaping PrvdApiFailureHandler) throws {
        guard let url = api.buildGoldmineUrl(path: oracles) else { throw ProvideError.invalidUrl(path: oracles) }
        
        let request = Alamofire.request(url,
                                        method: .post,
                                        parameters: parameters,
                                        encoding: JSONEncoding.prettyPrinted,
                                        headers: api.headers())
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
                                        headers: api.headers())
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
                                        headers: api.headers())
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
                                        headers: api.headers())
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
                                        headers: api.headers())
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
                                        headers: api.headers())
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
                                        headers: api.headers())
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
                                        headers: api.headers())
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
                                        headers: api.headers())
        api.get(request, successHandler: { (result) in
            successHandler(result as AnyObject)
        }) { (response, result, error) in
            failureHandler(response, result, error)
        }
    }
    
    // MARK: - Wallet Methods
    
    public func fetchWalletBalance(walletId: String,
                                   tokenId: String,
                                   successHandler: @escaping PrvdApiSuccessHandler,
                                   failureHandler: @escaping PrvdApiFailureHandler) throws {
        let compoundPath = "\(wallets)/\(walletId)/balances/\(tokenId)"
        guard let url = api.buildGoldmineUrl(path: compoundPath) else { throw ProvideError.invalidUrl(path: compoundPath) }
        
        let request = Alamofire.request(url,
                                        method: .get,
                                        headers: api.headers())
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
                                        headers: api.headers())
        api.get(request, successHandler: { (result) in
            successHandler(result as AnyObject)
        }) { (response, result, error) in
            failureHandler(response, result, error)
        }
    }
    
    public func fetchWalletDetails(walletId: String,
                                   successHandler: @escaping PrvdApiSuccessHandler,
                                   failureHandler: @escaping PrvdApiFailureHandler) throws {
        let compoundPath = "\(wallets)/\(walletId)"
        guard let url = api.buildGoldmineUrl(path: compoundPath) else { throw ProvideError.invalidUrl(path: compoundPath) }
        
        let request = Alamofire.request(url,
                                        method: .get,
                                        headers: api.headers())
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
                                        headers: api.headers())
        api.post(request, successHandler: { (result) in
            successHandler(result as AnyObject)
        }) { (response, result, error) in
            failureHandler(response, result, error)
        }
    }
    
}
