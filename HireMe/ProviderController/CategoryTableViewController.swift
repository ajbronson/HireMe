//
//  CategoryViewController.swift
//  HireMe
//
//  Created by AJ Bronson on 11/3/16.
//  Copyright © 2016 AJ Bronson. All rights reserved.
//

import UIKit

class CategoryTableViewController: UITableViewController {
    
    // Intended to convert a string with the specified date format into a date
    private static let dateFormatterFrom: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM d, yyyy"
        return formatter
    }()
    
    // Intended to convert a date to a string with the specified date format
    private static let dateFormatterTo: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM d"
        return formatter
    }()
	
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
    
    @IBAction func unwindToCategory(segue: UIStoryboardSegue) {}
	
	//MARK: - UITableViewDataSource
	
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return JobController.shared.jobs.count
	}
	
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		guard let cell = tableView.dequeueReusableCell(withIdentifier: "categoryCell") as? SearchJobTableViewCell else { return UITableViewCell() }
		let job = JobController.shared.jobs[indexPath.row]
        cell.nameLabel.text = job.name
        cell.cityLabel.text = job.locationCity
        
        if let priceRangeStart = job.priceRangeStart?.convertToCurrency(),
            let priceRangeEnd = job.priceRangeEnd?.convertToCurrency() {
            cell.priceRangeLabel.text = "\(priceRangeStart) - \(priceRangeEnd)"
        }
        
        if let timeFrameStart = job.timeFrameStart, let timeFrameEnd = job.timeFrameEnd,
            let timeFrameStartDate = CategoryTableViewController.dateFormatterFrom.date(from: timeFrameStart),
            let timeFrameEndDate = CategoryTableViewController.dateFormatterFrom.date(from: timeFrameEnd) {
            
            let formattedTimeFrameStart = CategoryTableViewController.dateFormatterTo.string(from: timeFrameStartDate)
            let formattedTimeFrameEnd = CategoryTableViewController.dateFormatterTo.string(from: timeFrameEndDate)
            cell.timeFrameLabel.text = "\(formattedTimeFrameStart) - \(formattedTimeFrameEnd)"
        }
		
		return cell
	}
}
