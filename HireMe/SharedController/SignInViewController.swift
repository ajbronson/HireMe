//
//  SignInViewController.swift
//  HireMe
//
//  Created by Nathan Johnson on 2/10/17.
//  Copyright © 2017 AJ Bronson. All rights reserved.
//

import UIKit
import GoogleSignIn
import FBSDKLoginKit

class SignInViewController: UIViewController, UITextFieldDelegate, GIDSignInUIDelegate {

	//MARK: - Outlets

    @IBOutlet weak var emailTextField: NextPrevControlTextField!
    @IBOutlet weak var passwordTextField: NextPrevControlTextField!
    @IBOutlet weak var fbButton: UIButton!

    // MARK: - View controller life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.userDidSignInWithGoogle), name: gSignInNotificationName, object: nil)
        
        GIDSignIn.sharedInstance().uiDelegate = self
        
        self.emailTextField.bottomBorder()
        self.passwordTextField.bottomBorder()
    }
    
    // TODO: This probably won't be needed once it can actually sign in. When users sign out, they won't be directed to this screen
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.emailTextField.text = nil
        self.passwordTextField.text = nil
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    // MARK: - IBActions
    
    @IBAction func signInTapped(_ sender: UIButton) {
        print("Signed in with LimitedHire")
        self.dismiss(animated: true, completion: nil)
    }

    @IBAction func changePasswordTapped(_ sender: UIButton) {
        print("Change password")
    }
    
    @IBAction func createAccountTapped(_ sender: UIButton) {
        print("Create an account")
    }
    
    @IBAction func cancelTapped(_ sender: UIBarButtonItem) {
        self.view.endEditing(true) // Hide keyboard if showing
        self.dismiss(animated: true, completion: nil)
    }

    @IBAction func facebookTapped(_ sender: UIButton) {
        FBSDKLoginManager().logIn(withReadPermissions: ["public_profile", "email"], from: self) { (loginResult, error) in
            if let err = error {
                // TODO: handle error
                print(err.localizedDescription)
            } else {
                print("Facebook token: \(FBSDKAccessToken.current().tokenString)")
                self.getUser()
                
                if loginResult?.grantedPermissions != nil {
                    // https://developers.facebook.com/docs/graph-api/reference/user for a list of available fields
                    FBSDKGraphRequest(graphPath: "me", parameters: ["fields": "name, first_name, last_name, email"]).start { (connection, result, error) in
                        if error == nil {
                            guard let profile = result as? [String: Any] else {
                                return
                            }
                            
                            
                            // TODO: update user info
                            self.dismiss(animated: true, completion: nil)
                        } else {
                            print("\(String(describing: error?.localizedDescription))")
                        }
                    }
                }
            }
        }
    }
    
    @IBAction func googleTapped(_ sender: UIButton) {
        GIDSignIn.sharedInstance().signIn()
    }
    
    // MARK: - UITextFieldDelegate
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let txtField = textField as? NextPrevControlTextField {
            txtField.transferFirstResponderToNextControl(completionHandler: { (didTransfer) in
                if (!didTransfer) {
                    print("Submit programmatically")
                }
            })
        }
        
        return false
    }

    // MARK: - UIResponder
    
    // Hides keyboard when user taps anywhere outside of keyboard
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    

    // MARK: - Private methods
    
    private func customizeButton() {
        let verticalInset: CGFloat = 10.0
        self.fbButton.imageEdgeInsets = UIEdgeInsets(top: verticalInset, left: verticalInset, bottom: verticalInset, right: 0)
    }
    
    private func getUser() {
        AuthenticationManager.shared.getOAuthToken { (token, error) in
            guard token != nil else {
                ErrorHelper.describe(error!)
                return
            }
            
            APIClient.getUser { (user, error) in
                guard let usr = user else {
                    ErrorHelper.describe(error!)
                    return
                }
                
                print(usr)
                // TODO: save user to singleton
            }
        }
    }
    
    @objc private func userDidSignInWithGoogle() {
        self.dismiss(animated: true, completion: nil)
    }

}
