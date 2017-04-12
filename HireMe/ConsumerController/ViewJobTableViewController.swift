//
//  ViewJobTableViewController.swift
//  HireMe
//
//  Created by AJ Bronson on 1/24/17.
//  Copyright © 2017 AJ Bronson. All rights reserved.
//

import UIKit

class ViewJobTableViewController: UITableViewController {

	//MARK: - Outlets

	@IBOutlet weak var editButton: UIBarButtonItem!

	//MARK: - Properties

	var reopenButton: UIBarButtonItem?
	var completeButton: UIBarButtonItem?
	var cancelButton: UIBarButtonItem?
	var bids: [Bid]?
	var job: Job?

	//MARK: - View Controller Lifecycle

	override func viewDidLoad() {
		super.viewDidLoad()
		guard let job = job else { return }

		bids = BidController.shared.bids.filter {$0.job == job}
		title = job.name

		configureBottomButtons(onLoad: true)

        navigationItem.backBarButtonItem?.tintColor = UIColor.white
        tableView.hideEmptyCells()
	}

	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
		tableView.reloadData()
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
			
			cell.updateWith(job: job, view: self)
			cell.selectionStyle = .none
			return cell
		} else {
			guard let cell = tableView.dequeueReusableCell(withIdentifier: "bidderInfoCell") as? BidderInfoCell else { return UITableViewCell() }
			cell.updateWith(bid: bids![indexPath.row])
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
				destinationVC.job = job
			}
		} else if segue.identifier == "toEditJob" {
			if let destinationVC = segue.destination as? NewJobTableViewController {
				destinationVC.job = job
			}
		}
	}

	func configureBottomButtons(onLoad: Bool) {
		if let job = job {
			if job.status == .open {
				editButton.isEnabled = true
				completeButton = UIBarButtonItem(title: "Complete Job", style: .plain, target: self, action: #selector(completeButtonAction))
				cancelButton = UIBarButtonItem(title: "Cancel Job", style: .plain, target: self, action: #selector(cancelButtonAction))
				completeButton?.tintColor = AppColors.blueColor
				cancelButton?.tintColor = AppColors.blueColor
				if let cancelButton = cancelButton,
					let completeButton = completeButton {
					let flexibleItem = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
					toolbarItems?.removeAll()
					toolbarItems?.append(flexibleItem)
					toolbarItems?.append(cancelButton)
					toolbarItems?.append(flexibleItem)
					toolbarItems?.append(completeButton)
					toolbarItems?.append(flexibleItem)
				}

				if let reopenButton = reopenButton,
					let reopenIndex = toolbarItems?.index(of: reopenButton) {
					toolbarItems?.remove(at: reopenIndex)
				}

			} else {
				editButton.isEnabled = false
				reopenButton = UIBarButtonItem(title: "Re-Open Job", style: .plain, target: self, action: #selector(reopenButtonAction))
				reopenButton?.tintColor = AppColors.blueColor
				if let reopenButton = reopenButton {
					let flexibleItem = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
					toolbarItems?.removeAll()
					toolbarItems?.append(flexibleItem)
					toolbarItems?.append(reopenButton)
					toolbarItems?.append(flexibleItem)
				}

				if let completeButton = completeButton,
					let cancelButton = cancelButton,
					let completeIndex = toolbarItems?.index(of: completeButton),
					let cancelIndex = toolbarItems?.index(of: cancelButton) {
					toolbarItems?.remove(at: completeIndex)
					toolbarItems?.remove(at: cancelIndex)
				}
			}
		}
	}

	func cancelButtonAction() {
		confirmMessage(withStatus: JobStatus.cancelled, andMessage: "Are you sure you want to cancel this job?")
	}

	func completeButtonAction() {
		confirmMessage(withStatus: JobStatus.completed, andMessage: "Are you sure you want to complete this job?")
	}

	func reopenButtonAction() {
		confirmMessage(withStatus: JobStatus.open, andMessage: "Are you sure you want to reopen this job?")
	}

	func confirmMessage(withStatus: JobStatus, andMessage: String) {
		let alert = UIAlertController(title: "Confirmation Required", message: andMessage, preferredStyle: .alert)
		let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
		let okAction = UIAlertAction(title: "Confirm", style: .default) { (action) in
			//TODO: Confirm/Cancel/Open Job
			guard let job = self.job else { return }
			JobController.shared.updateJobStatus(job: job, status: withStatus)
			self.tableView.reloadData()
			//TODO: This is not working
			self.configureBottomButtons(onLoad: false)
		}
		alert.addAction(cancelAction)
		alert.addAction(okAction)
		self.present(alert, animated: true, completion: nil)
	}
}
