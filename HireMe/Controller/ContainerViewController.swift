//
//  ContainerViewController.swift
//  HireMe
//
//  Created by Nathan Johnson on 1/20/17.
//  Copyright © 2017 AJ Bronson. All rights reserved.
//

import UIKit

let SCREEN_WIDTH_PCT: CGFloat = 0.8

class ContainerViewController: UIViewController {
    var leftViewController: UIViewController? {
        willSet {
            if let leftVC = self.leftViewController {
                if let leftView = leftVC.view {
                    leftView.removeFromSuperview()
                }
                
                leftVC.removeFromParentViewController()
            }
        }
        
        didSet {
            self.view!.addSubview(self.leftViewController!.view)
            self.addChildViewController(self.leftViewController!)
            
            // Start out hidden
            self.leftViewController!.view.frame = makeCGRect(forWidth: 0)
        }
    }
    
    var rightViewController: UIViewController? {
        willSet {
            if let rightVC = self.rightViewController {
                if let rightView = rightVC.view {
                    rightView.removeFromSuperview()
                }
                
                rightVC.removeFromParentViewController()
            }
        }
        
        didSet {
            self.view!.addSubview(self.rightViewController!.view)
            self.addChildViewController(self.rightViewController!)
        }
    }
    
    let menuWidth: CGFloat = UIScreen.main.bounds.width * SCREEN_WIDTH_PCT
    var menuIsVisible = false

    
    // MARK: - View controller life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let clientNavigationController: UINavigationController = storyboard.instantiateViewController(withIdentifier: "ClientNavigationController") as! UINavigationController
        let menuViewController: MenuViewController = storyboard.instantiateViewController(withIdentifier: "MenuViewController") as! MenuViewController
        
        self.rightViewController = clientNavigationController
        self.leftViewController = menuViewController
    }
    
    
    // MARK: - IBActions
    
    @IBAction func swipeRight(sender: UISwipeGestureRecognizer) {
        showMenu()
    }
    
    @IBAction func swipeLeft(sender: UISwipeGestureRecognizer) {
        hideMenu()
    }
    
    
    // MARK: - Custom functions
    
    func showMenu() {
        UIView.animate(withDuration: 0.3, animations: {
            self.leftViewController!.view.frame = self.makeCGRect(forWidth: self.menuWidth)
        }, completion: { (Bool) -> Void in
            self.menuIsVisible = true
        })
    }
    
    func hideMenu() {
        UIView.animate(withDuration: 0.3, animations: {
            self.leftViewController!.view.frame = self.makeCGRect(forWidth: 0)
        }, completion: { (Bool) -> Void in
            self.menuIsVisible = false
        })
    }
    
    func makeCGRect(forWidth width: CGFloat) -> CGRect {
        return CGRect(x: self.view.frame.origin.x, y: self.view.frame.origin.y, width: width, height: self.view.frame.height)
    }
}
