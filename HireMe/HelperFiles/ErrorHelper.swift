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
 
 
 convert-token error messages
 
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

enum InitializationError: Error {
    case service(String) // Error returned from the web service in the JSON
    case invalidDataType
}

enum NetworkError: String, Error {
    case deserializeJSON = "Failed to deserialize JSON."
    case noURLRequest = "A URLRequest was not provided."
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
