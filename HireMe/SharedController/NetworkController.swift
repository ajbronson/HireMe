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

	static func performURLRequest(_ url: URL, method: HTTPMethod, urlParams: [String: String]? = nil, body: Data? = nil, completion: ((_ data: Data?, _ error: Error?) -> Void)?) {
		let requestURL = urlFromURLParameters(url, urlParameters: urlParams)
		let request = NSMutableURLRequest(url: requestURL)
		request.httpBody = body
		request.httpMethod = method.rawValue

		let session = URLSession.shared
		let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) in
			if let completion = completion {
				completion(data, error)
			}
		})
		dataTask.resume()
	}
    
    static func performURLRequest(_ request: URLRequest, completion: @escaping ((Data?, Error?) -> Void)) {
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            completion(data, error)
        }.resume()
    }
    
    static func request(_ url: URL, method: HTTPMethod, headers: [String: String]? = nil, body: Data? = nil) -> URLRequest {
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.httpBody = body
        
        if let headersDict = headers {
            for (key, value) in headersDict {
                request.addValue(value, forHTTPHeaderField: key)
            }
        }
        
        return request
    }

	static func urlFromURLParameters(_ url: URL, urlParameters: [String: String]?) -> URL {

		var components = URLComponents(url: url, resolvingAgainstBaseURL: true)
		components?.queryItems = urlParameters?.flatMap({URLQueryItem(name: $0.0, value: $0.1)})

		if let url = components?.url {
			return url
		} else {
			fatalError("URL optional is nil")
		}
	}
    
    static func url(withBaseURL base: String, pathParameters: [String]) -> URL {
        let encodedPathParameters = pathParameters.map({ "\($0.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed)!)" }).joined(separator: "/")
        let urlString = "\(base)/\(encodedPathParameters)"
//        print("url(base:pathParameters:): \(urlString)")
        
        if let url = URL(string: urlString) {
            return url
        } else {
            fatalError("URL optional is nil")
        }
    }

	static func fetchImage(_ url: URL, completion: @escaping (_ image: UIImage?) -> Void) {
		self.performURLRequest(url, method: .Get) { (data, error) in
			if let data = data {
				let image = UIImage(data: data)
				completion(image)
			}
		}
	}
}
