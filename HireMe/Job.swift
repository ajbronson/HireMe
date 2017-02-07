//
//  Job.swift
//  HireMe
//
//  Created by AJ Bronson on 1/29/17.
//  Copyright © 2017 AJ Bronson. All rights reserved.
//

import Foundation

class Job {

	var name: String
	var timeFrameStart: String?
	var timeFrameEnd: String?
	var priceRangeStart: Double?
	var priceRangeEnd: Double?
	var industry: String?
	var locationCity: String?
	var locationState: String?
	var locationZip: String?

	init(name: String, timeFrameStart: String?, timeFrameEnd: String?, priceRangeStart: Double?, priceRangeEnd: Double?, industry: String?, locationCity: String?, locationState: String?, locationZip: String?) {
		self.name = name
		self.timeFrameStart = timeFrameStart
		self.timeFrameEnd = timeFrameEnd
		self.priceRangeStart = priceRangeStart
		self.priceRangeEnd = priceRangeEnd
		self.industry = industry
		self.locationCity = locationCity
		self.locationState = locationState
		self.locationZip = locationZip
	}
}
