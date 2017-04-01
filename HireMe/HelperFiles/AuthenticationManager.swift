//
//  AuthenticationManager.swift
//  HireMe
//
//  Created by Nathan Johnson on 4/1/17.
//  Copyright © 2017 AJ Bronson. All rights reserved.
//

import Foundation

class AuthenticationManager {
    static let shared = AuthenticationManager()
    
    var oAuthToken: OAuthToken?
    var isSignedIn: Bool {
        return oAuthToken?.accessToken != nil
    }
    
    private init() {}
    
    func getOAuthToken(completionHandler: @escaping (_ token: OAuthToken?, _ error: Error?) -> Void) {
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

}
