//
//  Utils.swift
//  HireMe
//
//  Created by Nathan Johnson on 1/28/17.
//  Copyright © 2017 AJ Bronson. All rights reserved.
//

import Foundation
import GoogleSignIn
import FBSDKLoginKit

let SIGN_IN_METHOD_KEY = "signInMethod"

enum SignInMethod: String {
    case NotSignedIn
    case Facebook
    case Google
    case ThisApp
}

func setSignInMethod(as method: SignInMethod) {
    UserDefaults.standard.set(method.rawValue, forKey: SIGN_IN_METHOD_KEY)
}

func getSignInMethod() -> SignInMethod {
    guard let signInMethodRaw = UserDefaults.standard.object(forKey: SIGN_IN_METHOD_KEY) as? String, let signInMethod = SignInMethod(rawValue: signInMethodRaw) else {
        UserDefaults.standard.set(SignInMethod.NotSignedIn.rawValue, forKey: SIGN_IN_METHOD_KEY)
        
        return getSignInMethod()
    }
    
    return signInMethod
}

func getSignInMethod2() -> SignInMethod {
    if FBSDKAccessToken.current() != nil {
        return SignInMethod.Facebook
    } else if GIDSignIn.sharedInstance().currentUser != nil {
        return SignInMethod.Google
    } else {
        return SignInMethod.NotSignedIn
    }
}

func setRootViewController(with identifier: String) {
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    guard let window = appDelegate.window else {
        print("Error getting window")
        return
    }
    
    UIView.transition(with: window, duration: 0.65, options: .transitionFlipFromLeft, animations: {
        window.rootViewController = appDelegate.storyboard.instantiateViewController(withIdentifier: identifier)
    }, completion: nil)
}

extension UIViewController {
    var className: String {
        return NSStringFromClass(self.classForCoder).components(separatedBy: ".").last!
    }
    
    var descr: String {
        return "class: \(self.className), ID: \(self.restorationIdentifier)"
    }
}

extension UINavigationController {
    func printViewControllers() {
        var i = 0
        
        for vc in self.viewControllers {
            print("viewControllers[\(i)] \(vc.descr)")
            i += 1
        }
    }
}

//This will dismiss the keyboard and resign any UITextField as first responder when the user taps outside of the text fields
//override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//    self.view.endEditing(true)
//    super.touchesBegan(touches, with: event)
//}
