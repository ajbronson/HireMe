//
//  NextControlTextField.swift
//  HireMe
//
//  Created by Nathan Johnson on 2/4/17.
//  Copyright © 2017 AJ Bronson. All rights reserved.
//

import UIKit

/**
 Contains functionality to have its next `UIControl` become the first responder.
 
 Example: When the user taps the keyboard's return key, the next control ( `UITextField` ) will become active.
 */
class NextControlTextField: UITextField {
    @IBOutlet weak var nextControl: UIControl?
    @IBOutlet weak var prevControl: UIControl?
    
    /**
     The next `UIControl` becomes the first responder.
     
     - Parameter completionHandler: Closure with a `Bool` parameter of `true` if the next `UIControl` became the first responder
     */
    func transferFirstResponderToNextControl(completionHandler: ((Bool) -> Void)?) {
        if let next = self.nextControl {
            next.becomeFirstResponder() // Activate next control
            completionHandler?(true)
        } else {
            self.resignFirstResponder() // Hide keyboard
            completionHandler?(false)
        }
    }
    
    /**
     The previous `UIControl` becomes the first responder.
     
     - Parameter completionHandler: Closure with a `Bool` parameter of `true` if the previous `UIControl` became the first responder
     */
    func transferFirstResponderToPrevControl(completionHandler: ((Bool) -> Void)?) {
        if let prev = self.prevControl {
            prev.becomeFirstResponder() // Activate next control
            completionHandler?(true)
        } else {
            self.resignFirstResponder() // Hide keyboard
            completionHandler?(false)
        }
    }

}
