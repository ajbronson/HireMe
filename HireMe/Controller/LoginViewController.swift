//
//  LoginViewController.swift
//  HireMe
//
//  Created by Nathan Johnson on 1/17/17.
//  Copyright © 2017 AJ Bronson. All rights reserved.
//

import FBSDKLoginKit
import GoogleSignIn

// TODO: show an alert before signing in with Google and Facebook informing the user of what data we'll be accessingf
class LoginViewController: UIViewController, FBSDKLoginButtonDelegate, GIDSignInUIDelegate {
    
    // MARK: - Constants
    
    let BOTTOM_SPACING_PORTRAIT: CGFloat    = 175
    let BOTTOM_SPACING_LANDSCAPE: CGFloat   = 15
    let VERTICAL_SPACING_PORTRAIT: CGFloat  = 20
    let VERTICAL_SPACING_LANDSCAPE: CGFloat = 15
    
    
    // MARK: - Outlets
    
    @IBOutlet weak var fbLoginButton: FBSDKLoginButton!
    @IBOutlet weak var signUpBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var verticalSpacingBetweenButtons: NSLayoutConstraint!
    
    
    // MARK: - View controller life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        GIDSignIn.sharedInstance().uiDelegate = self
//        GIDSignIn.sharedInstance().delegate = self
        
        fbLoginButton.delegate = self
        fbLoginButton.readPermissions = ["public_profile", "email"]
        print("viewDidLoad rootViewController class: \(UIApplication.shared.delegate?.window??.rootViewController?.className)")
    }
    
    
    // MARK: Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print("preparing to show tabs")
        print("prepareForSegue rootViewController class: \(UIApplication.shared.delegate?.window??.rootViewController?.className)")
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
    
    
    // MARK: - FBSDKLoginButtonDelegate callbacks
    
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
        if (error == nil) {
            print("Signed in with Facebook")
            
            // TODO: start animating spinner
            FBUserProfileController().fbGraphRequest(completionHandler: { (connection, result, error) in
                if error == nil {
                    UserDefaults.standard.set(result, forKey: "fbUserProfile")
                    self.performSegue(withIdentifier: "showTabs", sender: nil)
                }
            })
        }
    }
    
    // Required by protocol
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) { /* do nothing */ }
    
    
    // MARK: GIDSignInDelegate callbacks
    
//    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
//        if error == nil {
//            print("Signed in with Google")
//            //            let userId = user.userID                  // For client-side use only!
//            //            let idToken = user.authentication.idToken // Safe to send to the server
//            
//            let googleUserProfile = [
//                "fullName": user.profile.name,
//                "givenName": user.profile.givenName,
//                "familyName": user.profile.familyName,
//                "email": user.profile.email
//            ]
//            
//            UserDefaults.standard.set(googleUserProfile, forKey: "googleUserProfile")
//            self.performSegue(withIdentifier: "showTabs", sender: nil)
//        } else {
//            print("\(error.localizedDescription)")
//        }
//    }
    
    
    // MARK: - IBActions
    
    @IBAction func signInTapped(_ sender: UIButton) {
        self.performSegue(withIdentifier: "showTabs", sender: nil)
    }
    
    @IBAction func signUpTapped(_ sender: UIButton) {
        // Custom code
    }
}
