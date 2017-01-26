//
//  ProviderTabBarController.swift
//  HireMe
//
//  Created by Nathan Johnson on 1/24/17.
//  Copyright © 2017 AJ Bronson. All rights reserved.
//

import SideMenu
import FBSDKLoginKit

class ProviderTabBarController: UITabBarController {
    
    var fbUserProfile: [String: Any]?
    
    
    // MARK: - View controller life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Customize side menu
        SideMenuManager.menuPresentMode = .menuSlideIn
        
        if self.fbUserProfile == nil && FBSDKAccessToken.current() != nil {
            FBUserProfileController().fbGraphRequest(completionHandler: { (connection, result, error) in
                if (error == nil) {
                    self.fbUserProfile = result as? [String: Any]
                }
            })
        }
    }
    
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "menu" {
            let menuVC = segue.destination.childViewControllers.first as! MenuViewController
            menuVC.fbUserData = self.fbUserProfile
        }
    }
}
