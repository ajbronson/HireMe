//
//  SearchViewController.swift
//  HireMe
//
//  Created by AJ Bronson on 11/3/16.
//  Copyright © 2016 AJ Bronson. All rights reserved.
//

import UIKit

class SearchViewController: UITableViewController {    
    
    // MARK: - UITableViewDataSource methods
	
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return AppInfo.industries.count
	}
	
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		guard let cell = tableView.dequeueReusableCell(withIdentifier: "searchCell") else { return UITableViewCell() }
		cell.textLabel?.text = AppInfo.industries[indexPath.row]
		return cell
	}
	
	//MARK: - Segue
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if segue.identifier == "toCategory" {
			if let destinationVC = segue.destination as? CategoryViewController,
				let indexPath = tableView.indexPathForSelectedRow,
				let cell = tableView.cellForRow(at: indexPath) {
				destinationVC.title = cell.textLabel?.text
			}
		}
	}
}
