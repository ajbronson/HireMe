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

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
    }

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


    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */
    
    
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
                        case .NotSignedIn:
                            print("Not signed in") // DEBUG
                        }
                        
                        print("SettingsViewController's parent \(self.parent?.descr)") // DEBUG
                        print("SettingsViewController's parent's parent \(self.parent?.parent?.descr)") // DEBUG
                        print("presentingViewController \(self.presentingViewController?.descr)") // DEBUG
                    })
                }))
                
                self.present(alertController, animated: true, completion: nil)
            } else {
                //segue to sign in screen
                self.performSegue(withIdentifier: "showSignIn", sender: nil)
            }
        }

    }
    
    
    // MARK: - IBActions

    @IBAction func doneTapped(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showSignIn",
            let signInNavVC = segue.destination as? UINavigationController,
            let signInVC = signInNavVC.childViewControllers.first as? SignInViewController {
            signInVC.didSegueFromSettings = true
        }
    }
}
