//
//  JobsViewController.swift
//  HireMe
//
//  Created by AJ Bronson on 11/3/16.
//  Copyright © 2016 AJ Bronson. All rights reserved.
//

import UIKit

class JobsViewController: UITableViewController {
	
	//MARK: - TableView Methods
	
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return 6
	}
	
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		guard let cell = tableView.dequeueReusableCell(withIdentifier: "jobCell") else { return UITableViewCell() }
		
		switch indexPath.row {
		case 0:
			cell.textLabel?.text = "Lawn Services"
			cell.detailTextLabel?.text = "Lauren G."
		case 1:
			cell.textLabel?.text = "Tech Support"
			cell.detailTextLabel?.text = "Brady F."
		case 2:
			cell.textLabel?.text = "Troubles with Wifi"
			cell.detailTextLabel?.text = "Tom G."
		case 3:
			cell.textLabel?.text = "HELP ME WITH MY COMPUTERRRRRRRR!!!"
			cell.detailTextLabel?.text = "Rega S."
		case 4:
			cell.textLabel?.text = "Watch my dog"
			cell.detailTextLabel?.text = "Allen D."
		default:
			cell.textLabel?.text = "Put up my Christmas Lights"
			cell.detailTextLabel?.text = "Miranda B."
			
		}
		
		return cell
	}
}
