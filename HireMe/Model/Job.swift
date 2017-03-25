//
//  Job.swift
//  HireMe
//
//  Created by AJ Bronson on 1/29/17.
//  Copyright © 2017 AJ Bronson. All rights reserved.
//

import UIKit

class Job: Equatable {

	var id: Int
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
	let dateCreated: Date
	var dateUpdated: Date
	var dateCancelled: Date?
	var dateCompleted: Date?
	var reopenDate: Date?
	var selectedBid: Bid?
    var advertiser: User

    init(id: Int, name: String, timeFrameStart: String?, timeFrameEnd: String?, priceRangeStart: Double?, priceRangeEnd: Double?, industry: String?, locationCity: String?, locationState: String?, locationZip: String?, description: String?, status: String = JobStatus.open.rawValue, images: [UIImage]?, dateCreated: Date = Date(), dateUpdated: Date = Date(), advertiser: User) {
		self.id = id
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
		self.dateUpdated = dateUpdated
		self.dateCreated = dateCreated
		self.dateCancelled = nil
		self.dateCompleted = nil
		self.reopenDate = nil
		self.selectedBid = nil
        self.advertiser = advertiser
	}
    
    func timeFrame(dateFormat: String) -> String {
        var startDate: Date?
        var timeFrame = ""
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = dateFormat
        
        if let start = timeFrameStart?.dateFromString() {
            startDate = start
            timeFrame += dateFormatter.string(from: start)
        }
        
        if let end = timeFrameEnd?.dateFromString() {
            if let start = startDate {
                if Calendar.current.compare(start, to: end, toGranularity: .day) != ComparisonResult.orderedSame {
                    timeFrame += " - " + dateFormatter.string(from: end)
                }
            } else {
                timeFrame = dateFormatter.string(from: end)
            }
        }
        
        return timeFrame
    }
    
    func priceRange() -> String {
        var priceRange = priceRangeStart?.convertToCurrency() ?? ""
        
        if let endingPrice = priceRangeEnd?.convertToCurrency() {
            if priceRange.characters.count > 0 {
                // A starting price exists
                if endingPrice != priceRange {
                    // ending price != starting price
                    priceRange += " - " + endingPrice
                }
            } else {
                priceRange = endingPrice
            }
        }
        
        return priceRange
    }
}

func ==(lhs: Job, rhs: Job) -> Bool {
	return lhs.id == rhs.id
}
