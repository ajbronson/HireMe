//
//  AccountViewController.swift
//  HireMe
//
//  Created by AJ Bronson on 11/3/16.
//  Copyright © 2016 AJ Bronson. All rights reserved.
//

import UIKit

class AccountViewController: UITableViewController {
	
    var fbUserProfile: [String: Any]?
    var googleUserProfile: [String: String]?
    private var name: String?
    private var email: String?
    
	// MARK: - View controller life cycle
	
	override func viewDidLoad() {
		super.viewDidLoad()
		tableView.separatorStyle = .none
        
        if let fbUser = self.fbUserProfile {
            self.name = fbUser["name"] as? String
            self.email = fbUser["email"] as? String
        } else if let googleUser = self.googleUserProfile {
            self.name = googleUser["fullName"]
            self.email = googleUser["email"]
        }
	}
	
    
	// MARK: - UITableViewDataSource
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
	
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
	}
	
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "accountCell", for: indexPath)
        
        switch indexPath.row {
        case 0:
            cell.textLabel?.text = "Name: \(self.name ?? "")"
        case 1:
            cell.textLabel?.text = "Skills: Tech, dogs, yard"
        case 2:
            cell.textLabel?.text = "Number: 888-888-8888"
        case 3:
            cell.textLabel?.text = "Email: \(self.email ?? "")"
        default:
            cell.textLabel?.text = "Change Password"
        }
        
        return cell
	}
    
    
    // MARK: - IBActions
    
    @IBAction func cancelTapped(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func saveTapped(_ sender: UIBarButtonItem) {
        print("Save profile")
    }
}
