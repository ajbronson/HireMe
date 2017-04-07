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
                print(err)
            } else {
                print("Facebook token: \(FBSDKAccessToken.current().tokenString)")
                AuthenticationManager.shared.getOAuthToken { (token, error) in
                    if let err = error {
                        ErrorHelper.describe(err)
                    }
                    
                    print(token?.description)
                }
                
                guard let result = loginResult else {
                    return
                }
                
                if result.grantedPermissions != nil {
                    // https://developers.facebook.com/docs/graph-api/reference/user for a list of available fields
                    FBSDKGraphRequest(graphPath: "me", parameters: ["fields": "name, first_name, last_name, email, cover"]).start { (connection, result, error) in
                        if error == nil {
                            guard let profile = result as? [String: Any] else {
                                return
                            }
                            
                            var coverPhotoSource: String?
                            
                            if let cover = profile["cover"] as? [String: Any] {
                                coverPhotoSource = cover["source"] as? String
                            }
                            
//                            SignInHelper.setUserProfile(fullName: profile["name"] as? String,
//                                                        firstName: profile["first_name"] as? String,
//                                                        lastName: profile["last_name"] as? String,
//                                                        email: profile["email"] as? String,
//                                                        imageURL: coverPhotoSource)
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
    

    // MARK: - Custom functions
    
    private func customizeButton() {
        let verticalInset: CGFloat = 10.0
        self.fbButton.imageEdgeInsets = UIEdgeInsets(top: verticalInset, left: verticalInset, bottom: verticalInset, right: 0)
    }
    
    func userDidSignInWithGoogle() {
        self.dismiss(animated: true, completion: nil)
    }

}
