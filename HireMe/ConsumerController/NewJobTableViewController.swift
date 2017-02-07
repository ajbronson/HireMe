//
//  NewJobTableViewController.swift
//  HireMe
//
//  Created by AJ Bronson on 1/24/17.
//  Copyright © 2017 AJ Bronson. All rights reserved.
//

import UIKit

class NewJobTableViewController: UITableViewController {

	@IBAction func saveButtonTapped(_ sender: UIBarButtonItem) {
	}

	@IBAction func cancelButtonTapped(_ sender: UIBarButtonItem) {
		_ = navigationController?.popViewController(animated: true)
	}
}
