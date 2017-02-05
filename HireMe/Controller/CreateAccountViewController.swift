//
//  CreateAccountViewController.swift
//  HireMe
//
//  Created by Nathan Johnson on 1/17/17.
//  Copyright © 2017 AJ Bronson. All rights reserved.
//

import UIKit

class CreateAccountViewController: UITableViewController, UITextFieldDelegate {
    
    // MARK: - View controller life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    // MARK: - UITableViewDelegate
    
    override func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        let alert = UIAlertController(title: "Why is my ZIP code needed?", message: "We use your ZIP code to match you with providers near you.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Got it", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    
    // MARK: - UITextFieldDelegate
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let txtField = textField as? NextControlTextField {
            txtField.transferFirstResponderToNextControl(completionHandler: { (didTransfer) in
                if !didTransfer {
                    // User finished verifying password, go to next screen
                    print("Next")
                }
            })
        }
        
        return false // Do not add a line break
    }
    
    // MARK: - IBActions
    
    @IBAction func cancelTapped(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
}
