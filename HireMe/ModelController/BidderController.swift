//
//  BidderController.swift
//  HireMe
//
//  Created by AJ Bronson on 1/29/17.
//  Copyright © 2017 AJ Bronson. All rights reserved.
//

import Foundation

class BidderController {

	static let shared = BidderController()

	var bidders: [Bidder] = []

	init() {
		let bidder = Bidder(id: 1, firstName: "Tim", lastName: "Richardson", numberOfStars: 2)
		let bidder2 = Bidder(id: 12, firstName: "Sheridan", lastName: "Lee", numberOfStars: 4)
		let bidder3 = Bidder(id: 13, firstName: "Joseph", lastName: "Galbraith", numberOfStars: 3)
		let bidder4 = Bidder(id: 14, firstName: "Nick", lastName: "Johnson", numberOfStars: 1)
		let bidder5 = Bidder(id: 14, firstName: "Elizabeth", lastName: "Rickenson", numberOfStars: 5)

		bidders = [bidder, bidder2, bidder3, bidder4, bidder5]
	}

	func refresh(completion: @escaping (_ bidders: [Bidder]?) -> Void) {
		// TODO: implement
	}
}
