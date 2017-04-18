//
//  ProviderTabBarController.swift
//  HireMe
//
//  Created by Nathan Johnson on 1/24/17.
//  Copyright © 2017 AJ Bronson. All rights reserved.
//

import SideMenu

class ProviderTabBarController: UITabBarController, UITabBarControllerDelegate {
    
    var tabBarItemJobs, tabBarItemBids: UITabBarItem?
    
    // MARK: View controller life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.delegate = self;
        
        // Customize side menu
        SideMenuManager.menuPresentMode = .menuSlideIn
        SideMenuManager.menuAnimationFadeStrength = 0.5
    }
    
    // MARK: - UITabBarControllerDelegate
    
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        if AuthenticationManager.shared.isSignedIn == false && (viewController.restorationIdentifier != "SearchNavigationController") {
            performSegue(withIdentifier: "presentSignIn", sender: nil)
            
            return false
        }
        
        return true
    }
    
}
