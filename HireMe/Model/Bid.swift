//
//  Bid.swift
//  HireMe
//
//  Created by AJ Bronson on 1/29/17.
//  Copyright © 2017 AJ Bronson. All rights reserved.
//

import Foundation

class Bid: Equatable {

	var id: String
	var price: Double?
	var description: String
	var status: String
	var bidder: Bidder
	var job: Job
	let dateCreated: Date
	var dateUpdated: Date

	init(id: String, bidder: Bidder, job: Job, price: Double?, description: String, status: String = BidStatus.PendingResponse.rawValue, dateCreated: Date = Date(), dateUpdated: Date = Date()) {
		self.id = id
		self.bidder = bidder
		self.job = job
		self.price = price
		self.description = description
		self.status = status
		self.dateCreated = dateCreated
		self.dateUpdated = dateUpdated
	}
}

func ==(lhs: Bid, rhs:Bid) -> Bool {
	return lhs.id == rhs.id
}
