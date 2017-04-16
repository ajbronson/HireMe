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
        let user1 = User(id: 0, firstName: "Julie", lastName: "Harrison", numberOfStars: 5, numberOfRatings: 45)
        let user2 = User(id: 1, firstName: "Amanda", lastName: "Clarkson", numberOfStars: 4, numberOfRatings: 22)
        let user3 = User(id: 2, firstName: "Buddy", lastName: "Tilmanson", numberOfStars: 3, numberOfRatings: 199)
        let user4 = User(id: 3, firstName: "Clark", lastName: "Smith")
        
        let job = Job(id: 0, name: "Setup new TV and audio center", timeFrameStart: "May 23, 2017", timeFrameEnd: "May 24, 2017", priceRangeStart: 10, priceRangeEnd: 100, industry: "Remodeling/Home Repairs", locationCity: "Santa Barhme", locationState: "WA", locationZip: nil, description: "We'll be buying a new TV and audio entertainment center around this time. I would like somebody who is a professional to install a wall mount, and hide all cords behind the walls.  You will probably need to be insured, because if the TV breaks on your hands, you will have to replace it. Let me know what you can do.", status: .open, images: nil, advertiser: user1)

		let job2 = Job(id: 1, name: "Lawn Mowing", timeFrameStart: "Feb 14, 2017", timeFrameEnd: "Aug 21, 2017", priceRangeStart: 200, priceRangeEnd: 200, industry: AppInfo.industries[3], locationCity: "Provo", locationState: "UT", locationZip: "84604", description: "I'll pay 200 to someone who wants to mow my lawn. Must bring own mower. Entire summer. Water provided.", status: .cancelled, images: nil, advertiser: user2)

		let job3 = Job(id: 2, name: "Kitchen Remodel", timeFrameStart: "May 1, 2017", timeFrameEnd: "Aug 31, 2017", priceRangeStart: 750, priceRangeEnd: 5000, industry: "Remodeling/Home Repairs", locationCity: "Salt Lake City", locationState: "UT", locationZip: nil, description: "I'm redoing my kitchen this year! It's about time.  We have everything picked out, but need someone to do the work. Probably best if you stop by our place in SLC to get an idea of the work that needs to be done.", status: .completed, images: nil, advertiser: user3)

		let job4 = Job(id: 3, name: "Deep House Clean", timeFrameStart: "Apr 27, 2017", timeFrameEnd: "Apr 28, 2017", priceRangeStart: 1500, priceRangeEnd: 4000, industry: "House Cleaning", locationCity: "Orem", locationState: "UT", locationZip: "84097", description: "House needs spring cleaning.  We have two boys moving around, one off to college and the other coming home from the mission. We are seeking professional cleaning services to make this place look amazing. Must be completed by these dates.", images: nil, advertiser: user4)
        
        let job5 = Job(id: 4, name: "Fence Painting", timeFrameStart: "Jun 12, 2017", timeFrameEnd: "Jun 12, 2017", priceRangeStart: 50, priceRangeEnd: 150, industry: "Yard Maintenance", locationCity: "Springville", locationState: "UT", locationZip: "83713", description: "Looking for folks to help us paint a fence. It's about 500ft of fencing surrounding the property. Should be a pretty quick job if we can get a few people in on it.", images: nil, advertiser: user3)

		let job6 = Job(id: 4, name: "Oil Change and brakes", timeFrameStart: "Apr 12, 2017", timeFrameEnd: "Apr 12, 2017", priceRangeStart: 50, priceRangeEnd: 150, industry: "Automotive", locationCity: "Provo", locationState: "UT", locationZip: "84604", description: "Need someone to change oil. Car is a 2007 toyota camery, in clean great condition. Would be nice if you cleaned and vacuumed the car as well. The brakes have been squeeking lately, so I'd like you to look at them and change them. Prices will change if this work is done or not.", images: nil, advertiser: user3)

		jobs = [job, job2, job3, job4, job5, job6]
	}

	func addJob(name: String, timeFrameStart: String?, timeFrameEnd: String?, priceRangeStart: Double, priceRangeEnd: Double, industry: String, locationCity: String, locationState: String, locationZip: String?, description: String?, images: [UIImage]?) -> Bool {
        // TODO: Get user's profile
        let user = User(id: 0, firstName: "Julie", lastName: "Harris", numberOfStars: 5, numberOfRatings: 45)
        let job = Job(id: 4, name: name, timeFrameStart: timeFrameStart, timeFrameEnd: timeFrameEnd, priceRangeStart: priceRangeStart, priceRangeEnd: priceRangeEnd, industry: industry, locationCity: locationCity, locationState: locationState, locationZip: locationZip, description: description, images: images, advertiser: user)
		jobs.append(job)
		return true
	}

	func updateJob(job: Job, name: String, timeFrameStart: String?, timeFrameEnd: String?, priceRangeStart: Double, priceRangeEnd: Double, industry: String, locationCity: String, locationState: String, locationZip: String?, description: String?, images: [UIImage]?) -> Bool {
		job.name = name
		job.timeFrameStart = timeFrameStart == "" ? nil : timeFrameStart
		job.timeFrameEnd = timeFrameEnd == "" ? nil : timeFrameEnd
		job.priceRangeEnd = priceRangeEnd
		job.priceRangeStart = priceRangeStart
		job.industry = industry
		job.locationCity = locationCity
		job.locationState = locationState
		job.locationZip = locationZip == "" ? nil : locationZip
		job.description = description == "" ? nil : description
		job.images = images
		job.dateUpdated = Date()
		return true
	}

	func updateJobStatus(job: Job, status: JobStatus) {
		job.status = status
        job.dateUpdated = Date()
        
        switch status {
		case .open:
			job.dateReopened = Date()
			let bids = BidController.shared.bids.filter {$0.job == job}
			BidController.shared.removeBids(passedBids: bids)
		case .cancelled:
			job.dateCancelled = Date()
		case .completed:
			job.dateCompleted = Date()
		case .awarded:
			// TODO: implement awarded
			break
        case .pending:
            // TODO: implement pending status
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

	func refresh(completion: @escaping (_ jobs: [Job]?) -> Void) {
		// TODO: implement
	}
}
