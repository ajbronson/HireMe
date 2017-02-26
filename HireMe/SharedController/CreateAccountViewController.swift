//
//  CreateAccountViewController.swift
//  HireMe
//
//  Created by Nathan Johnson on 1/17/17.
//  Copyright © 2017 AJ Bronson. All rights reserved.
//

import UIKit

class CreateAccountViewController: UITableViewController, UITextFieldDelegate {
    
    // MARK: - Outlets
    
    @IBOutlet weak var usernameTextField: NextControlTextField!
    @IBOutlet weak var firstNameTextField: NextControlTextField!
    @IBOutlet weak var lastNameTextField: NextControlTextField!
    @IBOutlet weak var phoneNumberTextField: NextControlTextField!
    @IBOutlet weak var zipCodeTextField: NextControlTextField!
    @IBOutlet weak var emailTextField: NextControlTextField!
    @IBOutlet weak var passwordTextField: NextControlTextField!
    @IBOutlet weak var reEnterPasswordTextField: NextControlTextField!
    
    
    // MARK: - Properties
    
    var keyboardIsVisible = false
    
    
    // MARK: - View controller life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.registerForKeyboardNotifications()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    
    // MARK: - UITableViewDelegate
    
    override func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        AlertHelper.showAlert(view: self, title: "Why is my ZIP code needed?", message: "We use your ZIP code to match you with providers near you.", closeButtonText: "Got it")
    }
    
    
    // MARK: - UITextFieldDelegate
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {        
        if let nextControlTextField = textField as? NextControlTextField {
            nextControlTextField.addToolbarAboveKeyboard()
        }
        
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let txtField = textField as? NextControlTextField {
            txtField.transferFirstResponderToNextControl(completionHandler: { (didTransfer) in
                if !didTransfer {
                    // User finished verifying password, save account
                    self.printAccountDetails()
                }
            })
        }
        
        return false // Do not add a line break
    }
    
    
    // MARK: - IBActions
    
    @IBAction func saveTapped(_ sender: UIBarButtonItem) {
        if self.keyboardIsVisible {
            self.view.endEditing(true) // Hide keyboard if showing
        }
        
        // TODO: create and save their account
        self.printAccountDetails()
    }
    
    
    // MARK: - Custom functions
    
    func registerForKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector:#selector(self.keyboardDidShow(_:)), name: .UIKeyboardDidShow, object: nil)
        NotificationCenter.default.addObserver(self, selector:#selector(self.keyboardDidHide(_:)), name: .UIKeyboardDidHide, object: nil)
    }
    
    func keyboardDidShow(_ notification: Notification) {
        self.keyboardIsVisible = true
    }
    
    func keyboardDidHide(_ notification: Notification) {
        self.keyboardIsVisible = false
    }
    
    func printAccountDetails() {
        print("Username: \(self.usernameTextField.text)")
        print("First Name: \(self.firstNameTextField.text)")
        print("Last Name: \(self.lastNameTextField.text)")
        print("Phone: \(self.phoneNumberTextField.text)")
        print("ZIP Code: \(self.zipCodeTextField.text)")
        print("Email: \(self.emailTextField.text)")
        print("Password: \(self.passwordTextField.text)")
        print("Re-entered password: \(self.reEnterPasswordTextField.text)")
    }
}
