//
//  SettingsTableViewController.swift
//  HireMe
//
//  Created by Nathan Johnson on 2/18/17.
//  Copyright © 2017 AJ Bronson. All rights reserved.
//

import FBSDKLoginKit
import GoogleSignIn

class SettingsTableViewController: UITableViewController {

    // MARK: - UITableViewDataSource

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
            case 1:
                let cell = tableView.dequeueReusableCell(withIdentifier: "SignInOutCell", for: indexPath)
                
                if isSignedIn() {
                    cell.textLabel?.text = "Sign Out"
                    cell.textLabel?.textColor = .red
                } else {
                    cell.textLabel?.text = "Sign In"
                    cell.textLabel?.textColor = .black
                }
                
                return cell
            default:
                let cell = tableView.dequeueReusableCell(withIdentifier: "SettingsCell", for: indexPath)
                
                return cell
        }
    }
    
    
    // MARK: - UITableViewDelegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let reuseId = tableView.cellForRow(at: indexPath)?.reuseIdentifier
        
        if reuseId == "SignInOutCell" {
            if isSignedIn() {
                let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
                alertController.popoverPresentationController?.sourceView = self.view
                alertController.popoverPresentationController?.sourceRect = self.view.bounds;
                alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
                alertController.addAction(UIAlertAction(title: "Sign Out", style: .destructive, handler: { (action) in
                    self.dismiss(animated: true, completion: {
                        print("Signing out...") // DEBUG
                        switch getSignInMethod() {
                            case .Facebook:
                                FBSDKLoginManager().logOut()
                                print("Signed out from Facebook") // DEBUG
                            case .Google:
                                GIDSignIn.sharedInstance().signOut()
                                print("Signed out from Google") // DEBUG
                            case .ThisApp:
                                print("Signed out from LimitedHire") // DEBUG
                            default:
                                print("Not signed in") // DEBUG
                                break
                        }
                        
                        NotificationCenter.default.post(name: signOutNotificationName, object: nil)
                    })
                }))
                
                self.present(alertController, animated: true, completion: nil)
            } else {
                self.performSegue(withIdentifier: "showSignIn", sender: nil)
            }
        }

    }
    
    
    // MARK: - IBActions

    @IBAction func doneTapped(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
}
