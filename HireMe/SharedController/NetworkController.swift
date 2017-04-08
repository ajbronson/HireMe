//
//  NetworkController.swift
//  HireMe
//
//  Created by AJ Bronson on 3/7/17.
//  Copyright © 2017 AJ Bronson. All rights reserved.
//

import UIKit

class NetworkConroller {

	enum HTTPMethod: String {
		case Get = "GET"
		case Post = "POST"
		case Put = "PUT"
		case Patch = "PATCH"
		case Delete = "DELETE"
	}
    
    enum MIMEType: String {
        case JSON = "application/json"
    }
    
    static func performURLRequest(_ request: URLRequest, completion: @escaping ((Data?, Error?) -> Void)) {
        print("request headers: \(String(describing: request.allHTTPHeaderFields))") // DEBUG
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            completion(data, error)
        }.resume()
    }
    
//    static func request(_ url: URL, method: HTTPMethod, headers: [String: String]? = nil, body: Data? = nil) -> URLRequest {
//        var request = URLRequest(url: url)
//        request.httpMethod = method.rawValue
//        request.httpBody = body
//        
//        if let headersDict = headers {
//            for (key, value) in headersDict {
//                request.addValue(value, forHTTPHeaderField: key)
//            }
//        }
//        
//        return request
//    }
    
    static func request(_ url: URL, method: HTTPMethod, addAuthorizationHeader: Bool = true, headers: [String: String]? = nil, body: Data? = nil, completionHandler: @escaping (URLRequest?, Error?) -> Void) {
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.httpBody = body
        
        if let headersDict = headers {
            for (key, value) in headersDict {
                request.addValue(value, forHTTPHeaderField: key)
            }
        }
        
        if addAuthorizationHeader {
            AuthenticationManager.shared.token { (token, error) in
                guard let oAuthToken = token else {
                    completionHandler(nil, error)
                    return
                }
                
                request.addValue(oAuthToken.authorization(), forHTTPHeaderField: "Authorization")
                completionHandler(request, nil)
            }
        } else {
            completionHandler(request, nil)
        }
    }
    
    static func url(base: String, pathParameters: [String]? = nil, queryParameters: [String: String]? = nil) -> URL {
        let encodedPathParameters = pathParameters?.map({ "\($0.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed)!)" }).joined(separator: "/")
        let urlString = "\(base)/\(encodedPathParameters ?? "")"
        
        guard let url = URL(string: urlString) else {
            fatalError("URL optional is nil")
        }

        var components = URLComponents(url: url, resolvingAgainstBaseURL: true)
        components?.queryItems = queryParameters?.flatMap({ URLQueryItem(name: $0.0, value: $0.1) })
        
        if let url = components?.url {
            print("url: \(url.absoluteString)") // DEBUG
            return url
        } else {
            fatalError("URL optional is nil")
        }
    }
    
    /**
     Creates a dictionary with the values for the keys "grant_type", "client_id", and "client_secret"
     
     - Parameter grantType: E.g., "convert_token", "refresh_token"
     - Returns: A dictionary
     */
    static func httpBody(withGrantType grantType: String) -> [String: String] {
        return [
            "grant_type": grantType,
            "client_id": CLIENT_ID,
            "client_secret": CLIENT_SECRET
        ]
    }

	static func fetchImage(_ url: URL, completion: @escaping (UIImage?, Error?) -> Void) {
        self.request(url, method: .Get) { (request, error) in
            if let err = error {
                completion(nil, err)
            } else if let urlRequest = request {
                self.performURLRequest(urlRequest) { (data, error) in
                    if let data = data {
                        completion(UIImage(data: data), nil)
                    } else {
                        completion(nil, error)
                    }
                }
            }
        }
	}
}
