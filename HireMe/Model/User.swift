//
//  User.swift
//  HireMe
//
//  Created by Nathan Johnson on 3/18/17.
//  Copyright © 2017 AJ Bronson. All rights reserved.
//

import UIKit

class User: CustomStringConvertible {
    
    var id: UInt
    var username: String
    var email: String
//    var jobs: [Job]?
    var firstName: String?
    var lastName: String?
    var fullName: String?
//    var phoneNumber: String
    var imageURL: URL?
    var numberOfStars: Int
    var numberOfRatings: Int
//    var ZIPCode: Int
    
    // MARK: - Object life cycle
    
    init(dictionary: [String: Any]) throws {
        if let error = ErrorHelper.checkForError(in: dictionary) {
            throw InitializationError.service(error)
        }
        
        guard let result = NetworkConroller.getResults(from: dictionary)?.first,
            let id = result["id"] as? UInt,
            let username = result["username"] as? String,
            let email = result["email"] as? String else {
                throw InitializationError.invalidDataType
        }
        
        self.id = id
        self.username = username
        self.email = email
        
        if let firstName = result["firstName"] as? String {
            self.firstName = firstName.isEmpty ? nil : firstName
        }
        
        if let lastName = result["lastName"] as? String {
            self.lastName = lastName.isEmpty ? nil : lastName
        }
        
        if let fullName = result["fullName"] as? String {
            self.fullName = fullName.isEmpty ? nil : fullName
        }

        self.numberOfStars = result["numberOfStars"] as? Int ?? 0
        self.numberOfRatings = result["numberOfRatings"] as? Int ?? 0
    }
    
    init(id: UInt, firstName: String, lastName: String, fullName: String? = nil, imageURL: URL? = nil, numberOfStars: Int = 0, numberOfRatings: Int = 0) {
        self.id = id
        self.firstName = firstName
        self.lastName = lastName
        self.fullName = fullName ?? "\(firstName) \(lastName)"
        self.imageURL = imageURL
        self.numberOfStars = numberOfStars
        self.numberOfRatings = numberOfRatings
        
        self.username = ""
        self.email = ""
    }
    
    // MAKR: - Methods
    
    func update(firstName: String?, lastName: String?, fullName: String? = nil) {
        self.firstName = firstName
        self.lastName = lastName
        self.fullName = fullName ?? "\(firstName) \(lastName)"
    }
    
    func toDictionary() -> [String: Any] {
        var temp = [String: Any]()
        let mirror = Mirror(reflecting: self)

        for property in mirror.children {
            if let propertyName = property.label {
                temp[propertyName] = getValue(property.value) == nil ? "" : property.value
            }
        }
        
        return temp
    }
    
    /**
     Tests if Any has nil in it.
     
     - Parameter unknownValue: The Any value to test if it has nil
     - Returns: Optional Any
     */
    private func getValue(_ unknownValue: Any) -> Any? {
        let mirror = Mirror(reflecting: unknownValue)
        
        if mirror.displayStyle == .optional && mirror.children.count == 0 {
            return nil
        } else {
            return unknownValue
        }
    }
    
    // MARK: - CustomStringConvertible
    
    var description: String {
        return "\(id): \(username) \(email)"
    }

}
