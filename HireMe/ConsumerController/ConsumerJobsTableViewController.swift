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

	override func viewDidLoad() {
		jobs = JobController.shared.jobs
	}
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return jobs?.count ?? 0
	}

	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		guard let cell = tableView.dequeueReusableCell(withIdentifier: "jobCell") else { return UITableViewCell() }
		cell.textLabel?.text = JobController.shared.jobs[indexPath.row].name
		return cell
	}

	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if segue.identifier == "toJobView" {
			if let destinationVC = segue.destination as? ViewJobTableViewController,
				let indexPath = tableView.indexPathForSelectedRow,
				let jobs = jobs {
				destinationVC.job = jobs[indexPath.row]
			}
		}
	}
}
