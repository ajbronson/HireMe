//
//  APIClient.swift
//  HireMe
//
//  Created by Nathan Johnson on 4/7/17.
//  Copyright © 2017 AJ Bronson. All rights reserved.
//

import Foundation

struct APIClient {
    static func getAllJobs(completionHandler: @escaping ([Job]?, Error?) -> Void) {
        performURLRequest(forEndpoint: "job") { (responseDict, error) in
            guard let _ = responseDict else {
                completionHandler(nil, error)
                return
            }
            
            // TODO: implement creating the list of jobs from the response dictionary
        }
    }
    
    /**
     Gets the user's profile.
     
     - Parameter completionHandler: A User and an Error will never be returned simultaneously. Either one will be returned or the other.
     */
    static func getUser(completionHandler: @escaping (Error?) -> Void) {
        performURLRequest(forEndpoint: "whoami/") { (responseDict, error) in
            guard let dict = responseDict else {
                completionHandler(error)
                return
            }
            
            do {
                let user = try User(dictionary: dict)
                UserController.shared.setCurrentUser(user)
                completionHandler(nil)
            } catch let initError {
                completionHandler(initError)
            }
        }
    }
    
    /**
     Performs a GET request that provides a dictionary of the response JSON.
     
     - Parameter endpoint: The API endpoint to hit
     - Parameter completionHandler: A Dictionary and an Error will never be returned simultaneously. Either one will be returned or the other.
     */
    private static func performURLRequest(forEndpoint endpoint: String, completionHandler: @escaping ([String: Any]?, Error?) -> Void) {
        let url = NetworkConroller.url(base: BASE_URL, pathParameters: [endpoint])
        NetworkConroller.request(url, method: .Get) { (request, error) in
            guard let urlRequest = request else {
                completionHandler(nil, error)
                return
            }
            
            NetworkConroller.performURLRequest(urlRequest, completion: { (data, error2) in
                if let err = error2 {
                    completionHandler(nil, err)
                } else {
                    guard let json = data?.toJSON(), let responseDict = json as? [String: Any] else {
                        completionHandler(nil, NetworkError.deserializeJSON)
                        return
                    }
                    print(responseDict) // DEBUG
                    completionHandler(responseDict, nil)
                }
            })
        }
    }
}
