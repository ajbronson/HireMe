//
//  CategoryViewController.swift
//  HireMe
//
//  Created by AJ Bronson on 11/3/16.
//  Copyright © 2016 AJ Bronson. All rights reserved.
//

import UIKit

class CategoryTableViewController: UITableViewController {
	
	//MARK: - ViewController Lifecycle
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		tabBarController?.tabBar.isHidden = false
	}
	
	//MARK: - TableView Methods
	
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return 6
	}
	
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		guard let cell = tableView.dequeueReusableCell(withIdentifier: "categoryCell") else { return UITableViewCell() }
		
		switch indexPath.row {
		case 0:
			cell.textLabel?.text = "Wifi help"
			cell.detailTextLabel?.text = "$20 - $60"
		case 1:
			cell.textLabel?.text = "Set up my server"
			cell.detailTextLabel?.text = "$260 - $360"
		case 2:
			cell.textLabel?.text = "Mount my TV"
			cell.detailTextLabel?.text = "$50 - $100"
		case 3:
			cell.textLabel?.text = "Computer not booting up"
			cell.detailTextLabel?.text = "$70 - $150"
		case 4:
			cell.textLabel?.text = "Networking issues"
			cell.detailTextLabel?.text = "$10 - $20"
		default:
			cell.textLabel?.text = "Wifi Issues"
			cell.detailTextLabel?.text = "$200 - $600"
			
		}
		
		return cell
	}
}
