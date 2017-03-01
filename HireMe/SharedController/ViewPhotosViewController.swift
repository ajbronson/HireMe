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

	var images: [UIImage] = []
	var displaying: Int = 1

	override func viewDidLoad() {
		super.viewDidLoad()

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

		if images.count == 1 {
			nextButton.isEnabled = false
			nextButton.backgroundColor = UIColor.lightGray
			previousButton.isEnabled = false
			previousButton.backgroundColor = UIColor.lightGray
		} else {
			checkToDisableButton()
		}

		updateDisplayLabel()

		if images.count > 0 {
			displayingImageView.image = images[displaying - 1]
			displayingImageView.roundCornersForAspectFit(radius: 10.0)
		}
	}

	func showImages(images: [UIImage], senderView: UIViewController, selfView: ViewPhotosViewController, selectedIndex: Int) {
		self.images = images
		displaying = selectedIndex + 1
		selfView.modalPresentationStyle = .overCurrentContext
		senderView.present(selfView, animated: true, completion: nil)
	}

	func updateDisplayLabel() {
		displayingLabel.text = "\(displaying) of \(images.count)"
	}

	func checkToDisableButton() {
		if displaying == images.count {
			nextButton.isEnabled = false
			nextButton.backgroundColor = UIColor.lightGray
		} else {
			nextButton.isEnabled = true
			nextButton.backgroundColor = AppColors.blueColor
		}

		if displaying == 1 {
			previousButton.isEnabled = false
			previousButton.backgroundColor = UIColor.lightGray
		} else {
			previousButton.isEnabled = true
			previousButton.backgroundColor = AppColors.blueColor
		}
	}

	@IBAction func previousButtonTapped(_ sender: UIButton) {
		if displaying > 1 {
			displaying -= 1
			displayingImageView.image = images[displaying - 1]
			displayingImageView.roundCornersForAspectFit(radius: 10.0)
			updateDisplayLabel()
			checkToDisableButton()
		}
	}
	
	@IBAction func nextButtonTapped(_ sender: UIButton) {
		if displaying < images.count {
			displaying += 1
			displayingImageView.image = images[displaying - 1]
			displayingImageView.roundCornersForAspectFit(radius: 10.0)
			updateDisplayLabel()
			checkToDisableButton()
		}
	}

	@IBAction func closeButtonTapped(_ sender: UIButton) {
		dismiss(animated: true, completion: nil)
	}
}
