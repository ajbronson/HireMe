//
//  ErrorHelper.swift
//  HireMe
//
//  Created by Nathan Johnson on 4/6/17.
//  Copyright © 2017 AJ Bronson. All rights reserved.
//

import Foundation

enum LimitedHireError: Error {
    case noOAuthToken
    case deserializeJSON
    case oAuthTokenInitialization
}

class ErrorHelper {
    static func handle(_ error: Error) {
        let prefix = "Error: "
        var message: String
        
        if let limitedHireError = error as? LimitedHireError {
            switch limitedHireError {
            case .deserializeJSON: message = "Failed to deserialize JSON."
            case .noOAuthToken: message = "An OAuth token has not been obtained."
            case .oAuthTokenInitialization: message = "Failed to initialize OAuthToken."
            }
        } else {
            message = error.localizedDescription
        }
        
        print("\(prefix)\(message)")
    }
}
