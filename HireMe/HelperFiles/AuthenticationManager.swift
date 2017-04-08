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

typealias OAuthTokenHandler = (OAuthToken?, Error?) -> Void

class AuthenticationManager {
    
    // MARK: - Type properties
    
    static let shared = AuthenticationManager()
    
    // MARK: - Constants
    
    private let AUTH_BASE_URL = "\(BASE_URL)/auth"
    private let OAUTH_TOKEN_KEY = "LH_OAuthToken"
    private let CONVERT_TOKEN = "convert_token"
    private let REFRESH_TOKEN = "refresh_token"
    
    private var oAuthToken: OAuthToken? {
        didSet {
            UserDefaults.standard.set(oAuthToken?.toJSON(), forKey: OAUTH_TOKEN_KEY)
        }
    }
    
    // MARK: - Computed properties
    
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
    
    func token(completionHandler: @escaping OAuthTokenHandler) {
        refreshTokenIfExpired { (token, error) in
            guard let err = error else {
                completionHandler(token, nil)
                return
            }
            
            guard let limitedHireError = err as? LimitedHireError,
                limitedHireError == .noOAuthToken else {
                completionHandler(nil, err)
                return
            }
            
            guard let json = UserDefaults.standard.object(forKey: self.OAUTH_TOKEN_KEY) as? [String: Any] else {
                completionHandler(nil, LimitedHireError.oAuthTokenInitialization)
                return
            }
            
            self.oAuthToken = OAuthToken(json: json)
            self.refreshTokenIfExpired { (token2, error2) in
                if let err2 = error2 {
                    completionHandler(nil, err2)
                } else {
                    completionHandler(token2, nil)
                }
            }
        }
    }
    
    /// Makes a request to get a valid OAuth token
    func getOAuthToken(completionHandler: @escaping OAuthTokenHandler) {
        var token: String
        let signIn = signInMethod()
        
        switch signIn {
        case .facebook: token = FBSDKAccessToken.current().tokenString
        case .google: token = GIDSignIn.sharedInstance().currentUser.authentication.accessToken
        case .limitedHire:
            completionHandler(nil, LimitedHireError.oAuthTokenAlreadyObtained)
            return
        case .notSignedIn:
            completionHandler(nil, nil)
            return
        }
        
        var httpBody = NetworkConroller.httpBody(withGrantType: CONVERT_TOKEN)
        httpBody["backend"] = signIn.rawValue
        httpBody["token"] = token
        
        print(httpBody) // DEBUG
        let data = try? JSONSerialization.data(withJSONObject: httpBody)
        
        let url = NetworkConroller.url(base: AUTH_BASE_URL, pathParameters: ["convert-token"])
        
        NetworkConroller.request(url, method: .Post, addAuthorizationHeader: false, body: data) { (request, error) in
            // TODO: use guard instead
            if let err = error {
                completionHandler(nil, err)
            } else {
                let bearerToken = "Bearer \(signIn.rawValue) \(token)"
                var urlRequest = request
                urlRequest?.addValue(bearerToken, forHTTPHeaderField: "Authorization")
                
                self.performTokenURLRequest(&urlRequest) { (token, error) in
                    completionHandler(token, error)
                }
            }
        }
    }
    
    func refreshToken(completionHandler: @escaping OAuthTokenHandler) {
        guard let token = oAuthToken else {
            completionHandler(nil, LimitedHireError.noOAuthToken)
            return
        }
        print("refreshing token...") // DEBUG
        var httpBody = NetworkConroller.httpBody(withGrantType: REFRESH_TOKEN)
        httpBody[REFRESH_TOKEN] = token.refreshToken
        let data = try? JSONSerialization.data(withJSONObject: httpBody)
        
        let url = NetworkConroller.url(base: AUTH_BASE_URL, pathParameters: ["token"])
        
        NetworkConroller.request(url, method: .Post, body: data) { (request, error) in
            print("refreshToken: sucessfully initialized request")
            var urlRequest = request
            
            self.performTokenURLRequest(&urlRequest) { (token, error) in
                completionHandler(token, error)
            }
        }
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
    
    private func refreshTokenIfExpired(completionHandler: @escaping OAuthTokenHandler) {
        if let token = oAuthToken {
            print("refreshTokenIfExpired: \(token)")
            if token.isExpired {
                print("token is expired")
                refreshToken { (token2, error) in
                    print("refreshTokenIfExpired-refreshToken: \(token2)")
                    if let err = error {
                        completionHandler(nil, err)
                    } else {
                        completionHandler(token2, nil)
                    }
                }
            } else {
                completionHandler(token, nil)
            }
        } else {
            print("no token")
            completionHandler(nil, LimitedHireError.noOAuthToken)
        }
    }
    
    /// Makes the request with a header specifying the content type as JSON to get an access token
    private func performTokenURLRequest(_ request: inout URLRequest?, completionHandler: @escaping OAuthTokenHandler) {
        guard var urlRequest = request else {
            completionHandler(nil, LimitedHireError.noURLRequest)
            return
        }
        
        urlRequest.addContentTypeHeader(mimeType: .JSON)

        NetworkConroller.performURLRequest(urlRequest) { (data, error) in
            if let err = error {
                completionHandler(nil, err)
            } else {
                guard let json = data?.toJSON(),
                    let jsonDict = json as? [String: Any] else {
                        completionHandler(nil, LimitedHireError.deserializeJSON)
                        return
                }
                print(jsonDict) // DEBUG
                self.oAuthToken = OAuthToken(json: jsonDict)
                print("performTokenURLRequest: \(String(describing: self.oAuthToken))") // DEBUG
                completionHandler(self.oAuthToken, nil)
            }
        }
    }

    private func signInMethod() -> SignInMethod {
        if FBSDKAccessToken.current() != nil {
            return SignInMethod.facebook
        } else if GIDSignIn.sharedInstance().currentUser != nil {
            return SignInMethod.google
        } else if oAuthToken != nil {
            return SignInMethod.limitedHire
        } else {
            return SignInMethod.notSignedIn
        }
    }
}
