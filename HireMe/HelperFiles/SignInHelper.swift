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
    
    static func setUserProfile(fullName: String?, firstName: String?, lastName: String?, email: String?, imageURL: String?) {
        let userProfile = [
            "fullName": fullName,
            "firstName": firstName,
            "lastName": lastName,
            "email": email,
            "imageURL": imageURL
        ]
        
        UserDefaults.standard.set(userProfile, forKey: self.USER_PROFILE_KEY)
    }
    
    static func userProfile() -> [String: String?]? {
        return UserDefaults.standard.dictionary(forKey: self.USER_PROFILE_KEY) as? [String: String?]
    }
    
    static func getOAuthToken(completionHandler: @escaping (_ token: OAuthToken?, _ error: Error?) -> Void) {
        let backTok = backendToken()
        let json = [
            "grant_type": "convert_token",
            "client_id": CLIENT_ID,
            "client_secret": CLIENT_SECRET,
            "backend": backTok.backend,
            "token": backTok.token
        ]
        
        print(json) // DEBUG
        
        let data = try? JSONSerialization.data(withJSONObject: json, options: .prettyPrinted)
        let url = NetworkConroller.url(withBase: BASE_URL, pathParameters: ["auth", "convert-token"])
        var request = NetworkConroller.request(url, method: .Post, body: data)
        request.addContentTypeHeader(mimeType: .JSON)
        
        NetworkConroller.performURLRequest(request) { (data, error) in
            if let err = error {
                completionHandler(nil, err)
            } else {
                guard let responseData = data else {
                    // TODO: create a custom error to pass
                    completionHandler(nil, nil)
                    return
                }
                
                guard let json = try? JSONSerialization.jsonObject(with: responseData, options: []),
                    let jsonDict = json as? [String: Any] else {
                    // TODO: create a custom error to pass; e.g., InvalidJSON or JSONSerializationFailure
                    completionHandler(nil, nil)
                    return
                }
                
                print(jsonDict)
                
                completionHandler(OAuthToken(json: jsonDict), nil)
            }
        }
    }
    
    static func bearerToken() -> String {
        let backTok = backendToken()
        var bearer = "Bearer " + backTok.backend
        
        if backTok.backend.characters.count > 0 {
            bearer += " "
        }
        
        return "\(bearer)\(backTok.token)"
    }
}

func backendToken() -> (backend: String, token: String) {
    switch SignInHelper.getSignInMethod() {
    case .Facebook: return ("facebook", FBSDKAccessToken.current().tokenString)
    case .Google: return ("google", GIDSignIn.sharedInstance().currentUser.authentication.idToken)
    case .ThisApp:
        //If signing in natively, the value of backend will not change
        // TODO: get user's access token
        return ("", "")
    case .NotSignedIn: fatalError("Error: Attempting to get a token when user is not signed in")
    }
}
