//
//  TruePollViewController.swift
//  Provide_Example
//
//  Created by Kyle Thomas on 2/7/19.
//  Copyright © 2019 Provide. All rights reserved.
//

import UIKit
import provide

class TruePollViewController: UIViewController {

    // MARK: - Lifecycle Methods

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        let serverToken = ""
        ProvideKeychainService.shared.authToken = serverToken
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }

    // MARK: - Action Methods

    @IBAction func submit(sender: Any) {
        log("\(sender)")

        try? ProvideGoldmine().executeContract(contractId: "c252c025-00f4-48db-a9f7-37585945acde",
                                               parameters: [ "walletId": "a68a35d9-a299-4c22-9278-a0bb63173c73", "method": "winningProposal", "value": 0, "params": [] ],
                                               successHandler: { (result) in
                                                log("Executed smart contract; \(String(describing: result))")
        }, failureHandler: { (response, result, error) in
            log("Failed to execute conract; \(String(describing: response))")
        })
    }

    // MARK: - Helper Methods

    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: NSLocalizedString("OK", comment: "Alert button"), style: .default) { [weak self] (action) in
            self?.dismiss(animated: true, completion: nil)
        }
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }

}
