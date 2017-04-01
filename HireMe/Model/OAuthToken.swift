//
//  OAuthToken.swift
//  HireMe
//
//  Created by Nathan Johnson on 3/31/17.
//  Copyright © 2017 AJ Bronson. All rights reserved.
//

import UIKit

class OAuthToken {
    var accessToken: String
    var refreshToken: String
    var scope: String
    var tokenType: String
    var expiresIn: Int
    
    init?(json: [String: Any]) {
        guard let accessToken = json["access_token"] as? String,
            let refreshToken = json["refresh_token"] as? String,
            let scope = json["scope"] as? String,
            let tokenType = json["token_type"] as? String,
            let expiresIn = json["expires_in"] as? Int else {
            return nil
        }
        
        self.accessToken = accessToken
        self.refreshToken = refreshToken
        self.scope = scope
        self.tokenType = tokenType
        self.expiresIn = expiresIn
    }
    
    func authorization() -> String {
        return "\(tokenType) \(accessToken)"
    }
}
