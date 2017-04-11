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
                self.dismiss(animated: true, completion: {
                    AuthenticationManager.shared.signOut()
                })
            }))
            
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
    // MARK: - IBActions

    @IBAction func doneTapped(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
}
