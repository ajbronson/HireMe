//
//  ProviderTabBarController.swift
//  HireMe
//
//  Created by Nathan Johnson on 1/24/17.
//  Copyright © 2017 AJ Bronson. All rights reserved.
//

import SideMenu

class ProviderTabBarController: UITabBarController {
    
    var fbUserData: [String: Any]?
    
    
    // MARK: - View controller life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Customize side menu
        SideMenuManager.menuPresentMode = .menuSlideIn
    }
    
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "menu" {
            let menuVC = segue.destination.childViewControllers.first as! MenuViewController
            menuVC.fbUserData = self.fbUserData
        }
    }
}
