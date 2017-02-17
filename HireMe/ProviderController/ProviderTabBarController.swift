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
        SideMenuManager.menuAnimationFadeStrength = 0.5
        
        self.initializeUserProfile()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.isProviderTabsVisible = false
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
        print("Initializing user profile...") // DEBUG
        switch getSignInMethod() {
            case .Facebook:
                print("Facebook token: \(FBSDKAccessToken.current().tokenString)")
                self.fbUserProfile = UserDefaults.standard.dictionary(forKey: "fbUserProfile")
                print("Facebook profile initialized") // DEBUG
            case .Google:
                self.googleUserProfile = UserDefaults.standard.dictionary(forKey: "googleUserProfile") as? [String: String]
                print("Google profile initialized") // DEBUG
            case .ThisApp:
                print("Signed in with LimitedHire") // DEBUG
            case .NotSignedIn:
                print("Not signed in") // DEBUG
        }
    }
}
