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
        
        switch error {
        case let authError as AuthenticationError: message = authError.rawValue
        case let initError as InitializationError:
            switch initError {
            case .service(let serviceMessage): message = serviceMessage
            case .invalidDataType: message = "Failed to retrieve key value. Unexpected data type provided."
            }
        case let netError as NetworkError: message = netError.rawValue
        default: message = error.localizedDescription
        }

        print("Error: \(message)")
    }
    
    /**
     Checks for an error returned in the response JSON of the request.
     
     - Parameter inResponseDictionary: The dictionary object of the response.
     - Returns: The error message if an error was returned from the service.
     */
    static func checkForError(inResponseDictionary dict: [String: Any]) -> String? {
        if let error = dict["error"] as? String {
            var message = error
            
            if let description = dict["error_description"] as? String {
                message += ". \(description)"
            }
            
            return message
        }
        
        if let detail = dict["detail"] as? String {
            return detail
        }
        
        return nil
    }
}
