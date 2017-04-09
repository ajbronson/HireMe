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
    
    init?(dictionary: [String: Any]) {
        if let error = dictionary["error"] as? String {
            print("Error: \(error)")
            return nil
        }
        
        guard let accessToken = dictionary["access_token"] as? String,
            let refreshToken = dictionary["refresh_token"] as? String,
            let scope = dictionary["scope"] as? String,
            let tokenType = dictionary["token_type"] as? String else {
            return nil
        }
        
        if let creationDate = dictionary["creation_date"] as? Date,
            let expirationDate = dictionary["expiration_date"] as? Date {
            self.creationDate = creationDate
            self.expirationDate = expirationDate
        } else if let expiresIn = dictionary["expires_in"] as? Double {
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
