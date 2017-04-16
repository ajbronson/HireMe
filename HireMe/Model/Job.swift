//
//  Job.swift
//  HireMe
//
//  Created by AJ Bronson on 1/29/17.
//  Copyright © 2017 AJ Bronson. All rights reserved.
//

import UIKit

private let API_DATE_FORMAT = "yyyy-MM-dd'T'HH:mm:ss.SSSSSS'Z"

class Job: Equatable {

    // MARK: - Properties
    
	var id: Int
	var name: String
	var timeFrameStart: String?
	var timeFrameEnd: String?
	var priceRangeStart: Double
	var priceRangeEnd: Double
	var industry: String
	var locationCity: String
	var locationState: String
	var locationZip: String?
	var description: String?
	var status: JobStatus
	var images: [UIImage]?
	let dateCreated: Date
	var dateUpdated: Date
	var dateCancelled: Date?
	var dateCompleted: Date?
	var dateReopened: Date?
	var selectedBid: Bid?
    var advertiser: User
    
    // MARK: - Initializers
    
    // TODO: get all property values from the service once the service is finished
    init(dictionary: [String: Any]) throws {
        if let error = ErrorHelper.checkForError(in: dictionary) {
            throw InitializationError.service(error)
        }
        
        guard let id = dictionary["id"] as? Int,
            let title = dictionary["title"] as? String,
            let created = dictionary["created"] as? String,
            let owner = dictionary["owner"] as? String,
            let priceLow = dictionary["priceLow"] as? Double,
            let priceHigh = dictionary["priceHigh"] as? Double,
            let location = dictionary["location"] as? String else {
                throw InitializationError.invalidDataType
        }
        
        self.id = id
        self.name = title
        self.timeFrameStart = dictionary["startTime"] as? String
        self.timeFrameEnd = dictionary["endTime"] as? String
        self.priceRangeStart = priceLow
        self.priceRangeEnd = priceHigh
        self.industry = "Other"
        self.locationCity = location
        self.locationState = "UT"
        self.locationZip = nil
        self.description = dictionary["description"] as? String
        self.status = .open
        self.images = nil
        
        // TODO: make a singleton date formatter
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = API_DATE_FORMAT
        self.dateCreated = dateFormatter.date(from: created) ?? Date()
        self.dateUpdated = self.dateCreated
        self.dateCancelled = nil
        self.dateCompleted = nil
        self.dateReopened = nil
        self.selectedBid = nil
        self.advertiser = User(id: 2, firstName: "David", lastName: "Payne")
    }

    init(id: Int, name: String, timeFrameStart: String?, timeFrameEnd: String?, priceRangeStart: Double, priceRangeEnd: Double, industry: String, locationCity: String, locationState: String, locationZip: String?, description: String?, status: JobStatus = .open, images: [UIImage]?, dateCreated: Date = Date(), dateUpdated: Date = Date(), advertiser: User) {
		self.id = id
		self.name = name
		self.timeFrameStart = timeFrameStart == "" ? nil : timeFrameStart
		self.timeFrameEnd = timeFrameEnd == "" ? nil : timeFrameEnd
		self.priceRangeStart = priceRangeStart
		self.priceRangeEnd = priceRangeEnd
		self.industry = industry
		self.locationCity = locationCity
		self.locationState = locationState
		self.locationZip = locationZip == "" ? nil : locationZip
		self.description = description == "" ? nil : description
		self.status = status
		self.images = images
		self.dateUpdated = dateUpdated
		self.dateCreated = dateCreated
		self.dateCancelled = nil
		self.dateCompleted = nil
		self.dateReopened = nil
		self.selectedBid = nil
        self.advertiser = advertiser
	}
    
    // MARK: - Methods
    
    func timeFrame(dateFormat: String) -> String {
        let startDate = timeFrameStart?.dateFromString()
        var timeFrame = ""
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = dateFormat
        
        if let start = startDate {
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
        var priceRange = priceRangeStart.convertToCurrency() ?? ""
        
        if let endingPrice = priceRangeEnd.convertToCurrency() {
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
    
    func cityState() -> String {
        return locationCity + ", " + locationState
    }
    
    func cityStateZip() -> String {
        var location = cityState()
        
        if let zip = locationZip {
            location += " " + zip
        }
        
        return location
    }
    
    // MARK: - Private methods
    
    func advertiserID(from url: String) -> Int {
        return 2
    }
}

// MARK: - Equatable

func ==(lhs: Job, rhs: Job) -> Bool {
	return lhs.id == rhs.id
}
