//
//  Bidder.swift
//  HireMe
//
//  Created by AJ Bronson on 1/29/17.
//  Copyright © 2017 AJ Bronson. All rights reserved.
//

import Foundation

class Bidder {

	var id: Int
	var firstName: String
	var lastName: String
	var numberOfStars: Int

	init(id: Int, firstName: String, lastName: String, numberOfStars: Int) {
		self.id = id
		self.firstName = firstName
		self.lastName = lastName
		self.numberOfStars = numberOfStars
	}
}
