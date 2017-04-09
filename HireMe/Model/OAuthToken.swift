//
//  OAuthToken.swift
//  HireMe
//
//  Created by Nathan Johnson on 3/31/17.
//  Copyright © 2017 AJ Bronson. All rights reserved.
//

import UIKit

struct OAuthToken: CustomStringConvertible {
    var accessToken: String
    var refreshToken: String
    var scope: String
    var tokenType: String
    var creationDate: Date
    var expirationDate: Date
    var isExpired: Bool {
        // If ordered ascending, current date is earlier than expiration date
        return Date().compare(expirationDate) != .orderedAscending
    }
    
    init?(json: [String: Any]) {
        if let error = json["error"] as? String {
            print("Error: \(error)")
            return nil
        }
        
        guard let accessToken = json["access_token"] as? String,
            let refreshToken = json["refresh_token"] as? String,
            let scope = json["scope"] as? String,
            let tokenType = json["token_type"] as? String else {
            return nil
        }
        
        if let creationDate = json["creation_date"] as? Date,
            let expirationDate = json["expiration_date"] as? Date {
            self.creationDate = creationDate
            self.expirationDate = expirationDate
        } else if let expiresIn = json["expires_in"] as? Double {
            self.creationDate = Date()
            self.expirationDate = creationDate.addingTimeInterval(expiresIn)
        } else {
            return nil
        }
        
        self.accessToken = accessToken
        self.refreshToken = refreshToken
        self.scope = scope
        self.tokenType = tokenType
    }
    
    func authorization() -> String {
        return "\(tokenType) \(accessToken)"
    }
    
    func toDictionary() -> [String: Any] {
        return [
            "access_token": accessToken,
            "refresh_token": refreshToken,
            "scope": scope,
            "token_type": tokenType,
            "creation_date": creationDate,
            "expiration_date": expirationDate
        ]
    }
    
    // MARK: - CustomStringConvertible
    
    var description: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MMM-yyyy h:mm:ss a" // 02-Apr-2017 3:45:21 PM
        let expireTextSuffix = isExpired ? "d" : "s"
        
        return "<\(authorization())> expire\(expireTextSuffix) at \(dateFormatter.string(from: expirationDate))"
    }
}
