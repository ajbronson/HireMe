//
//  NewBidViewController.swift
//  HireMe
//
//  Created by AJ Bronson on 11/3/16.
//  Copyright © 2016 AJ Bronson. All rights reserved.
//

import UIKit

class NewBidViewController: UIViewController {
	
	//MARK: - Outlets
	
	@IBOutlet weak var priceField: UITextField!
	@IBOutlet weak var descriptionTextView: UITextView!
	
	//MARK: - View Controller Lifecycle
	
	override func viewDidLoad() {
		super.viewDidLoad()
		tabBarController?.tabBar.isHidden = true
	}
	
	//MARK: - Actions
	
	@IBAction func saveButtonTapped(_ sender: UIBarButtonItem) {
		_ = navigationController?.popViewController(animated: true)
	}
	
	@IBAction func cancelButtonTapped(_ sender: UIBarButtonItem) {
		_ = navigationController?.popViewController(animated: true)
	}
	
}
