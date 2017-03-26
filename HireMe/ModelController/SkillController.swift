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
		let params = ["token" : "abcdefg"]
		if let url = URL(string: "") {
			NetworkConroller.performURLRequest(url, method: .Get, urlParams: params, body: nil, completion: { (data, error) in
				if let error = error {
					print("An error has occured: \(error.localizedDescription)")
				} else if let data = data,
					let rawJSON = try? JSONSerialization.jsonObject(with: data, options: .allowFragments),
					let json = rawJSON as? [String: AnyObject],
					let resultDict = json["results"] as? [[String: AnyObject]] {
					completion(self.skills)
				}
			})
		}
	}
}
