//
//  LoginViewController.swift
//  provide_Example
//
//  Created by Kevin Munc on 10/7/18.
//  Copyright © 2018 Provide. All rights reserved.
//

import UIKit
import provide

class LoginViewController: UIViewController {
    
    @IBOutlet private var networkField: UITextField!
    @IBOutlet private var emailField: UITextField!
    @IBOutlet private var passwordField: UITextField!
    @IBOutlet private var submitButton: UIButton!
    
    // MARK: - Lifecycle Methods
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if let storedNetworkId = UserDefaults.standard.object(forKey: networkIdKey) as? String {
            networkField.text = storedNetworkId
        } else {
            networkField.text = "7704f95f-db4d-444a-9f89-cc7cc37bcc2b" // prod
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    // MARK: - Action Methods

    /**
     * Go to https://dawn.provide.services/#/signup if you need an account.
     */
    @IBAction func login(sender: Any) {
        do {
            UserDefaults.standard.set(networkField.text, forKey: networkIdKey)
            try performAuthentication(email: emailField.text!, password: passwordField.text!)
        } catch let error {
            showAlert(title: "Authentication Error", message: String(describing: error))
        }
    }
    
    // MARK: - Private Methods
    
    private func performAuthentication(email: String, password: String) throws {
        try ProvideIdent().authenticate(email: email,
                                        password: password,
                                        successHandler:
            { [weak self] (result) in
                if let authToken = result as? String {
                    print("PRVD: Acquired auth token")
                    ProvideKeychainService.shared.authToken = authToken
                    self?.performSegue(withIdentifier: "LoginSegue", sender: nil)
                } else {
                    self?.showAlert(title: "Unexpected Result", message: String(describing: result))
                }
        }) { [weak self] (response, result, error) in
            var statusString = ""
            if let response = response {
                statusString = "\(response.statusCode) "
            }
            self?.showAlert(title: "Error", message: "\(statusString)Error: \(String(describing: error))")
        }
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

extension LoginViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case networkField:
            emailField.becomeFirstResponder()
            return true
        case emailField:
            passwordField.becomeFirstResponder()
            return true
        default:
            view.endEditing(true)
            return true
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let networkText = networkField.text, let emailText = emailField.text, let passwordText = passwordField.text else {
            return true
        }
        
        if networkText.count > 0 && emailText.count > 0 && passwordText.count > 0 {
            submitButton.isEnabled = true
        } else {
            submitButton.isEnabled = false
        }
        return true
    }
    
}
