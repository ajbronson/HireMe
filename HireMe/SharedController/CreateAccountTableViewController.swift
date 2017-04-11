//
//  CreateAccountViewController.swift
//  HireMe
//
//  Created by Nathan Johnson on 1/17/17.
//  Copyright © 2017 AJ Bronson. All rights reserved.
//

import UIKit

class CreateAccountTableViewController: UITableViewController, UITextFieldDelegate {
    
    // MARK: - Outlets
    
    @IBOutlet weak var usernameTextField: NextPrevControlTextField!
    @IBOutlet weak var firstNameTextField: NextPrevControlTextField!
    @IBOutlet weak var lastNameTextField: NextPrevControlTextField!
    @IBOutlet weak var phoneNumberTextField: NextPrevControlTextField!
    @IBOutlet weak var zipCodeTextField: NextPrevControlTextField!
    @IBOutlet weak var emailTextField: NextPrevControlTextField!
    @IBOutlet weak var passwordTextField: NextPrevControlTextField!
    @IBOutlet weak var reEnterPasswordTextField: NextPrevControlTextField!
    
    
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
        if let txtField = textField as? NextPrevControlTextField {
            txtField.addToolbarAboveKeyboard()
        }
        
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let txtField = textField as? NextPrevControlTextField {
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
        print("Username: \(String(describing: self.usernameTextField.text))")
        print("First Name: \(String(describing: self.firstNameTextField.text))")
        print("Last Name: \(String(describing: self.lastNameTextField.text))")
        print("Phone: \(String(describing: self.phoneNumberTextField.text))")
        print("ZIP Code: \(String(describing: self.zipCodeTextField.text))")
        print("Email: \(String(describing: self.emailTextField.text))")
        print("Password: \(String(describing: self.passwordTextField.text))")
        print("Re-entered password: \(String(describing: self.reEnterPasswordTextField.text))")
    }
}
