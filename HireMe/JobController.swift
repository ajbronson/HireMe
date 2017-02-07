//
//  JobController.swift
//  HireMe
//
//  Created by AJ Bronson on 1/29/17.
//  Copyright © 2017 AJ Bronson. All rights reserved.
//

import Foundation

class JobController {

	static let shared = JobController()

	var jobs: [Job] = []

	init() {
		let job = Job(name: "Wifi Issue", timeFrameStart: "Jan 23, 2014", timeFrameEnd: "Jan 24, 2015", priceRangeStart: 200, priceRangeEnd: 250, industry: "Technology", locationCity: "South Jordan", locationState: "UT", locationZip: "84604")

		let job2 = Job(name: "Lawn Mowing", timeFrameStart: "Jan 23, 2014", timeFrameEnd: "Jan 24, 2015", priceRangeStart: 200, priceRangeEnd: 250, industry: "Technology", locationCity: "South Jordan", locationState: "UT", locationZip: "84604")

		let job3 = Job(name: "Test", timeFrameStart: "Jan 23, 2014", timeFrameEnd: "Jan 24, 2015", priceRangeStart: 200, priceRangeEnd: 250, industry: "Technology", locationCity: "South Jordan", locationState: "UT", locationZip: "84604")

		let job4 = Job(name: "Test2", timeFrameStart: "Jan 23, 2014", timeFrameEnd: "Jan 24, 2015", priceRangeStart: 200, priceRangeEnd: 250, industry: "Technology", locationCity: "South Jordan", locationState: "UT", locationZip: "84604")

		jobs = [job, job2, job3, job4]
	}
}
