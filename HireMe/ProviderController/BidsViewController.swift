//
//  BidsViewController.swift
//  HireMe
//
//  Created by AJ Bronson on 11/3/16.
//  Copyright © 2016 AJ Bronson. All rights reserved.
//

import UIKit

class BidsViewController: UITableViewController {
    
    // MARK: - View controller life cycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.navigationItem.title = "My Bids"
    }
    
	
	// MARK: - UITableViewDataSource methods
	
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return 6
	}
	
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		guard let cell = tableView.dequeueReusableCell(withIdentifier: "bidCell") else { return UITableViewCell() }
		
		switch indexPath.row {
		case 0:
			cell.textLabel?.text = "Setup server environment"
			cell.detailTextLabel?.text = "$350"
		case 1:
			cell.textLabel?.text = "Plant trees/bushes"
			cell.detailTextLabel?.text = "$200"
		case 2:
			cell.textLabel?.text = "Watch my dog"
			cell.detailTextLabel?.text = "$10"
		case 3:
			cell.textLabel?.text = "Fix my printer"
			cell.detailTextLabel?.text = "$20"
		case 4:
			cell.textLabel?.text = "Wifi Issues"
			cell.detailTextLabel?.text = "$40"
		default:
			cell.textLabel?.text = "Mow My Lawn"
			cell.detailTextLabel?.text = "$50"
			
		}
		
		return cell
	}
}
