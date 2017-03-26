//
//  CategoryViewController.swift
//  HireMe
//
//  Created by AJ Bronson on 11/3/16.
//  Copyright © 2016 AJ Bronson. All rights reserved.
//

import UIKit

class CategoryTableViewController: UITableViewController {
	
	//MARK: - View controller life cycle
	
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.hideEmptyCells()
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let navController = segue.destination as? UINavigationController,
            let vc = navController.childViewControllers.first as? ProviderJobDetailTableViewController,
            let cell = sender as? UITableViewCell,
            let indexPath = tableView.indexPath(for: cell) {
            vc.job = JobController.shared.jobs[indexPath.row]
        }
    }
	
	//MARK: - UITableViewDataSource
	
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return JobController.shared.jobs.count
	}
	
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		guard let cell = tableView.dequeueReusableCell(withIdentifier: "categoryCell") as? SearchJobTableViewCell else { return UITableViewCell() }
		let job = JobController.shared.jobs[indexPath.row]
        cell.nameLabel.text = job.name
        cell.cityLabel.text = job.cityState()
        cell.priceRangeLabel.text = job.priceRange()
        cell.timeFrameLabel.text = job.timeFrame(dateFormat: "MMM d")
		
		return cell
	}
}
