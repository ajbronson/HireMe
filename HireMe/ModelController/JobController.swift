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
        let user1 = User(id: 0, firstName: "Julie", lastName: "Harris", numberOfStars: 5, numberOfRatings: 45)
        let user2 = User(id: 1, firstName: "Benjamin", lastName: "Franklin", numberOfStars: 4, numberOfRatings: 22)
        let user3 = User(id: 2, firstName: "Wonder", lastName: "Woman", numberOfStars: 3, numberOfRatings: 199)
        let user4 = User(id: 3, firstName: "Clark", lastName: "Kent")
        
        let job = Job(id: 0, name: "Wifi Issue", timeFrameStart: "Jan 23, 2017", timeFrameEnd: "Jan 24, 2017", priceRangeStart: 10, priceRangeEnd: 100, industry: "Remodeling/Home Repairs", locationCity: "South Jordan", locationState: "UT", locationZip: "84604", description: "This is an example of a description.", status: JobStatus.awarded.rawValue, images: nil, advertiser: user1)

		let job2 = Job(id: 1, name: "Lawn Mowing", timeFrameStart: "Feb 14, 2017", timeFrameEnd: "Feb 21, 2017", priceRangeStart: 200, priceRangeEnd: 450, industry: "Technical Support", locationCity: "Provo", locationState: "UT", locationZip: "84604", description: "This is an example of a description.", status: JobStatus.cancelled.rawValue, images: nil, advertiser: user2)

		let job3 = Job(id: 2, name: "Test", timeFrameStart: "May 1, 2017", timeFrameEnd: "Aug 31, 2017", priceRangeStart: 750, priceRangeEnd: 1200, industry: "House Cleaning", locationCity: "Salt Lake City", locationState: "UT", locationZip: "84604", description: "This is an example of a description.", status: JobStatus.awarded.rawValue, images: nil, advertiser: user3)

		let job4 = Job(id: 3, name: "I couldn't think of a good name for this job so it's going to be really long", timeFrameStart: "Sep 23, 2017", timeFrameEnd: "Oct 9, 2017", priceRangeStart: 1500, priceRangeEnd: 4000, industry: "Automotive", locationCity: "Llanfairpwllgwyngyllgogerychwyrndrobwllllantysiliogogogoch", locationState: "WA", locationZip: "84604", description: "This is an example of a description.", status: JobStatus.open.rawValue, images: nil, advertiser: user4)

		jobs = [job, job2, job3, job4]
	}

	func addJob(name: String, timeFrameStart: String?, timeFrameEnd: String?, priceRangeStart: Double?, priceRangeEnd: Double?, industry: String?, locationCity: String?, locationState: String?, locationZip: String?, description: String?, images: [UIImage]?) -> Bool {
        // TODO: Get user's profile
        let user = User(id: 0, firstName: "Julie", lastName: "Harris", numberOfStars: 5, numberOfRatings: 45)
        let job = Job(id: 4, name: name, timeFrameStart: timeFrameStart, timeFrameEnd: timeFrameEnd, priceRangeStart: priceRangeStart, priceRangeEnd: priceRangeEnd, industry: industry, locationCity: locationCity, locationState: locationState, locationZip: locationZip, description: description, images: images, advertiser: user)
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
		job.dateUpdated = Date()
		return true
	}

	func updateJobStatus(job: Job, status: JobStatus) {
		switch status {
		case .open:
			job.status = JobStatus.open.rawValue
			job.reopenDate = Date()
			job.dateUpdated = Date()
			job.dateCancelled = nil
			job.dateCompleted = nil
			let bids = BidController.shared.bids.filter {$0.job == job}
			BidController.shared.removeBids(passedBids: bids)
		case .cancelled:
			job.status = JobStatus.cancelled.rawValue
			job.dateCancelled = Date()
			job.dateUpdated = Date()
			job.reopenDate = nil
			job.dateCompleted = nil
		case .completed:
			job.status = JobStatus.completed.rawValue
			job.dateCompleted = Date()
			job.dateUpdated = Date()
			job.dateCancelled = nil
			job.reopenDate = nil
		case .awarded:
			//TODO implement awarded
			break
		}
	}

	func complete(job: Job) {

	}

	func reopen(job: Job) {

	}

	func addPhoto(toJob: Job, image: UIImage) -> Bool {
		toJob.images?.append(image)
		return true
	}
}
