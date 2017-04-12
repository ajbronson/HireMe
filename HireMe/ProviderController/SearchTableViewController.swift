//
//  SearchViewController.swift
//  HireMe
//
//  Created by AJ Bronson on 11/3/16.
//  Copyright © 2016 AJ Bronson. All rights reserved.
//

import UIKit

class SearchTableViewController: UITableViewController {
    
    // MARK: - View controller life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.hideEmptyCells()
		navigationController?.navigationBar.tintColor = UIColor.white
    }
    
    // MARK: - UITableViewDataSource methods
	
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return AppInfo.industries.count
	}
	
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		guard let cell = tableView.dequeueReusableCell(withIdentifier: "searchCell") else { return UITableViewCell() }
		cell.textLabel?.text = AppInfo.industries[indexPath.row]
		return cell
	}
    
	// MARK: - Navigation
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if segue.identifier == "toCategory" {
			if let destinationVC = segue.destination as? CategoryTableViewController,
				let indexPath = tableView.indexPathForSelectedRow,
				let cell = tableView.cellForRow(at: indexPath) {
				destinationVC.title = cell.textLabel?.text
				destinationVC.industry = AppInfo.industries[indexPath.row]
			}
		}
	}
}
