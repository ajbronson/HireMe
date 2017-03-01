//
//  Bidder.swift
//  HireMe
//
//  Created by AJ Bronson on 1/29/17.
//  Copyright © 2017 AJ Bronson. All rights reserved.
//

import Foundation

class Bidder: Equatable {

	var id: Int
	var firstName: String
	var lastName: String
	var numberOfStars: Int
	let dateCreated: Date
	var dateUpdated: Date

	init(id: Int, firstName: String, lastName: String, numberOfStars: Int, dateCreated: Date = Date(), dateUpdated: Date = Date()) {
		self.id = id
		self.firstName = firstName
		self.lastName = lastName
		self.numberOfStars = numberOfStars
		self.dateCreated = dateCreated
		self.dateUpdated = dateUpdated
	}
}

func ==(lhs: Bidder, rhs: Bidder) -> Bool {
	return lhs.id == rhs.id
}
