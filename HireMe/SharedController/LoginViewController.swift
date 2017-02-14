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
    
    
    // MARK: - Outlets
    
    @IBOutlet weak var fbLoginButton: FBSDKLoginButton!
    @IBOutlet weak var signUpBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var verticalSpacingBetweenButtons: NSLayoutConstraint!
    
    
    // MARK: - View controller life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        GIDSignIn.sharedInstance().uiDelegate = self
        
        fbLoginButton.delegate = self
        fbLoginButton.readPermissions = ["public_profile", "email"]
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        self.navigationController?.navigationBar.barTintColor = UIColor(red:0.88, green:0.97, blue:0.98, alpha:1.0) // #E0F7FA
        
        // Sets background to a blank/empty image
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        
        // Sets shadow (line below the bar) to a blank image
        self.navigationController?.navigationBar.shadowImage = UIImage()
    }
    
//    override func viewWillDisappear(_ animated: Bool) {
//        super.viewWillDisappear(animated)
//        
//        // Restore background
//        self.navigationController?.navigationBar.setBackgroundImage(nil, for: .default)
//
//        // Restore shadow (line below the bar)
//        self.navigationController?.navigationBar.shadowImage = nil
//    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        // Restore background
        self.navigationController?.navigationBar.setBackgroundImage(nil, for: .default)
        
        // Restore shadow (line below the bar)
        self.navigationController?.navigationBar.shadowImage = nil
    }
    
    
    // MARK: - FBSDKLoginButtonDelegate callbacks
    
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
        if (error == nil) {
            print("Signed in with Facebook")
            
            // TODO: start animating spinner
            FBSDKGraphRequest(graphPath: "me", parameters: ["fields": "name, picture.type(large), email"]).start { (connection, result, error) in
                if error == nil {
                    UserDefaults.standard.set(result, forKey: "fbUserProfile")
                    self.performSegue(withIdentifier: "showTabs", sender: nil)
                }
            }
        }
    }
    
    // Required by protocol
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) { /* do nothing */ }
    
    
    // MARK: - IBActions
    
    @IBAction func signInTapped(_ sender: UIButton) {
//        self.performSegue(withIdentifier: "showTabs", sender: nil)
    }
    
    @IBAction func signUpTapped(_ sender: UIButton) {
        // Custom code
    }
    
    @IBAction func skipTapped(_ sender: UIBarButtonItem) {
        self.performSegue(withIdentifier: "showTabs", sender: nil)
    }
}
