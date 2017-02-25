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
    @IBOutlet weak var emailTextField: NextControlTextField!
    @IBOutlet weak var passwordTextField: NextControlTextField!
    @IBOutlet weak var fbButton: UIButton!
    
    
    // MARK: - Properties
    
    var didSegueFromSettings = false

    // MARK: - View controller life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(userDidSignInWithGoogle), name: NSNotification.Name(rawValue: notificationKey), object: nil)
        
        GIDSignIn.sharedInstance().uiDelegate = self
        
        if self.didSegueFromSettings {
            self.navigationItem.leftBarButtonItem = nil // Remove cancel button
        }
        
        self.emailTextField.bottomBorder()
        self.passwordTextField.bottomBorder()
//        self.customizeButton()
    }
    
    // TODO: This probably won't be needed once it can actually sign in. When users sign out, they won't be directed to this screen
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.emailTextField.text = nil
        self.passwordTextField.text = nil
        
        print("SignInViewController's parent \(self.parent?.descr)") // DEBUG
        print("SignInViewController's parent's parent \(self.parent?.parent?.descr)") // DEBUG
        print("presentingViewController \(self.presentingViewController?.descr)") // DEBUG
    }
    
    
    // MARK: - IBActions
    
    @IBAction func signInTapped(_ sender: UIButton) {
        print("Signed in with LimitedHire")
        
        if self.didSegueFromSettings {
            self.dismiss(animated: true, completion: nil)
            // TODO: sign in natively
        } else {
            self.performSegue(withIdentifier: "showTabsFromSignIn", sender: nil)
        }
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
                print("Signed in with Facebook")
                guard let result = loginResult else {
                    return
                }
                
                if result.grantedPermissions != nil {
                    FBSDKGraphRequest(graphPath: "me", parameters: ["fields": "name, picture.type(large), email"]).start { (connection, result, error) in
                        if error == nil {
                            UserDefaults.standard.set(result, forKey: "fbUserProfile")
                            
                            if self.didSegueFromSettings {
                                self.dismiss(animated: false, completion: nil)
                            } else {
                                self.performSegue(withIdentifier: "showTabsFromSignIn", sender: nil)
                            }
                        } else {
                            print("\(error?.localizedDescription)")
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
        if let txtField = textField as? NextControlTextField {
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
    
    func customizeButton() {
//        let inset: CGFloat = 15
        let verticalInset: CGFloat = 10.0
        self.fbButton.imageEdgeInsets = UIEdgeInsets(top: verticalInset, left: verticalInset, bottom: verticalInset, right: 0)
    }
    
    func userDidSignInWithGoogle() {
        if self.didSegueFromSettings {
            self.dismiss(animated: true, completion: nil)
        }
    }

}
