//
//  AccountViewController.swift
//  HireMe
//
//  Created by AJ Bronson on 11/3/16.
//  Copyright © 2016 AJ Bronson. All rights reserved.
//

import UIKit

class AccountViewController: UITableViewController {
	
	//MARK: - ViewController Lifecycle
	
	override func viewDidLoad() {
		super.viewDidLoad()
		tableView.separatorStyle = .none
	}
	
	//MARK: - TableView Methods
	
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return 5
	}
	
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		guard let cell = tableView.dequeueReusableCell(withIdentifier: "accountCell") else { return UITableViewCell() }
		
		switch indexPath.row {
		case 0:
			cell.textLabel?.text = "Name: Jerry Mack"
		case 1:
			cell.textLabel?.text = "Skills: Tech, dogs, yard"
		case 2:
			cell.textLabel?.text = "Number: 888-888-8888"
		case 3:
			cell.textLabel?.text = "Email: jmack@gmail.com"
		default:
			cell.textLabel?.text = "Change Password"
			
		}
		
		return cell
	}
}
