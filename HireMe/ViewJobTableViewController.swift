//
//  ViewJobTableViewController.swift
//  HireMe
//
//  Created by AJ Bronson on 1/24/17.
//  Copyright © 2017 AJ Bronson. All rights reserved.
//

import UIKit

class ViewJobTableViewController: UITableViewController {

	var bids: [Bid]?
	var job: Job?

	override func viewDidLoad() {
		super.viewDidLoad()
		bids = BidController.shared.bids
		title = job?.name
	}

	override func numberOfSections(in tableView: UITableView) -> Int {
		if bids?.count == 0 {
			return 1
		} else {
			return 2
		}
	}

	override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
		if section == 0 {
			return "Job Information"
		} else {
			return "Bids"
		}
	}

	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		if section == 0 {
			return 1
		} else {
			return bids?.count ?? 0
		}
	}

	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		if indexPath.section == 0 && indexPath.row == 0 {
			guard let cell = tableView.dequeueReusableCell(withIdentifier: "jobInfoCell") as? JobInfoCell,
				let job = job else { return UITableViewCell() }
			cell.updateWith(job: job)
			cell.selectionStyle = .none
			return cell
		} else {
			guard let cell = tableView.dequeueReusableCell(withIdentifier: "bidderInfoCell") as? BidderInfoCell else { return UITableViewCell() }
			cell.updateWith(bid: bids![indexPath.row], bidder: BidderController.shared.bidders[0])
			return cell
		}
	}

	override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		if indexPath.section == 0 && indexPath.row == 0 {
			return 205
		}
		return 60
	}

	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if segue.identifier == "toBidderInfo" {
			if let destinationVC = segue.destination as? ViewBidderTableViewController,
				let indexPath = tableView.indexPathForSelectedRow,
				let bids = bids {
				destinationVC.bid = bids[indexPath.row]
			}
		}
	}

	@IBAction func cancelJobButtonTapped(_ sender: UIBarButtonItem) {
		let alert = UIAlertController(title: "Confirmation Required", message: "Are you sure you want to cancel this job?", preferredStyle: .alert)
		let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
		let okAction = UIAlertAction(title: "Delete", style: .destructive) { (action) in
			//TODO: Cancel Job
		}
		alert.addAction(cancelAction)
		alert.addAction(okAction)
		self.present(alert, animated: true, completion: nil)
	}

	@IBAction func completeJobButtonTapped(_ sender: UIBarButtonItem) {
		let alert = UIAlertController(title: "Confirmation Required", message: "Complete this job?", preferredStyle: .alert)
		let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
		let okAction = UIAlertAction(title: "Confirm", style: .default) { (action) in
			//TODO: Confirm Job
		}
		alert.addAction(cancelAction)
		alert.addAction(okAction)
		self.present(alert, animated: true, completion: nil)
	}

}
