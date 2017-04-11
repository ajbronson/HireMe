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
		let skill2 = Skill(id: 12,name: "Lawn Mowing")
		let skill3 = Skill(id: 13,name: "Human Interaction")
		let skill4 = Skill(id: 14,name: "Weaving")

		skills = [skill, skill2, skill3, skill4]
	}

	func refresh(completion: @escaping (_ skills: [Skill]?) -> Void) {
		// TODO: implement
	}
}
