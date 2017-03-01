//
//  SelectedBid.swift
//  HireMe
//
//  Created by AJ Bronson on 2/22/17.
//  Copyright © 2017 AJ Bronson. All rights reserved.
//

import Foundation

class SelectedBid {
	let id: Int
	let job: Job
	let bid: Bid

	init(id: Int, job: Job, bid: Bid) {
		self.id = id
		self.job = job
		self.bid = bid
	}
}
