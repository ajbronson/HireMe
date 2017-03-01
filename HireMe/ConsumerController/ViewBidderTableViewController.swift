//
//  ViewBidderTableViewController.swift
//  HireMe
//
//  Created by AJ Bronson on 1/24/17.
//  Copyright © 2017 AJ Bronson. All rights reserved.
//

import UIKit

class ViewBidderTableViewController: UITableViewController {

	var bid: Bid?
	var skills: [Skill]?
	var bidder: Bidder?
	var descriptionHeight: CGFloat?
	var job: Job?

	override func viewDidLoad() {
		skills = SkillController.shared.skills
		self.tableView.rowHeight = UITableViewAutomaticDimension
		descriptionHeight = nil
		tableView.estimatedRowHeight = 44
		self.tableView.rowHeight = UITableViewAutomaticDimension
		bidder = bid?.bidder

		if let bidder = bidder {
			title = "\(bidder.firstName) \(bidder.lastName)"
		}
	}

	override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
		if section == 0 {
			return nil
		} else if section == 1 {
			if bid?.description != nil {
				return "Description"
			} else {
				return "Skills"
			}
		} else {
			return "Skills"
		}
	}

	override func numberOfSections(in tableView: UITableView) -> Int {
		if bid?.description != nil && (skills?.count)! > 0 {
			return 3
		} else if bid?.description != nil || (skills?.count)! > 0 {
			return 2
		} else {
			return 1
		}
	}

	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		if section == 0 {
			return 1
		} else if section == 1 {
			return bid?.description == nil ? (skills?.count ?? 0) : 1
		} else {
			return skills?.count ?? 0
		}
	}

	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		if indexPath.section == 0 {
			guard let cell = tableView.dequeueReusableCell(withIdentifier: "bidderImageCell") as? BidderImageCell,
				let bid = bid,
				let job = job,
				let bidder = bidder else { return UITableViewCell() }
			cell.updateWith(bid: bid, bidder: bidder, job: job, view: self)
			return cell
		} else if indexPath.section == 1 {
			if bid?.description != nil {
				guard let cell = tableView.dequeueReusableCell(withIdentifier: "bidderDescriptionCell") as? BidderDescriptionCell,
					let bid = bid else { return UITableViewCell() }
				cell.updateWith(description: bid.description)
				return cell
			} else {
				guard let cell = tableView.dequeueReusableCell(withIdentifier: "bidderSkillCell"),
					let skills = skills else { return UITableViewCell() }
				cell.textLabel?.text = skills[indexPath.row].name
				cell.detailTextLabel?.text = "\(skills[indexPath.row].id)"
				return cell
			}
		} else {
			guard let cell = tableView.dequeueReusableCell(withIdentifier: "bidderSkillCell"),
				let skills = skills else { return UITableViewCell() }
			cell.textLabel?.text = skills[indexPath.row].name
			cell.detailTextLabel?.text = "\(skills[indexPath.row].id)"
			return cell
		}
	}

	override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		if indexPath.section == 0 {
			return 295
		}

		return UITableViewAutomaticDimension
	}
}
