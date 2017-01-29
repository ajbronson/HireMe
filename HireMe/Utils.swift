//
//  Utils.swift
//  HireMe
//
//  Created by Nathan Johnson on 1/28/17.
//  Copyright © 2017 AJ Bronson. All rights reserved.
//

import Foundation

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
