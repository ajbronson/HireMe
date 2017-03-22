//
//  User.swift
//  HireMe
//
//  Created by Nathan Johnson on 3/18/17.
//  Copyright © 2017 AJ Bronson. All rights reserved.
//

import UIKit

class User {
    
    var id: Int
    var firstName: String
    var lastName: String
    var fullName: String
//    var email: String
//    var phoneNumber: String
    var image: UIImage?
    var numberOfStars: Int
    var numberOfRatings: Int
//    var ZIPCode: Int
    
    init(id: Int, firstName: String, lastName: String, fullName: String? = nil, image: UIImage? = nil, numberOfStars: Int = 0, numberOfRatings: Int = 0) {
        self.id = id
        self.firstName = firstName
        self.lastName = lastName
        self.fullName = fullName ?? "\(firstName) \(lastName)"
        self.image = image
        self.numberOfStars = numberOfStars
        self.numberOfRatings = numberOfRatings
    }

}
