//
//  ClientTabBarController.swift
//  HireMe
//
//  Created by Nathan Johnson on 1/20/17.
//  Copyright © 2017 AJ Bronson. All rights reserved.
//

import SideMenu

class ClientTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Customize side menu
        SideMenuManager.menuPresentMode = .menuSlideIn
    }
}
