//
//  Skill.swift
//  HireMe
//
//  Created by AJ Bronson on 1/29/17.
//  Copyright © 2017 AJ Bronson. All rights reserved.
//

import Foundation

class Skill {

	var name: String
	var id: Int
	let dateCreated: Date
	var dateUpdated: Date

	init(id: Int, name: String, dateCreated: Date = Date(), dateUpdated: Date = Date()) {
		self.name = name
		self.id = id
		self.dateCreated = dateCreated
		self.dateUpdated = dateUpdated
	}
}
