//
//  ConsumerJobsTableViewController.swift
//  HireMe
//
//  Created by AJ Bronson on 1/24/17.
//  Copyright © 2017 AJ Bronson. All rights reserved.
//

import UIKit

class ConsumerJobTableViewController: UITableViewController {

	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return 5
	}

	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		guard let cell = tableView.dequeueReusableCell(withIdentifier: "jobCell") else { return UITableViewCell() }
		cell.textLabel?.text = "Test"
		return cell
	}
}
