//
//  ProviderTabBarController.swift
//  HireMe
//
//  Created by Nathan Johnson on 1/24/17.
//  Copyright © 2017 AJ Bronson. All rights reserved.
//

import SideMenu
import FBSDKLoginKit
import GoogleSignIn

class ProviderTabBarController: UITabBarController {
    
    private var fbUserProfile: [String: Any]?
    private var googleUserProfile: [String: String]?
    
    
    // MARK: View controller life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Customize side menu
        SideMenuManager.menuPresentMode = .menuSlideIn
        
        self.initializeUserProfile()
    }
    
    
    // MARK: Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "menu" {
            if let menuVC = segue.destination.childViewControllers.first as? MenuViewController {
                menuVC.fbUserProfile = self.fbUserProfile
                menuVC.googleUserProfile = self.googleUserProfile
            }
        }
    }
    
    
    // MARK: Custom functions
    
    func initializeUserProfile() {
        if FBSDKAccessToken.current() != nil {
            // User is logged in with Facebook
            
            if let fbUserProfile = UserDefaults.standard.dictionary(forKey: "fbUserProfile") {
                self.fbUserProfile = fbUserProfile
            }
        }
        
        if GIDSignIn.sharedInstance().currentUser != nil {
            // User is logged in with Google
            self.googleUserProfile = UserDefaults.standard.dictionary(forKey: "googleUserProfile") as? [String: String]
        }
    }
}
