//
//  SelectedBidController.swift
//  HireMe
//
//  Created by AJ Bronson on 2/22/17.
//  Copyright © 2017 AJ Bronson. All rights reserved.
//

import Foundation

class SelectedBidController {

	static let shared = SelectedBidController()

	var selectedBids: [SelectedBid]?

	init() {
		let allAwardedJobs = JobController.shared.jobs.filter{$0.status == .awarded}
		let bids = BidController.shared.bids.filter{$0.job == allAwardedJobs[0]}
		let selectedBid = SelectedBid(id: 0, job: allAwardedJobs[0], bid: bids[0])

		let bids2 = BidController.shared.bids.filter{$0.job == allAwardedJobs[1]}
		let selectedBid2 = SelectedBid(id: 0, job: allAwardedJobs[1], bid: bids2[0])

		selectedBids = [selectedBid, selectedBid2]
	}

	func refresh(completion: @escaping (_ selectedBids: [SelectedBid]?) -> Void) {
		let params = ["token" : "abcdefg"]
		if let url = URL(string: "") {
			NetworkConroller.performURLRequest(url, method: .Get, urlParams: params, body: nil, completion: { (data, error) in
				if let error = error {
					print("An error has occured: \(error.localizedDescription)")
				} else if let data = data,
					let rawJSON = try? JSONSerialization.jsonObject(with: data, options: .allowFragments),
					let json = rawJSON as? [String: AnyObject],
					let resultDict = json["results"] as? [[String: AnyObject]] {
					completion(self.selectedBids)
				}
			})
		}
	}
}
