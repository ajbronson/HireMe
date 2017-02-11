//
//  Job.swift
//  HireMe
//
//  Created by AJ Bronson on 1/29/17.
//  Copyright © 2017 AJ Bronson. All rights reserved.
//

import UIKit

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
	var description: String?
	var status: String
	var images: [UIImage]?

	init(name: String, timeFrameStart: String?, timeFrameEnd: String?, priceRangeStart: Double?, priceRangeEnd: Double?, industry: String?, locationCity: String?, locationState: String?, locationZip: String?, description: String?, status: String = JobStatus.open.rawValue, images: [UIImage]?) {
		self.name = name
		self.timeFrameStart = timeFrameStart == "" ? nil : timeFrameStart
		self.timeFrameEnd = timeFrameEnd == "" ? nil : timeFrameEnd
		self.priceRangeStart = priceRangeStart
		self.priceRangeEnd = priceRangeEnd
		self.industry = industry == "" ? nil : industry
		self.locationCity = locationCity == "" ? nil : locationCity
		self.locationState = locationState == "" ? nil : locationState
		self.locationZip = locationZip == "" ? nil : locationZip
		self.description = description == "" ? nil : description
		self.status = status
		self.images = images
	}
}
