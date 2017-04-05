//
//  AuthenticationManager.swift
//  HireMe
//
//  Created by Nathan Johnson on 4/1/17.
//  Copyright © 2017 AJ Bronson. All rights reserved.
//

import Foundation
import GoogleSignIn
import FBSDKLoginKit

class AuthenticationManager {
    
    // MARK: - Type properties
    
    static let shared = AuthenticationManager()
    
    // MARK: - Constants
    
    private let AUTH_BASE_URL = "\(BASE_URL)/auth"
    private let OAUTH_TOKEN_KEY = "LH_OAuthToken"
    private let CONVERT_TOKEN = "convert_token"
    private let REFRESH_TOKEN = "refresh_token"
    
    // MARK: - Computed properties
    
    var oAuthToken: OAuthToken? {
        get {
            if let token = self.oAuthToken {
                return token
            } else if let json = UserDefaults.standard.object(forKey: OAUTH_TOKEN_KEY) as? [String: Any] {
                return OAuthToken(json: json)
            } else {
                return nil
            }
        }
        
        set {
            UserDefaults.standard.set(newValue?.toJSON(), forKey: OAUTH_TOKEN_KEY)
        }
    }
    
    var isSignedIn: Bool {
        return oAuthToken?.accessToken != nil
    }
    
    private enum SignInMethod: String {
        case facebook
        case google
        case limitedHire
        case notSignedIn
    }
    
    // MARK: - Object life cycle
    
    private init() {}
    
    // MARK: - Methods
    
    func getOAuthToken() {
        var token: String
        let signIn = signInMethod()
        
        switch signIn {
        case .facebook: token = FBSDKAccessToken.current().tokenString
        case .google: token = GIDSignIn.sharedInstance().currentUser.authentication.accessToken
        case .limitedHire:
            print("Error: Attempting to get an OAuth token when a token has already been given")
            return
        case .notSignedIn:
            print("Error: Attempting to get an OAuth token when not signed in")
            return
        }
        
        var httpBody = NetworkConroller.httpBody(withGrantType: CONVERT_TOKEN)
        httpBody["backend"] = signIn.rawValue
        httpBody["token"] = token
        
        let data = try? JSONSerialization.data(withJSONObject: httpBody, options: .prettyPrinted)
        let url = NetworkConroller.url(withBase: AUTH_BASE_URL, pathParameters: [CONVERT_TOKEN])
        var request = NetworkConroller.request(url, method: .Post, body: data)
        
        let bearerToken = "Bearer \(signIn.rawValue) \(token)"
        request.addValue(bearerToken, forHTTPHeaderField: "Authorization")
        performTokenURLRequest(url, body: data)
    }
    
    func refreshToken() {
        guard let token = oAuthToken else {
            // TODO: handle error
            print("Error: Failed to refresh acces token, because an access token does not exist.")
            return
        }
        
        var httpBody = NetworkConroller.httpBody(withGrantType: REFRESH_TOKEN)
        httpBody[REFRESH_TOKEN] = token.refreshToken
        
        let data = try? JSONSerialization.data(withJSONObject: httpBody, options: .prettyPrinted)
        let url = NetworkConroller.url(withBase: AUTH_BASE_URL, pathParameters: [REFRESH_TOKEN])
        performTokenURLRequest(url, body: data)
    }
    
    func signOut() {
        oAuthToken = nil
        
        switch signInMethod() {
        case .facebook: FBSDKLoginManager().logOut()
        case .google: GIDSignIn.sharedInstance().signOut()
        default: break
        }
        
        NotificationCenter.default.post(name: signOutNotificationName, object: nil)
    }
    
    // MARK: - Private methods
    
    /**
     Makes a POST request with a header specifying the content type as JSON to get an access token
     
     - Parameter url: The request URL
     - Parameter body: The request HTTP body
     */
    private func performTokenURLRequest(_ url: URL, body: Data?) {
        var request = NetworkConroller.request(url, method: .Post, body: body)
        request.addContentTypeHeader(mimeType: .JSON)
        
        NetworkConroller.performURLRequest(request) { (data, error) in
            if let err = error {
                // TODO: handle error
                print(err.localizedDescription)
            } else {
                guard let responseData = data else {
                    // TODO: handle error
                    return
                }
                
                guard let json = try? JSONSerialization.jsonObject(with: responseData, options: []),
                    let jsonDict = json as? [String: Any] else {
                        // TODO: handle error
                        return
                }
//                print(jsonDict) // DEBUG
                self.oAuthToken = OAuthToken(json: jsonDict)
            }
        }
    }

    private func signInMethod() -> SignInMethod {
        if FBSDKAccessToken.current() != nil {
            return SignInMethod.facebook
        } else if GIDSignIn.sharedInstance().currentUser != nil {
            return SignInMethod.google
        } else if oAuthToken?.accessToken != nil {
            return SignInMethod.limitedHire
        } else {
            return SignInMethod.notSignedIn
        }
    }
}
