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
    static let shared = AuthenticationManager()
    
    // MARK: - Constants
    
    private let AUTH_BASE_URL = "\(BASE_URL)/auth"
    private let OAUTH_TOKEN_KEY = "LH_OAuthToken"
    private let CONVERT_TOKEN = "convert_token"
    private let REFRESH_TOKEN = "refresh_token"
    
    // MARK: - Properties
    
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
    
    // MARK: - Object life cycle
    
    private init() {}
    
    // MARK: - Functions
    
    func getOAuthToken() {
        let backTok = backendToken()
        
        var httpBody = NetworkConroller.httpBody(withGrantType: CONVERT_TOKEN)
        httpBody["backend"] = ""
        httpBody["token"] = ""
//        print(json) // DEBUG
        let data = try? JSONSerialization.data(withJSONObject: httpBody, options: .prettyPrinted)
        let url = NetworkConroller.url(withBase: AUTH_BASE_URL, pathParameters: [CONVERT_TOKEN])
        performTokenURLRequest(url, body: data)
    }
    
    func refreshToken() {
        guard let token = oAuthToken else {
            // TODO: handle error
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
        
        if FBSDKAccessToken.current() != nil { // Logged in with Facebook
            FBSDKLoginManager().logOut()
        } else if GIDSignIn.sharedInstance().currentUser != nil { // Logged in with Google
            GIDSignIn.sharedInstance().signOut()
        }
        
        NotificationCenter.default.post(name: signOutNotificationName, object: nil)
    }
    
    // MARK: - Private functions
    
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

}
