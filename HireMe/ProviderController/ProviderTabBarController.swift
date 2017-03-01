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
    
    private var fbUserProfile: [String: Any]?
    private var googleUserProfile: [String: String]?
    
    
    // MARK: View controller life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Customize side menu
        SideMenuManager.menuPresentMode = .menuSlideIn
        SideMenuManager.menuAnimationFadeStrength = 0.5
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = false
        
        if isSignedIn() == false {
            //show search VC and hide the rest
            self.selectedViewController = self.viewControllers?.last
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.isProviderTabsVisible = false
    }
}
