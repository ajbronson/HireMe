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
        
        if let tabBarItems = self.tabBar.items {
            // If the order of the tabs changes in the storyboard, the indexes will have to be changed accordingly
            self.tabBarItemJobs = tabBarItems[1] // My Jobs
            self.tabBarItemBids = tabBarItems[2] // My Bids
        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.enableTabBarItems), name: gSignInNotificationName, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.disableTabBarItems), name: signOutNotificationName, object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if AuthenticationManager.shared.isSignedIn {
            self.enableTabBarItems()
        } else if AuthenticationManager.authAlertHasDisplayed() {
            self.disableTabBarItems()
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    
    // MARK: - UITabBarControllerDelegate
    
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        if AuthenticationManager.shared.isSignedIn == false && (viewController.restorationIdentifier == "ProviderJobsNavigationController" || viewController.restorationIdentifier == "BidsNavigationController") {
            guard let jobsTitle = self.tabBarItemJobs?.title, let bidsTitle = self.tabBarItemBids?.title else {
                return false
            }
            
            let message = "You must be signed in to view \"\(jobsTitle)\" and \"\(bidsTitle)\"."
            let alert = UIAlertController(title: "Authentication Required", message: message, preferredStyle: .alert)
            let cancel = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            let signIn = UIAlertAction(title: "Sign In", style: .default, handler: { (action) in
                guard let signInNavController = UIStoryboard(name: "MenuStoryboard", bundle: nil).instantiateViewController(withIdentifier: "SignInNavigationController") as? UINavigationController else { return }
                self.present(signInNavController, animated: true, completion: nil)
            })
            
            alert.addAction(cancel)
            alert.addAction(signIn)
            self.present(alert, animated: true, completion: {
                UserDefaults.standard.set(true, forKey: AUTH_ALERT_KEY)
                self.disableTabBarItems()
            })
            
            return false
        }
        
        return true
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
}
