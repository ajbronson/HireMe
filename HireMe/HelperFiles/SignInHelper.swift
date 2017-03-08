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

enum SignInMethod: String {
    case NotSignedIn
    case Facebook
    case Google
    case ThisApp
}

class SignInHelper {
    static func authAlertHasDisplayed() -> Bool {
        return UserDefaults.standard.bool(forKey: AUTH_ALERT_KEY)
    }
    
    // TODO: check if signed in with LimitedHire
    static func getSignInMethod() -> SignInMethod {
        if FBSDKAccessToken.current() != nil {
            return SignInMethod.Facebook
        } else if GIDSignIn.sharedInstance().currentUser != nil {
            return SignInMethod.Google
        } else {
            return SignInMethod.NotSignedIn
        }
    }
    
    static func isSignedIn() -> Bool {
        return !(self.getSignInMethod() == .NotSignedIn)
    }
}
