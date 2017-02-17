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

    // MARK: - View controller life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.emailTextField.bottomBorder()
        self.passwordTextField.bottomBorder()
    }
    
    
    // MARK: - IBActions
    
    @IBAction func signInTapped(_ sender: UIButton) {
        print("Signed in with LimitedHire")
        self.performSegue(withIdentifier: "showTabsFromSignIn", sender: nil)
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
