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

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */


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
        
        if reuseId == "signOutCell" {
            let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
            alertController.popoverPresentationController?.sourceView = self.view
            alertController.popoverPresentationController?.sourceRect = self.view.bounds;
            alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            alertController.addAction(UIAlertAction(title: "Sign Out", style: .destructive, handler: { (action) in
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
                
//                if let presentingVC = self.presentingViewController as? UINavigationController {
//                    presentingVC.printViewControllers()
//                    presentingVC.popToRootViewController(animated: true)
//
//                }
                
                if let parent = self.parent as? UINavigationController {
                    parent.printViewControllers() // DEBUG
                    parent.popToRootViewController(animated: true)
                }
            }))
            
            self.present(alertController, animated: true, completion: nil)
        }

    }
    
    
    // MARK: - IBActions

    @IBAction func doneTapped(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
