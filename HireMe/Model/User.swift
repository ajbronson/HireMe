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
    var imageURL: String? {
        didSet { fetchImage() }
    }
    var image: UIImage? // used for caching only
    var numberOfStars: Int
    var numberOfRatings: Int
//    var ZIPCode: Int
    
    // MARK: - Object life cycle
    
    init(dictionary: [String: Any]) throws {
        if let error = ErrorHelper.checkForError(in: dictionary) {
            throw InitializationError.service(error)
        }
        
        guard let id = dictionary["id"] as? UInt,
            let username = dictionary["username"] as? String,
            let email = dictionary["email"] as? String else {
                throw InitializationError.invalidDataType
        }
        
        self.id = id
        self.username = username
        self.email = email
        
        if let firstName = dictionary["firstName"] as? String {
            self.firstName = firstName.isEmpty ? nil : firstName
        }
        
        if let lastName = dictionary["lastName"] as? String {
            self.lastName = lastName.isEmpty ? nil : lastName
        }
        
        if let fullName = dictionary["fullName"] as? String {
            self.fullName = fullName.isEmpty ? nil : fullName
        }
        
        if let imageURL = dictionary["imageURL"] as? String {
            self.imageURL = imageURL.isEmpty ? nil : imageURL
        }

        self.numberOfStars = dictionary["numberOfStars"] as? Int ?? 0
        self.numberOfRatings = dictionary["numberOfRatings"] as? Int ?? 0
    }
    
    init(id: UInt, firstName: String, lastName: String, fullName: String? = nil, imageURL: String? = nil, numberOfStars: Int = 0, numberOfRatings: Int = 0) {
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
        self.fullName = fullName
        
        if fullName == nil, let fName = firstName, let lName = lastName {
            self.fullName = "\(fName) \(lName)"
        }
    }
    
    func toDictionary() -> [String: Any] {
        var temp = [String: Any]()
        let mirror = Mirror(reflecting: self)

        for property in mirror.children {
            if let propertyName = property.label, propertyName != "image" {
                temp[propertyName] = getValue(property.value) == nil ? "" : property.value
            }
        }
        
        return temp
    }
    
    func cache() {
//        print("cache()-what will be cached: \(toDictionary())") // DEBUG
        UserDefaults.standard.set(toDictionary(), forKey: CURRENT_USER_KEY)
        print("cache()-what was cached: \(String(describing: UserDefaults.standard.dictionary(forKey: CURRENT_USER_KEY)))") // DEBUG
//        print("user cached") // DEBUG
    }
    
    func fetchImage() {
        print("fetchImage()")
        if let urlString = imageURL, let url = URL(string: urlString) {
//            print("fetchImage(): url exists")
            DispatchQueue.global().async {
//                print("async")
                if let data = try? Data(contentsOf: url) {
//                    print("there's data")
                    DispatchQueue.main.async {
                        self.image = UIImage(data: data)
//                        print("image set")
                    }
                }
            }
        }
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
        return "ID:\(id) username: \(username) email:\(email)"
    }

}
