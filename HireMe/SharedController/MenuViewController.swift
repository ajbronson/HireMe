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
    
    
    // MARK: - View controller life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.hideEmptyCells()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.initializeUserProfile()
        
        if let fbUser = self.fbUserProfile {
            self.name = fbUser["name"] as? String
        } else if let googleUser = self.googleUserProfile {
            self.name = googleUser["fullName"]
        }
    }
    
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "editAccount" {
            if let editAccountNavC = segue.destination as? UINavigationController,
                let accountVC = editAccountNavC.childViewControllers.first as? AccountViewController {
                accountVC.fbUserProfile = self.fbUserProfile
                accountVC.googleUserProfile = self.googleUserProfile
            }
        }
    }
    
    
    // MARK: - UITableViewDataSource
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return self.name
    }
    
    
    // MARK: Custom functions
    
    private func initializeUserProfile() {
        print("Initializing user profile...") // DEBUG
        switch getSignInMethod() {
        case .Facebook:
            print("Facebook token: \(FBSDKAccessToken.current().tokenString)")
            self.resetUserProfiles()
            self.fbUserProfile = UserDefaults.standard.dictionary(forKey: "fbUserProfile")
            print("Facebook profile initialized") // DEBUG
        case .Google:
            self.resetUserProfiles()
            self.googleUserProfile = UserDefaults.standard.dictionary(forKey: "googleUserProfile") as? [String: String]
            print("Google profile initialized") // DEBUG
        case .ThisApp:
            print("LimitedHire profile initialized") // DEBUG
            self.resetUserProfiles()
        case .NotSignedIn:
            print("Not signed in") // DEBUG
        }
    }
    
    private func resetUserProfiles() {
        self.fbUserProfile = nil
        self.googleUserProfile = nil
    }
}
