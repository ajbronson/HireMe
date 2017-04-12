//
//  SkillController.swift
//  HireMe
//
//  Created by AJ Bronson on 1/29/17.
//  Copyright © 2017 AJ Bronson. All rights reserved.
//

import Foundation

class SkillController {

	static let shared = SkillController()

	var skills: [Skill] = []

	init() {
		let skill = Skill(id: 1, name: "Web Development")
		let skill2 = Skill(id: 2,name: "Lawn Mowing")
		let skill3 = Skill(id: 3,name: "Landscaping")
		let skill4 = Skill(id: 4,name: "Sprinkler Fixes")
		let skill5 = Skill(id: 5,name: "Piano Playing")
		let skill6 = Skill(id: 6,name: "Baby Sitter")
		let skill7 = Skill(id: 7,name: "Engine/Transmission Specialist")

		skills = [skill, skill2, skill3, skill4, skill5, skill6, skill7]
	}

	func refresh(completion: @escaping (_ skills: [Skill]?) -> Void) {
		// TODO: implement
	}
}
