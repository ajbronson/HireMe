//
//  ErrorHelper.swift
//  HireMe
//
//  Created by Nathan Johnson on 4/6/17.
//  Copyright © 2017 AJ Bronson. All rights reserved.
//

import Foundation

/*
 {
     "detail": "Invalid token header. No credentials provided."
 }
 
 {
     "detail": "Invalid token header. Invalid backend."
 }
 
 {
     "error_description": "Invalid backend parameter.",
     "error": "invalid_request"
 }
 
 {
     "error": "unsupported_grant_type"
 }
 */

enum AuthenticationError: String, Error {
    case notAuthenticated = "Not authenticated."
    case noAccessToken = "An access token has not been issued."
    case accessTokenAlreadyIssued = "An access token has already been issued."
    case oAuthTokenInitialization = "Failed to initialize OAuthToken."
}

enum LimitedHireError: String, Error {
    case deserializeJSON = "Failed to deserialize JSON."
    case noURLRequest = "URLRequest is nil."
}

class ErrorHelper {
    static func describe(_ error: Error) {
        var message: String
        
        if let limitedHireError = error as? LimitedHireError {
            message = limitedHireError.rawValue
        } else {
            message = error.localizedDescription
        }
        
        print("Error: \(message)")
    }
}
