//
//  ConsumerJobsTableViewController.swift
//  HireMe
//
//  Created by AJ Bronson on 1/24/17.
//  Copyright © 2017 AJ Bronson. All rights reserved.
//

import UIKit

class ConsumerJobTableViewController: UITableViewController {

	var jobs: [Job]?
	var completedJobs: [Job]?
	var cancelledJobs: [Job]?
	var types: [JobStatus]?

	override func viewWillAppear(_ animated: Bool) {
		let allJobs = JobController.shared.jobs
		jobs = allJobs.filter {$0.status == JobStatus.open.rawValue}
		completedJobs = allJobs.filter {$0.status == JobStatus.completed.rawValue}
		cancelledJobs = allJobs.filter {$0.status == JobStatus.cancelled.rawValue}
		types = getJobs()
		tableView.reloadData()
	}

	override func numberOfSections(in tableView: UITableView) -> Int {
		return getJobs().count
	}

	override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
		guard let types = types else { return "" }
		if section == 0 && types.contains(JobStatus.open) {
			return "Current Jobs"
		} else if (section == 1 && types.contains(JobStatus.completed) && types.contains(JobStatus.open)) ||
			section == 0 && types.contains(JobStatus.completed) {
			return "Completed Jobs"
		} else if (section == 2 && types.contains(JobStatus.cancelled) && types.contains(JobStatus.completed) && types.contains(JobStatus.open)) ||
			(section == 1 && (types.contains(JobStatus.completed) || types.contains(JobStatus.open)) && types.contains(JobStatus.cancelled)) ||
			(section == 0 && !types.contains(JobStatus.open) && !types.contains(JobStatus.completed) && types.contains(JobStatus.cancelled)) {
			return "Cancelled Jobs"
		} else {
			return ""
		}
	}

	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		guard let types = types else { return 0 }

		if section == 0 && types.contains(JobStatus.open) {
			return jobs?.count ?? 0
		} else if (section == 1 && types.contains(JobStatus.completed) && types.contains(JobStatus.open)) ||
			section == 0 && types.contains(JobStatus.completed) {
			return completedJobs?.count ?? 0
		} else if (section == 2 && types.contains(JobStatus.cancelled) && types.contains(JobStatus.completed) && types.contains(JobStatus.open)) ||
			(section == 1 && (types.contains(JobStatus.completed) || types.contains(JobStatus.open)) && types.contains(JobStatus.cancelled)) ||
			(section == 0 && !types.contains(JobStatus.open) && !types.contains(JobStatus.completed) && types.contains(JobStatus.cancelled)) {
			return cancelledJobs?.count ?? 0
		} else {
			return 0
		}
	}

	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		guard let cell = tableView.dequeueReusableCell(withIdentifier: "jobCell"),
			let types = types else { return UITableViewCell() }

		if indexPath.section == 0 && types.contains(JobStatus.open) {
			cell.textLabel?.text = jobs?[indexPath.row].name
			cell.detailTextLabel?.text = jobs?[indexPath.row].industry
		} else if (indexPath.section == 1 && types.contains(JobStatus.completed) && types.contains(JobStatus.open)) ||
			indexPath.section == 0 && types.contains(JobStatus.completed) {
			cell.textLabel?.text = completedJobs?[indexPath.row].name
			cell.detailTextLabel?.text = completedJobs?[indexPath.row].industry
		} else if (indexPath.section == 2 && types.contains(JobStatus.cancelled) && types.contains(JobStatus.completed) && types.contains(JobStatus.open)) ||
			(indexPath.section == 1 && (types.contains(JobStatus.completed) || types.contains(JobStatus.open)) && types.contains(JobStatus.cancelled)) ||
			(indexPath.section == 0 && !types.contains(JobStatus.open) && !types.contains(JobStatus.completed) && types.contains(JobStatus.cancelled)) {
			cell.textLabel?.text = cancelledJobs?[indexPath.row].name
			cell.detailTextLabel?.text = cancelledJobs?[indexPath.row].industry
		}

		return cell
	}

	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if segue.identifier == "toJobView" {
			if let destinationVC = segue.destination as? ViewJobTableViewController,
				let types = types,
				let indexPath = tableView.indexPathForSelectedRow {
				if indexPath.section == 0 && types.contains(JobStatus.open) {
					destinationVC.job = jobs?[indexPath.row]
				} else if (indexPath.section == 1 && types.contains(JobStatus.completed) && types.contains(JobStatus.open)) ||
					indexPath.section == 0 && types.contains(JobStatus.completed) {
					destinationVC.job = completedJobs?[indexPath.row]
				} else if (indexPath.section == 2 && types.contains(JobStatus.cancelled) && types.contains(JobStatus.completed) && types.contains(JobStatus.open)) ||
					(indexPath.section == 1 && (types.contains(JobStatus.completed) || types.contains(JobStatus.open)) && types.contains(JobStatus.cancelled)) ||
					(indexPath.section == 0 && !types.contains(JobStatus.open) && !types.contains(JobStatus.completed) && types.contains(JobStatus.cancelled)) {
					destinationVC.job = cancelledJobs?[indexPath.row]
				}
			}
		}
	}

	func getJobs() -> [JobStatus] {
		if let jobs = jobs,
			let completedJobs = completedJobs,
			let cancelledJobs = cancelledJobs,
			jobs.count > 0,
			cancelledJobs.count > 0,
			completedJobs.count > 0 {
			return [JobStatus.cancelled, JobStatus.completed, JobStatus.open]
		} else if let jobs = jobs,
			let completedJobs = completedJobs,
			jobs.count > 0,
			completedJobs.count > 0 {
			return [JobStatus.completed, JobStatus.open]
		} else if let jobs = jobs,
			let cancelledJobs = cancelledJobs,
			jobs.count > 0,
			cancelledJobs.count > 0 {
			return [JobStatus.cancelled, JobStatus.open]
		} else if let completedJobs = completedJobs,
			let cancelledJobs = cancelledJobs,
			cancelledJobs.count > 0,
			completedJobs.count > 0 {
			return [JobStatus.cancelled, JobStatus.completed]
		} else if let jobs = jobs,
			jobs.count > 0 {
			return [JobStatus.open]
		} else if let completedJobs = completedJobs,
			completedJobs.count > 0 {
			return [JobStatus.completed]
		} else if let cancelledJobs = cancelledJobs,
			cancelledJobs.count > 0 {
			return [JobStatus.cancelled]
		} else {
			return []
		}
	}
}
