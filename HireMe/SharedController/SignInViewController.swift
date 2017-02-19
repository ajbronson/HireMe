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

class SignInViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var emailTextField: NextControlTextField!
    @IBOutlet weak var passwordTextField: NextControlTextField!
    @IBOutlet weak var fbButton: UIButton!

    // MARK: - View controller life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.emailTextField.bottomBorder()
        self.passwordTextField.bottomBorder()
        self.customizeButton()
    }
    
    // TODO: This probably won't be needed once it can actually sign in. When users sign out, they won't be directed to this screen
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.emailTextField.text = nil
        self.passwordTextField.text = nil
    }
    
    
    // MARK: - IBActions
    
    @IBAction func signInTapped(_ sender: UIButton) {
        print("Signed in with LimitedHire")
        self.performSegue(withIdentifier: "showTabsFromSignIn", sender: nil)
    }

    @IBAction func changePasswordTapped(_ sender: UIButton) {
        print("Change password")
    }
    
    @IBAction func createAccountTapped(_ sender: UIButton) {
        print("Create an account")
    }
    
    @IBAction func cancelTapped(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }

    @IBAction func facebookTapped(_ sender: UIButton) {
        FBSDKLoginManager().logIn(withReadPermissions: ["public_profile", "email"], from: self) { (loginResult, error) in
            if let err = error {
                print(err)
            } else {
                print("Signed in with Facebook")
                guard let result = loginResult else {
                    return
                }
                
                if result.grantedPermissions != nil {
                    FBSDKGraphRequest(graphPath: "me", parameters: ["fields": "name, picture.type(large), email"]).start { (connection, result, error) in
                        if error == nil {
                            UserDefaults.standard.set(result, forKey: "fbUserProfile")
//                            self.dismiss(animated: true, completion: nil)
                            self.performSegue(withIdentifier: "showTabsFromSignIn", sender: nil)
                        }
                    }
                }
            }
        }
    }
    
    @IBAction func googleTapped(_ sender: UIButton) {
        print("Google")
        GIDSignIn.sharedInstance().signIn()
    }
    
    // MARK: - UITextFieldDelegate
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let txtField = textField as? NextControlTextField {
            txtField.transferFirstResponderToNextControl(completionHandler: { (didTransfer) in
                if (!didTransfer) {
                    print("Submit programmatically")
                }
            })
        }
        
        return false
    }
    
    
    // Hides keyboard when user taps anywhere outside of keyboard
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    

    // MARK: - Custom functions
    
    func customizeButton() {
        let inset: CGFloat = 15
        let verticalInset: CGFloat = 10.0
        self.fbButton.imageEdgeInsets = UIEdgeInsets(top: verticalInset, left: verticalInset, bottom: verticalInset, right: 0)
    }

}
