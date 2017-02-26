//
//  AccountViewController.swift
//  HireMe
//
//  Created by AJ Bronson on 11/3/16.
//  Copyright © 2016 AJ Bronson. All rights reserved.
//

import UIKit

class AccountViewController: UITableViewController {
	
    // MARK: - Outlets
    
    @IBOutlet weak var usernameTextField: NextControlTextField!
    @IBOutlet weak var firstNameTextField: NextControlTextField!
    @IBOutlet weak var lastNameTextField: NextControlTextField!
    @IBOutlet weak var phoneTextField: NextControlTextField!
    @IBOutlet weak var zipCodeTextField: NextControlTextField!
    @IBOutlet weak var emailTextField: NextControlTextField!
    
    
    // MARK: - Properties
    
    var fbUserProfile: [String: Any]?
    var googleUserProfile: [String: String]?
    
    
	// MARK: - View controller life cycle
	
	override func viewDidLoad() {
		super.viewDidLoad()
        self.populateTextFields()
	}
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let indexpath = self.tableView.indexPathForSelectedRow {
            self.tableView.deselectRow(at: indexpath, animated: true)
        }
    }
    
    
    // MARK: - UITableViewDelegate
    
//    override func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
//        if indexPath.section == 0 {
//            return false
//        }
//        
//        return true
//    }
    
    override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        if indexPath.section == 0 {
            return nil
        }
        
        return indexPath
    }
    
    
    // MARK: - IBActions
    
    @IBAction func cancelTapped(_ sender: UIBarButtonItem) {
        self.view.endEditing(true) // Hide keyboard if showing
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func saveTapped(_ sender: UIBarButtonItem) {
        print("Save profile")
    }
    
    
    // MARK: - Custom functions
    
    private func populateTextFields() {
        var name: String?
        var email: String?
        
        if let fbUser = self.fbUserProfile {
            name = fbUser["name"] as? String
            email = fbUser["email"] as? String
        } else if let googleUser = self.googleUserProfile {
            name = googleUser["fullName"]
            email = googleUser["email"]
        }
        
        self.firstNameTextField.text = name
        self.emailTextField.text = email
    }
}
