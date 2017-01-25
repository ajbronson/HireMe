//
//  LoginViewController.swift
//  HireMe
//
//  Created by Nathan Johnson on 1/17/17.
//  Copyright © 2017 AJ Bronson. All rights reserved.
//

import FBSDKLoginKit

class LoginViewController: UIViewController, FBSDKLoginButtonDelegate {
    
    // MARK: - Constants
    
    let BOTTOM_SPACING_PORTRAIT: CGFloat    = 175
    let BOTTOM_SPACING_LANDSCAPE: CGFloat   = 15
    let VERTICAL_SPACING_PORTRAIT: CGFloat  = 20
    let VERTICAL_SPACING_LANDSCAPE: CGFloat = 15
    
    
    // MARK: - Outlets
    
    @IBOutlet weak var fbLoginButton: FBSDKLoginButton!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signUpBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var verticalSpacingBetweenButtons: NSLayoutConstraint!
    
    
    // MARK: - Properties
    
    private var fbUserProfile: [String: Any]!
    
    
    // MARK: - View controller life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fbLoginButton.delegate = self
        fbLoginButton.readPermissions = ["public_profile", "email"]
    }
    
    //This will dismiss the keyboard and resign any UITextField as first responder when the user taps outside of the text fields
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
        super.touchesBegan(touches, with: event)
    }
    
//    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
//        if UIDevice.current.orientation.isLandscape {
//            self.signUpBottomConstraint.constant = BOTTOM_SPACING_LANDSCAPE
//            self.verticalSpacingBetweenButtons.constant = VERTICAL_SPACING_LANDSCAPE
//        } else {
//            self.signUpBottomConstraint.constant = BOTTOM_SPACING_PORTRAIT
//            self.verticalSpacingBetweenButtons.constant = VERTICAL_SPACING_PORTRAIT
//        }
//    }
    
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "showTabs") {
            let tabBarController = segue.destination.childViewControllers.first as! ProviderTabBarController
            tabBarController.fbUserProfile = self.fbUserProfile
        }
    }
    
    @IBAction func prepare(forLogOutUnwind segue: UIStoryboardSegue) {
        print("back to log in from log out")
    }
    
    
    // MARK: - FBSDKLoginButtonDelegate methods
    
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
        if (error == nil) {
            FBUserProfileController().fbGraphRequest(completionHandler: { (connection, result, error) in
                if error == nil {
                    self.fbUserProfile = result as! [String: Any]
                    self.performSegue(withIdentifier: "showTabs", sender: nil)
                }
            })
        }
    }
    
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        // Custom code
        print("Logged out from Facebook")
    }
    
    
    // MARK: - IBActions
    
    @IBAction func loginTapped(_ sender: UIButton) {
        // Custom code
    }
    
    @IBAction func signUpTapped(_ sender: UIButton) {
        // Custom code
    }
}
