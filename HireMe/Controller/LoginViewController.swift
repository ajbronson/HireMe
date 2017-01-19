//
//  LoginViewController.swift
//  HireMe
//
//  Created by Nathan Johnson on 1/17/17.
//  Copyright © 2017 AJ Bronson. All rights reserved.
//

import UIKit
import FacebookLogin
import FBSDKCoreKit

class LoginViewController: UIViewController {
    
    // MARK: - Constants
    
    let BOTTOM_SPACING_PORTRAIT: CGFloat    = 190
    let BOTTOM_SPACING_LANDSCAPE: CGFloat   = 15
    let VERTICAL_SPACING_PORTRAIT: CGFloat  = 20
    let VERTICAL_SPACING_LANDSCAPE: CGFloat = 15
    
    
    // MARK: - Outlets
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signUpBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var verticalSpacingBetweenButtons: NSLayoutConstraint!
    
    
    // MARK: - View controller life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let _ = FBSDKAccessToken.current() {
            // User is logged in, do work such as go to next view controller.
        }
        
        let fbLoginButton = LoginButton(readPermissions: [ .publicProfile ])
        fbLoginButton.center = view.center
        
        view.addSubview(fbLoginButton)
    }
    
    //This will dismiss the keyboard and resign any UITextField as first responder when the user taps outside of the text fields
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
        super.touchesBegan(touches, with: event)
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        if UIDevice.current.orientation.isLandscape {
            self.signUpBottomConstraint.constant = BOTTOM_SPACING_LANDSCAPE
            self.verticalSpacingBetweenButtons.constant = VERTICAL_SPACING_LANDSCAPE
        } else {
            self.signUpBottomConstraint.constant = BOTTOM_SPACING_PORTRAIT
            self.verticalSpacingBetweenButtons.constant = VERTICAL_SPACING_PORTRAIT
        }
    }
    
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "showTabs") {
            print("preparing...")
        }
    }
    
    
    // MARK: - IBActions
    
    @IBAction func loginTapped(_ sender: UIButton) {
        // Custom code
    }
    
    @IBAction func signUpTapped(_ sender: UIButton) {
        // Custom code
    }
}
