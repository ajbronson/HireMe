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
//            print("didSet oAuthToken") // DEBUG
            UserDefaults.standard.set(oAuthToken?.toDictionary(), forKey: OAUTH_TOKEN_KEY)
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
//        print("token(completionHandler:)") // DEBUG
        refreshTokenIfExpired { (token, error) in
//            print("token-refreshTokenIfExpired") // DEBUG
            guard let err = error else {
//                print("token-refreshTokenIfExpired: \(String(describing: token))") // DEBUG
                completionHandler(token, nil)
                return
            }
            
            guard let authError = err as? AuthenticationError,
                authError == .noAccessToken else {
//                print("token-refreshTokenIfExpired: error") // DEBUG
                completionHandler(nil, err)
                return
            }
            
            guard let json = UserDefaults.standard.object(forKey: self.OAUTH_TOKEN_KEY) as? [String: Any] else {
//                print("token-refreshTokenIfExpired: failed to get token from user defaults") // DEBUG
                completionHandler(nil, AuthenticationError.oAuthTokenInitialization)
                return
            }
            
            self.oAuthToken = try? OAuthToken(dictionary: json)
            self.refreshTokenIfExpired { (token2, error2) in
//                print("token-refreshTokenIfExpired-refreshTokenIfExpired") // DEBUG
                if let err2 = error2 {
//                    print("token-refreshTokenIfExpired-refreshTokenIfExpired: error") // DEBUG
                    completionHandler(nil, err2)
                } else {
//                    print("token-refreshTokenIfExpired-refreshTokenIfExpired: \(String(describing: token2))") // DEBUG
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
            completionHandler(nil, AuthenticationError.accessTokenAlreadyIssued)
            return
        case .notSignedIn:
            completionHandler(nil, AuthenticationError.notAuthenticated)
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
//        print("refreshToken(completionHandler:)") // DEBUG
        guard let token = oAuthToken else {
//            print("refreshToken: no token") // DEBUG
            completionHandler(nil, AuthenticationError.noAccessToken)
            return
        }
        
        var httpBody = NetworkConroller.httpBody(withGrantType: REFRESH_TOKEN)
        httpBody[REFRESH_TOKEN] = token.refreshToken
        let data = try? JSONSerialization.data(withJSONObject: httpBody)
        
        let url = NetworkConroller.url(base: AUTH_BASE_URL, pathParameters: ["token"])
        
        NetworkConroller.request(url, method: .Post, addAuthorizationHeader: false, body: data) { (request, error) in
//            print("refreshToken: sucessfully initialized request") // DEBUG
            var urlRequest = request
            
            self.performTokenURLRequest(&urlRequest) { (token, error) in
//                print("refreshToken-request-performTokenURLRequest") // DEBUG
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
//        print("refreshTokenIfExpired") // DEBUG
        if let token = oAuthToken {
//            print("refreshTokenIfExpired: \(token)") // DEBUG
            if token.isExpired {
//                print("token is expired") // DEBUG
                refreshToken { (token2, error) in
//                    print("refreshTokenIfExpired-refreshToken") // DEBUG
                    if let err = error {
//                        print("refreshTokenIfExpired-refreshToken: error") // DEBUG
                        completionHandler(nil, err)
                    } else {
//                        print("refreshTokenIfExpired-refreshToken: \(String(describing: token2))") // DEBUG
                        completionHandler(token2, nil)
                    }
                }
            } else {
//                print("token is not expired") // DEBUG
                completionHandler(token, nil)
            }
        } else {
//            print("refreshTokenIfExpired: no token") // DEBUG
            completionHandler(nil, AuthenticationError.noAccessToken)
        }
    }
    
    /// Makes the request with a header specifying the content type as JSON to get an access token
    private func performTokenURLRequest(_ request: inout URLRequest?, completionHandler: @escaping OAuthTokenHandler) {
        guard var urlRequest = request else {
            completionHandler(nil, NetworkError.noURLRequest)
            return
        }
        
        urlRequest.addContentTypeHeader(mimeType: .JSON)

        NetworkConroller.performURLRequest(urlRequest) { (data, error) in
            if let err = error {
                completionHandler(nil, err)
            } else {
                guard let json = data?.toJSON(),
                    let jsonDict = json as? [String: Any] else {
                        completionHandler(nil, NetworkError.deserializeJSON)
                        return
                }
                
                do {
                    self.oAuthToken = try OAuthToken(dictionary: jsonDict)
                    completionHandler(self.oAuthToken, nil)
                } catch let initError {
                    completionHandler(nil, initError)
                }
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
