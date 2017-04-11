//
//  NewBidViewController.swift
//  HireMe
//
//  Created by AJ Bronson on 11/3/16.
//  Copyright © 2016 AJ Bronson. All rights reserved.
//

import UIKit

class NewBidViewController: UIViewController, UITextViewDelegate, UITextFieldDelegate {
	
	//MARK: - Outlets
	
	@IBOutlet weak var priceField: UITextField!
	@IBOutlet weak var descriptionTextView: UITextView!

	//MARK: - Properties

	var bid: Bid?
	var job: Job?
	static let defaultBorderColor = UIColor(colorLiteralRed: 199/255.0, green: 199/255.0, blue: 205/255.0, alpha: 0.8)

	//MARK: - View Controller Lifecycle
	
	override func viewDidLoad() {
		super.viewDidLoad()
		tabBarController?.tabBar.isHidden = true
		descriptionTextView.layer.borderWidth = 1;
		descriptionTextView.layer.cornerRadius = 5;

		descriptionTextView.layer.borderColor = NewBidViewController.defaultBorderColor.cgColor
		descriptionTextView.textColor = NewBidViewController.defaultBorderColor
		descriptionTextView.delegate = self
		priceField.delegate = self
	}

	override func viewWillAppear(_ animated: Bool) {
		guard let _ = job else { _ = navigationController?.popViewController(animated: true); return }
		if let bid = bid {
			if let price = bid.price?.convertToCurrency() {
				priceField.text = "\(String(describing: price))"
			}
			descriptionTextView.text = bid.description
			descriptionTextView.textColor = .black
		}
	}

	func textViewDidBeginEditing(_ textView: UITextView) {
		if textView.text.compare(" Explain The Reasoning Behind Your Price") == .orderedSame {
			textView.text = ""
			textView.textColor = .black
		}
	}

	func textViewDidEndEditing(_ textView: UITextView) {
		if textView.text.compare("") == .orderedSame {
			textView.text = " Explain The Reasoning Behind Your Price"
			textView.textColor = NewBidViewController.defaultBorderColor
		}
	}

	func updateWtihBid(bid: Bid?, job: Job) {
		self.bid = bid
		self.job = job
	}

	func textFieldDidBeginEditing(_ textField: UITextField) {
		if let text = textField.text,
			text.characters.count > 0,
			let price = text.toDouble(from: .currency) {
			textField.text = String(format: "%.2f", price) // round to nearest int
		}
	}

	func textFieldDidEndEditing(_ textField: UITextField) {
		if let text = textField.text,
			text.characters.count > 0 {
			let price = Double(text)
			textField.text = price?.convertToCurrency()
		}
	}

	//MARK: - Actions
	
	@IBAction func saveButtonTapped(_ sender: UIBarButtonItem) {
		guard let job = job,
			let priceText = priceField.text,
			let price = Double(priceText) else { AlertHelper.showAlert(view: self, title: "Error", message: "There was an error retrieving a job. Force Quit the app and try again.", closeButtonText: "OK"); return }
		if let bid = bid {
			BidController.shared.updateBid(bid: bid, price: price, description: descriptionTextView.text)
		} else {
			BidController.shared.createBid(job: job, price: price, description: descriptionTextView.text)
		}

		_ = navigationController?.popViewController(animated: true)
	}
	
	@IBAction func cancelButtonTapped(_ sender: UIBarButtonItem) {
		_ = navigationController?.popViewController(animated: true)
	}
}
