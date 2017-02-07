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

func getSignInMethod() -> SignInMethod {
    if FBSDKAccessToken.current() != nil {
        return SignInMethod.Facebook
    } else if GIDSignIn.sharedInstance().currentUser != nil {
        return SignInMethod.Google
    } else {
        return SignInMethod.NotSignedIn
    }
}
