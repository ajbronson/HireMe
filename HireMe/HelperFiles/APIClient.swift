//
//  APIClient.swift
//  HireMe
//
//  Created by Nathan Johnson on 4/7/17.
//  Copyright © 2017 AJ Bronson. All rights reserved.
//

import Foundation

struct APIClient {
    static func getUser(completionHandler: @escaping (User?, Error?) -> Void) {
        performURLRequest(forEndpoint: "whoami/") { (responseDict, error) in
            guard let dict = responseDict else {
                completionHandler(nil, error)
                return
            }
            
            do {
                completionHandler(try User(dictionary: dict), nil)
            } catch let initError {
                completionHandler(nil, initError)
            }
        }
    }
    
    /**
     Performs a GET request.
     
     - Parameter endpoint: The API endpoint to hit
     - Parameter completionHandler: A Dictionary and an Error will never be returned simultaneously. Either one will be returned or the other.
     - Returns: A dictionary of the response JSON
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
