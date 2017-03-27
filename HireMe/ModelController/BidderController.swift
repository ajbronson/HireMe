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
		let bidder = Bidder(id: 1, firstName: "Joe", lastName: "Moe", numberOfStars: 1)
		let bidder2 = Bidder(id: 12, firstName: "Matt", lastName: "Schmidt", numberOfStars: 1)
		let bidder3 = Bidder(id: 13, firstName: "Hillary", lastName: "Prison", numberOfStars: 1)
		let bidder4 = Bidder(id: 14, firstName: "Trumpty", lastName: "Dumpty", numberOfStars: 1)

		bidders = [bidder, bidder2, bidder3, bidder4]
	}

	func refresh(completion: @escaping (_ bidders: [Bidder]?) -> Void) {
		let params = ["token" : "abcdefg"]
		if let url = URL(string: "") {
			NetworkConroller.performURLRequest(url, method: .Get, urlParams: params, body: nil, completion: { (data, error) in
				if let error = error {
					print("An error has occured: \(error.localizedDescription)")
				} else if let data = data,
					let rawJSON = try? JSONSerialization.jsonObject(with: data, options: .allowFragments),
					let json = rawJSON as? [String: AnyObject],
					let resultDict = json["results"] as? [[String: AnyObject]] {
					completion(self.bidders)
				}
			})
		}
	}
}
