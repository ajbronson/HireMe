//
//  SearchViewController.swift
//  HireMe
//
//  Created by AJ Bronson on 11/3/16.
//  Copyright © 2016 AJ Bronson. All rights reserved.
//

import UIKit

class SearchViewController: UITableViewController {
	
	//MARK: - TableView Methods
	
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return 6
	}
	
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		guard let cell = tableView.dequeueReusableCell(withIdentifier: "searchCell") else { return UITableViewCell() }
		
		switch indexPath.row {
		case 0:
			cell.textLabel?.text = "Automotive"
		case 1:
			cell.textLabel?.text = "House Cleaning"
		case 2:
			cell.textLabel?.text = "Babysitting"
		case 3:
			cell.textLabel?.text = "Tech Support"
		case 4:
			cell.textLabel?.text = "Remodeling"
		default:
			cell.textLabel?.text = "Yard work"
			
		}
		
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
