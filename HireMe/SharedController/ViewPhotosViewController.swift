//
//  ViewPhotosViewController.swift
//  HireMe
//
//  Created by AJ Bronson on 1/30/17.
//  Copyright © 2017 AJ Bronson. All rights reserved.
//

import UIKit

class ViewPhotosViewController: UIViewController {

	@IBOutlet weak var closeButton: UIButton!
	@IBOutlet weak var previousButton: UIButton!
	@IBOutlet weak var nextButton: UIButton!
	@IBOutlet weak var displayingImageView: UIImageView!
	@IBOutlet weak var backgroundView: UIView!
	@IBOutlet weak var displayingLabel: UILabel!

	var images: [UIImage]?
	var displaying: Int = 0

	override func viewDidLoad() {
		super.viewDidLoad()

		displaying = 0

		previousButton.layer.cornerRadius = 5.0
		previousButton.layer.borderColor = UIColor.black.cgColor
		previousButton.layer.borderWidth = 0.2

		nextButton.layer.cornerRadius = 5.0
		nextButton.layer.borderColor = UIColor.black.cgColor
		nextButton.layer.borderWidth = 0.2

		closeButton.layer.cornerRadius = 5.0
		closeButton.layer.borderColor = UIColor.black.cgColor
		closeButton.layer.borderWidth = 0.2

		backgroundView.layer.cornerRadius = 5.0

		updateDisplayLabel()

		if let images = images,
			images.count > 0 {
			displayingImageView.image = images[0]
			displayingImageView.roundCornersForAspectFit(radius: 10.0)
		}
	}

	func updateDisplayLabel() {
		displayingLabel.text = "\(displaying) of \(images?.count)"
	}

	@IBAction func previousButtonTapped(_ sender: UIButton) {
		guard let images = images else { return }
		if displaying > 0 {
			displaying -= 1
			displayingImageView.image = images[displaying]
			displayingImageView.roundCornersForAspectFit(radius: 10.0)
			updateDisplayLabel()
		}
	}
	
	@IBAction func nextButtonTapped(_ sender: UIButton) {
		guard let images = images else { return }
		if displaying < images.count {
			displaying += 1
			displayingImageView.image = images[displaying]
			displayingImageView.roundCornersForAspectFit(radius: 10.0)
			updateDisplayLabel()
		}
	}
}
