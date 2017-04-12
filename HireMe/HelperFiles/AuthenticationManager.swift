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

final class AuthenticationManager {
    
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
    
    // MARK: - Static methods
    
    static func authAlertHasDisplayed() -> Bool {
        return UserDefaults.standard.bool(forKey: AUTH_ALERT_KEY)
    }
    
    static func resetAuthAlertUserDefaultsKey() {
        UserDefaults.standard.removeObject(forKey: AUTH_ALERT_KEY)
    }
    
    // MARK: - Methods
    
    /**
     Provides a valid access token.
     
     - Note: Requires a completion handler in case the access token is expired and a request needs to be made in order to refresh it.
     
     - Parameter completionHandler: An OAuthToken and an Error will never be returned simultaneously. Either one will be returned or the other.
     */
    func token(completionHandler: @escaping OAuthTokenHandler) {
        refreshTokenIfExpired { (token, error) in
            guard let err = error else {
                completionHandler(token, nil)
                return
            }
            
            guard let authError = err as? AuthenticationError, authError == .noAccessToken else {
                completionHandler(nil, err)
                return
            }
            
            guard let tokenDict = UserDefaults.standard.object(forKey: self.OAUTH_TOKEN_KEY) as? [String: Any] else {
                completionHandler(nil, AuthenticationError.oAuthTokenInitialization)
                return
            }
            
            do {
                self.oAuthToken = try OAuthToken(dictionary: tokenDict)
            } catch let initError {
                completionHandler(nil, initError)
            }
            
            self.refreshTokenIfExpired { (token2, error2) in
                if let err2 = error2 {
                    completionHandler(nil, err2)
                } else {
                    completionHandler(token2, nil)
                }
            }
        }
    }
    
    /**
     Makes a request to get a valid access token
     
     - Parameter completionHandler: An OAuthToken and an Error will never be returned simultaneously. Either one will be returned or the other.
     */
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
        
        let data = try? JSONSerialization.data(withJSONObject: httpBody)
        
        let url = NetworkConroller.url(base: AUTH_BASE_URL, pathParameters: ["convert-token"])
        
        NetworkConroller.request(url, method: .Post, addAuthorizationHeader: false, body: data) { (request, error) in
            guard var urlRequest = request else {
                completionHandler(nil, error)
                return
            }
            
            let bearerToken = "Bearer \(signIn.rawValue) \(token)"
            urlRequest.addValue(bearerToken, forHTTPHeaderField: "Authorization")
            
            self.performTokenURLRequest(&urlRequest) { (token, error) in
                completionHandler(token, error)
            }
        }
    }
    
    /**
     Makes a request to get a new access token using a valid refresh token.
     
     - Parameter completionHandler: An OAuthToken and an Error will never be returned simultaneously. Either one will be returned or the other; i.e., at least one will always be nil.
     */
    func refreshToken(completionHandler: @escaping OAuthTokenHandler) {
        guard let token = oAuthToken else {
            completionHandler(nil, AuthenticationError.noAccessToken)
            return
        }
        
        var httpBody = NetworkConroller.httpBody(withGrantType: REFRESH_TOKEN)
        httpBody[REFRESH_TOKEN] = token.refreshToken
        let data = try? JSONSerialization.data(withJSONObject: httpBody)
        
        let url = NetworkConroller.url(base: AUTH_BASE_URL, pathParameters: ["token"])
        
        NetworkConroller.request(url, method: .Post, addAuthorizationHeader: false, body: data) { (request, error) in
            guard var urlRequest = request else {
                completionHandler(nil, error)
                return
            }
            
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
    
    /**
     Provides a valid access token. Refreshes an expired token if necessary.
     
     - Note: Requires a completion handler in case the access token is expired and a request needs to be made in order to refresh it.
     
     - Parameter completionHandler: An OAuthToken and an Error will never be returned simultaneously. Either one will be returned or the other.
     */
    private func refreshTokenIfExpired(completionHandler: @escaping OAuthTokenHandler) {
        if let token = oAuthToken {
            if token.isExpired {
                refreshToken { (token2, error) in
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
            completionHandler(nil, AuthenticationError.noAccessToken)
        }
    }
    
    /**
     Makes the request with a header specifying the content type as JSON to get an access token
     
     - Parameter request: The URL request to perform.
     - Parameter completionHandler: An OAuthToken and an Error will never be returned simultaneously. Either one will be returned or the other.
     */
    private func performTokenURLRequest(_ request: inout URLRequest, completionHandler: @escaping OAuthTokenHandler) {
        request.addContentTypeHeader(mimeType: .JSON)

        NetworkConroller.performURLRequest(request) { (data, error) in
            if let err = error {
                completionHandler(nil, err)
            } else {
                guard let json = data?.toJSON(), let jsonDict = json as? [String: Any] else {
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
