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
        let url = NetworkConroller.url(base: BASE_URL, pathParameters: ["whoami/"])
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
                    do {
                        completionHandler(try User(dictionary: responseDict), nil)
                    } catch let initError {
                        completionHandler(nil, initError)
                    }
                }
            })
        }
    }
}
