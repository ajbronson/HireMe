//
//  ProviderTabBarController.swift
//  HireMe
//
//  Created by Nathan Johnson on 1/24/17.
//  Copyright © 2017 AJ Bronson. All rights reserved.
//

import SideMenu

class ProviderTabBarController: UITabBarController {
    var tabBarItemJobs, tabBarItemBids: UITabBarItem?
    
    
    // MARK: View controller life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Customize side menu
        SideMenuManager.menuPresentMode = .menuSlideIn
        SideMenuManager.menuAnimationFadeStrength = 0.5
        
        if let tabBarItems = self.tabBar.items {
            // If the order of the tabs changes in the storyboard, the indexes will have to be changed accordingly
            self.tabBarItemJobs = tabBarItems[1] // My Jobs
            self.tabBarItemBids = tabBarItems[2] // My Bids
        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.enableTabBarItems), name: gSignInNotificationName, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.disableTabBarItems), name: signOutNotificationName, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.presentSignInViewController), name: signInRowNotificationName, object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if isSignedIn() {
            self.enableTabBarItems()
        } else {
            self.disableTabBarItems()
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    
    // MARK: - Custom functions
    
    func disableTabBarItems() {
        //show search VC and hide the rest
        self.selectedViewController = self.viewControllers?.first
        self.tabBarItemJobs?.isEnabled = false
        self.tabBarItemBids?.isEnabled = false
    }
    
    func enableTabBarItems() {
        self.tabBarItemJobs?.isEnabled = true
        self.tabBarItemBids?.isEnabled = true
    }
    
    func presentSignInViewController() {
        self.performSegue(withIdentifier: "presentSignIn", sender: nil)
    }
}
