//
//  LoginViewController.swift
//  HireMe
//
//  Created by Nathan Johnson on 1/17/17.
//  Copyright © 2017 AJ Bronson. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    // MARK: - View controller life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    //This will dismiss the keyboard and resign any UITextField as first responder when the user taps outside of the text fields
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
        super.touchesBegan(touches, with: event)
    }
    
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "showTabs") {
            print("preparing...")
        }
    }
    
    
    // MARK: - IBActions
    
    @IBAction func loginTapped(_ sender: UIButton) {
        print("login")
    }
    
    @IBAction func signUpTapped(_ sender: UIButton) {
        print("sign up")
    }
}
