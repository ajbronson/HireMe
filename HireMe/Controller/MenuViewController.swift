//
//  MenuViewController.swift
//  HireMe
//
//  Created by Nathan Johnson on 1/20/17.
//  Copyright © 2017 AJ Bronson. All rights reserved.
//

import FBSDKLoginKit

class MenuViewController: UITableViewController {
    
    var fbUserProfile: [String: Any]?
    var googleUserProfile: [String: String]?
    
    
    // MARK: Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showSettings" {
            if let settingsVC = segue.destination as? AccountViewController {
                settingsVC.fbUserProfile = self.fbUserProfile
                settingsVC.googleUserProfile = self.googleUserProfile
            }
        }
    }
    
    
    // MARK: UITableViewDataSource callbacks
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return self.fbUserProfile?["name"] as? String
    }
}
