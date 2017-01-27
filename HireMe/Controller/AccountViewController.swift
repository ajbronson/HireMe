//
//  AccountViewController.swift
//  HireMe
//
//  Created by AJ Bronson on 11/3/16.
//  Copyright © 2016 AJ Bronson. All rights reserved.
//

import FBSDKLoginKit
import GoogleSignIn

class AccountViewController: UITableViewController {
	
    var fbUserProfile: [String: Any]?
    var googleUserProfile: [String: String]?
    private var name: String?
    private var email: String?
    
	//MARK: View controller life cycle
	
	override func viewDidLoad() {
		super.viewDidLoad()
		tableView.separatorStyle = .none
        
        if let fbUser = self.fbUserProfile {
            self.name = fbUser["name"] as? String
            self.email = fbUser["email"] as? String
        } else {
            self.name = self.googleUserProfile?["fullName"]
            self.email = self.googleUserProfile?["email"]
        }
	}
	
    
	//MARK: UITableViewDataSource callbacks
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
	
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0: return 5
        default: return 1
        }
	}
	
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
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
        default:
            return tableView.dequeueReusableCell(withIdentifier: "logOutCell", for: indexPath)
        }
	}
    
    
    // MARK: - UITableViewDelegate callbacks
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let reuseId = tableView.cellForRow(at: indexPath)?.reuseIdentifier
        
        if reuseId == "logOutCell" {
            let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
            alertController.popoverPresentationController?.sourceView = self.view
            alertController.popoverPresentationController?.sourceRect = self.view.bounds;
            alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            alertController.addAction(UIAlertAction(title: "Log Out", style: .destructive, handler: { (action) in
                if FBSDKAccessToken.current() != nil {
                    FBSDKLoginManager().logOut()
                } else if GIDSignIn.sharedInstance().currentUser != nil {
                    GIDSignIn.sharedInstance().signOut()
                } else {
                    print("sign out natively")
                }
                
                
//                let storyboard = UIStoryboard(name: "Provider", bundle: Bundle.main)
//                let appDelegate = UIApplication.shared.delegate as! AppDelegate
                if LoginViewController().isViewLoaded {
                    print("LoginViewController is loaded")
                } else {
                    print("LoginViewController is not loaded")
                }
//                self.performSegue(withIdentifier: "unwindToLogin", sender: nil)
            }))
            
            self.present(alertController, animated: true, completion: nil)
            
        }
    }
}
