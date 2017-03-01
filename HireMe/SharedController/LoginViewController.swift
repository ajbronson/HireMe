//
//  LoginViewController.swift
//  HireMe
//
//  Created by Nathan Johnson on 1/17/17.
//  Copyright © 2017 AJ Bronson. All rights reserved.
//

import FBSDKLoginKit

// TODO: show an alert before signing in with Google and Facebook informing the user of what data we'll be accessingf
class LoginViewController: UIViewController, FBSDKLoginButtonDelegate {
    
    
    // MARK: - Outlets
    
    @IBOutlet weak var fbLoginButton: FBSDKLoginButton!
    
    
    // MARK: - View controller life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fbLoginButton.delegate = self
        fbLoginButton.readPermissions = ["public_profile", "email"]
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
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
    
    @IBAction func skipTapped(_ sender: UIButton) {
        self.performSegue(withIdentifier: "showTabs", sender: nil)

		//TODO: this code sends to consumer views
		//let storyboard = UIStoryboard(name: "ConsumerStoryboard", bundle: nil)
		//let vc = storyboard.instantiateViewController(withIdentifier: "RootNavConsumerView") as? UINavigationController
		//UIApplication.shared.windows[0].rootViewController = vc
    }
}
