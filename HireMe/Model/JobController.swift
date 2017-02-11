//
//  JobController.swift
//  HireMe
//
//  Created by AJ Bronson on 1/29/17.
//  Copyright © 2017 AJ Bronson. All rights reserved.
//

import UIKit

class JobController {

	static let shared = JobController()

	var jobs: [Job] = []

	init() {
		let job = Job(name: "Wifi Issue", timeFrameStart: "Jan 23, 2014", timeFrameEnd: "Jan 24, 2015", priceRangeStart: 200, priceRangeEnd: 250, industry: "Remodeling/Home Repairs", locationCity: "South Jordan", locationState: "UT", locationZip: "84604", description: "This is an example of a description.", status: JobStatus.open.rawValue, images: nil)

		let job2 = Job(name: "Lawn Mowing", timeFrameStart: "Jan 23, 2014", timeFrameEnd: "Jan 24, 2015", priceRangeStart: 200, priceRangeEnd: 250, industry: "Technical Support", locationCity: "South Jordan", locationState: "UT", locationZip: "84604", description: "This is an example of a description.", status: JobStatus.open.rawValue, images: nil)

		let job3 = Job(name: "Test", timeFrameStart: "Jan 23, 2014", timeFrameEnd: "Jan 24, 2015", priceRangeStart: 200, priceRangeEnd: 250, industry: "House Cleaning", locationCity: "South Jordan", locationState: "UT", locationZip: "84604", description: "This is an example of a description.", status: JobStatus.open.rawValue, images: nil)

		let job4 = Job(name: "Test2", timeFrameStart: "Jan 23, 2014", timeFrameEnd: "Jan 24, 2015", priceRangeStart: 200, priceRangeEnd: 250, industry: "Automotive", locationCity: "South Jordan", locationState: "UT", locationZip: "84604", description: "This is an example of a description.", status: JobStatus.open.rawValue, images: nil)

		jobs = [job, job2, job3, job4]
	}

	func addJob(name: String, timeFrameStart: String?, timeFrameEnd: String?, priceRangeStart: Double?, priceRangeEnd: Double?, industry: String?, locationCity: String?, locationState: String?, locationZip: String?, description: String?, images: [UIImage]?) -> Bool {
		let job = Job(name: name, timeFrameStart: timeFrameStart, timeFrameEnd: timeFrameEnd, priceRangeStart: priceRangeStart, priceRangeEnd: priceRangeEnd, industry: industry, locationCity: locationCity, locationState: locationState, locationZip: locationZip, description: description, images: images)
		jobs.append(job)
		return true
	}

	func updateJob(job: Job, name: String, timeFrameStart: String?, timeFrameEnd: String?, priceRangeStart: Double?, priceRangeEnd: Double?, industry: String?, locationCity: String?, locationState: String?, locationZip: String?, description: String?, images: [UIImage]?) -> Bool {
		job.name = name
		job.timeFrameStart = timeFrameStart == "" ? nil : timeFrameStart
		job.timeFrameEnd = timeFrameEnd == "" ? nil : timeFrameEnd
		job.priceRangeEnd = priceRangeEnd
		job.priceRangeStart = priceRangeStart
		job.industry = industry == "" ? nil : industry
		job.locationCity = locationCity == "" ? nil : locationCity
		job.locationState = locationState == "" ? nil : locationState
		job.locationZip = locationZip == "" ? nil : locationZip
		job.description = description == "" ? nil : description
		job.images = images
		return true
	}

	func addPhoto(toJob: Job, image: UIImage) -> Bool {
		toJob.images?.append(image)
		return true
	}
}
