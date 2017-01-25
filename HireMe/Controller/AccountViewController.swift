//
//  AccountViewController.swift
//  HireMe
//
//  Created by AJ Bronson on 11/3/16.
//  Copyright © 2016 AJ Bronson. All rights reserved.
//

import FBSDKLoginKit

class AccountViewController: UITableViewController {
	
    var fbUserData: [String: Any]?
    private var name = ""
    
	//MARK: - ViewController Lifecycle
	
	override func viewDidLoad() {
		super.viewDidLoad()
		tableView.separatorStyle = .none
        
        self.name = self.fbUserData!["name"] as! String
	}
	
    
	//MARK: - UITableViewDataSource callbacks
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
	
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0: return 5
        case 1: return 1
        default: return 1
        }
	}
	
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "accountCell", for: indexPath)
            
            switch indexPath.row {
            case 0:
                cell.textLabel?.text = "Name: \(self.name)"
            case 1:
                cell.textLabel?.text = "Skills: Tech, dogs, yard"
            case 2:
                cell.textLabel?.text = "Number: 888-888-8888"
            case 3:
                cell.textLabel?.text = "Email: jmack@gmail.com"
            default:
                cell.textLabel?.text = "Change Password"
            }
            
            return cell
        default:
            return tableView.dequeueReusableCell(withIdentifier: "logOutCell", for: indexPath)
        }
	}
    
    
    // MARK: - UITableViewDelegate callbacks
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let reuseId = tableView.cellForRow(at: indexPath)?.reuseIdentifier
        
        if reuseId == "logOutCell" {
            if let _ = FBSDKAccessToken.current() {
                // User is currently logged in with Facebook
                
                let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
                alertController.popoverPresentationController?.sourceView = self.view
                alertController.popoverPresentationController?.sourceRect = self.view.bounds;
                alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
                alertController.addAction(UIAlertAction(title: "Log Out", style: .destructive, handler: { (action) in
                    FBSDKLoginManager().logOut()
                    
                    // TODO: show Login screen, following doesn't work
//                    self.performSegue(withIdentifier: "unwindToLogin", sender: nil)
                }))
                self.present(alertController, animated: true, completion: nil)
            }
        }
    }
}
