//
//  MenuViewController.swift
//  HireMe
//
//  Created by Nathan Johnson on 1/20/17.
//  Copyright © 2017 AJ Bronson. All rights reserved.
//

import FBSDKLoginKit

class MenuViewController: UITableViewController {
    
    var fbUserData: [String: Any]?
    
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showSettings" {
            let settingsVC = segue.destination as! AccountViewController
            settingsVC.fbUserData = self.fbUserData
        }
    }
    
    
    // MARK: - UITableViewDataSource callbacks
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return self.fbUserData?["name"] as? String
    }
}
