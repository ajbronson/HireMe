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

class SignInHelper {
    private static let USER_PROFILE_KEY = "LH_UserProfile"
    
    enum SignInMethod: String {
        case NotSignedIn
        case Facebook
        case Google
        case ThisApp
    }
    
    static func authAlertHasDisplayed() -> Bool {
        return UserDefaults.standard.bool(forKey: AUTH_ALERT_KEY)
    }
    
    static func resetAuthAlertUserDefaultsKey() {
        UserDefaults.standard.removeObject(forKey: AUTH_ALERT_KEY)
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
    
    static func setUserProfile(fullName: String?, firstName: String?, lastName: String?, email: String?) {
        let userProfile = [
            "fullName": fullName,
            "firstName": firstName,
            "lastName": lastName,
            "email": email
        ]
        
        UserDefaults.standard.set(userProfile, forKey: self.USER_PROFILE_KEY)
    }
    
    static func userProfile() -> [String: String?]? {
        return UserDefaults.standard.dictionary(forKey: self.USER_PROFILE_KEY) as? [String: String?]
    }
}
