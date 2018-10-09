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

    @IBOutlet private weak var insurerButton: UIButton!
    @IBOutlet private weak var employerButton: UIButton!
    @IBOutlet private weak var member1Button: UIButton!
    @IBOutlet private weak var member2Button: UIButton!
    @IBOutlet private weak var providerButton: UIButton!
    
    // MARK: - Lifecycle Methods

    override func viewDidLoad() {
        super.viewDidLoad()

        UserDefaults.standard.set("d0153fa1-a88a-4876-9545-f90948578406", forKey: applicationIdKey)
        ProvideKeychainService.shared.appApiToken = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJkYXRhIjp7fSwiZXhwIjpudWxsLCJpYXQiOjE1MzkwMjU0MjUsImp0aSI6ImEyYTk3NTFiLTkyOWUtNGEwMC05Y2NlLTlkMDNkYzBhMDJhMiIsInN1YiI6ImFwcGxpY2F0aW9uOmQwMTUzZmExLWE4OGEtNDg3Ni05NTQ1LWY5MDk0ODU3ODQwNiJ9.k-Xa-4CneLLheg5WtFXohAKn37uQ-NOwTbihLm7zfBs"
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if let storedNetworkId = UserDefaults.standard.object(forKey: networkIdKey) as? String {
            networkField.text = storedNetworkId
        } else {
            networkField.text = "024ff1ef-7369-4dee-969c-1918c6edb5d4" // prod
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)

        if let btn = sender as? UIButton {
            if btn == insurerButton {
                let insurerVC = segue.destination as! InsurerViewController

            } else if btn == employerButton {
                let employerVC = segue.destination as! EmployerViewController

            } else if btn == member1Button {
                let memberVC = segue.destination as! MemberViewController
                memberVC.memberAddr = member1Addr
                memberVC.memberContractId = member1ContractId

            } else if btn == member2Button {
                let memberVC = segue.destination as! MemberViewController
                memberVC.memberAddr = member2Addr
                memberVC.memberContractId = member2ContractId

            } else if btn == providerButton {
                let providerVC = segue.destination as! ProviderViewController
            }
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
