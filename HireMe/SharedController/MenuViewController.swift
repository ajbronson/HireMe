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
    private var name: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let fbUser = self.fbUserProfile {
            self.name = fbUser["name"] as? String
        } else if let googleUser = self.googleUserProfile {
            self.name = googleUser["fullName"]
        }
    }
    
    
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
        return self.name
    }
}
