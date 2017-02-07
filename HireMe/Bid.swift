//
//  Bid.swift
//  HireMe
//
//  Created by AJ Bronson on 1/29/17.
//  Copyright © 2017 AJ Bronson. All rights reserved.
//

import Foundation

class Bid {

	var user: String
	var price: Double?
	var description: String

	init(user: String, price: Double?, description: String) {
		self.user = user
		self.price = price
		self.description = description
	}
}
