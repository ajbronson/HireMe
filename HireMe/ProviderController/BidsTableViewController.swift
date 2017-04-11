//
//  BidsViewController.swift
//  HireMe
//
//  Created by AJ Bronson on 11/3/16.
//  Copyright © 2016 AJ Bronson. All rights reserved.
//

import UIKit

class BidsTableViewController: UITableViewController {
	
    // MARK: - View controller life cycle
	var bids: [Bid]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.hideEmptyCells()
		self.bids = BidController.shared.bids
    }
    
    
	// MARK: - UITableViewDataSource
	
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return bids?.count ?? 0
	}
	
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		guard let bids = bids,
			let cell = tableView.dequeueReusableCell(withIdentifier: "bidCell") else { return UITableViewCell() }

		cell.textLabel?.text = bids[indexPath.row].job.name
		if let price = bids[indexPath.row].price?.convertToCurrency() {
			cell.detailTextLabel?.text = "\(String(describing: price))"
		}
		
		return cell
	}

	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if let navController = segue.destination as? UINavigationController,
			let vc = navController.childViewControllers.first as? ProviderJobDetailTableViewController,
			let indexPath = tableView.indexPathForSelectedRow,
			let bids = bids {
			vc.job = bids[indexPath.row].job
			vc.bid = bids[indexPath.row]
		}
	}
}
