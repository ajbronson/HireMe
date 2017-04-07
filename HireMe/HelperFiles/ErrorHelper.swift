//
//  ErrorHelper.swift
//  HireMe
//
//  Created by Nathan Johnson on 4/6/17.
//  Copyright © 2017 AJ Bronson. All rights reserved.
//

import Foundation

enum LimitedHireError: String, Error {
    case noOAuthToken = "An OAuth token has not been obtained."
    case deserializeJSON = "Failed to deserialize JSON."
    case oAuthTokenInitialization = "Failed to initialize OAuthToken."
    case notAuthenticated = "Not authenticated."
    case oAuthTokenAlreadyObtained = "An OAuth token has already been obtained."
}

class ErrorHelper {
    static func describe(_ error: Error) {
        let prefix = "Error: "
        var message: String
        
        if let limitedHireError = error as? LimitedHireError {
            message = limitedHireError.rawValue
        } else {
            message = error.localizedDescription
        }
        
        print("\(prefix)\(message)")
    }
}
