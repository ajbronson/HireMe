//
//  MenuHelper.swift
//  HireMe
//
//  Created by Nathan Johnson on 3/2/17.
//  Copyright © 2017 AJ Bronson. All rights reserved.
//

import SideMenu

class MenuHelper {
    static func showMenu(from viewController: UIViewController) {
        let storyboard = UIStoryboard(name: "MenuStoryboard", bundle: nil)
        
        if let vc = storyboard.instantiateViewController(withIdentifier: "SideMenuNavigationController") as? UISideMenuNavigationController {
            viewController.present(vc, animated: true, completion: nil)
        }
    }
}
