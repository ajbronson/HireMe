//
//  JobInfoCell.swift
//  HireMe
//
//  Created by AJ Bronson on 1/29/17.
//  Copyright © 2017 AJ Bronson. All rights reserved.
//

import UIKit

class JobInfoCell: UITableViewCell {

	@IBOutlet weak var locationLabel: UILabel!
	@IBOutlet weak var industryLabel: UILabel!
	@IBOutlet weak var timeFrameLabel: UILabel!
	@IBOutlet weak var priceRangeLabel: UILabel!
	@IBOutlet weak var statusLabel: UILabel!
	@IBOutlet weak var viewPhotosButton: UIButton!

	var job: Job?
	var view: UIViewController = UIViewController()

	override func awakeFromNib() {
		super.awakeFromNib()

		viewPhotosButton.layer.cornerRadius = 5.0
		viewPhotosButton.layer.borderColor = UIColor.black.cgColor
		viewPhotosButton.layer.borderWidth = 0.2
	}

	func updateWith(job: Job, view: UIViewController) {
		locationLabel.text = job.locationCity
		industryLabel.text = job.industry

		if let timeStart = job.timeFrameStart,
			let timeEnd = job.timeFrameEnd {
			if timeStart.characters.count > 0 && timeEnd.characters.count > 0 {
				timeFrameLabel.text = "\(timeStart) - \(timeEnd)"
			}
		} else if let timeStart = job.timeFrameStart,
			timeStart.characters.count > 0 {
			timeFrameLabel.text = timeStart
		} else if let timeEnd = job.timeFrameEnd,
			timeEnd.characters.count > 0 {
			timeFrameLabel.text = timeEnd
		} else {
			timeFrameLabel.text = "No Time Frame"
		}

		if let priceStartDouble = job.priceRangeStart,
			let priceEndSDouble = job.priceRangeEnd,
			let priceStart = priceStartDouble.convertToCurrency(includeDollarSign: true),
			let priceEnd = priceEndSDouble.convertToCurrency(includeDollarSign: true) {
			if priceStart == priceEnd {
				priceRangeLabel.text = priceStart
			} else {
				priceRangeLabel.text = "\(priceStart) - \(priceEnd)"
			}
		} else if let priceStartDouble = job.priceRangeStart,
			let priceStart = priceStartDouble.convertToCurrency(includeDollarSign: true) {
			priceRangeLabel.text = priceStart
		}else if let priceEndSDouble = job.priceRangeEnd,
			let priceEnd = priceEndSDouble.convertToCurrency(includeDollarSign: true) {
			priceRangeLabel.text = priceEnd
		}

		statusLabel.text = job.status

		if job.status == JobStatus.cancelled.rawValue {
			statusLabel.textColor = UIColor.red
		} else if job.status == JobStatus.completed.rawValue {
			statusLabel.textColor = AppColors.greenColor
		} else if job.status == JobStatus.open.rawValue {
			statusLabel.textColor = AppColors.yellowColor
		}

		self.job = job
		self.view = view

		if job.images?.count == nil || job.images?.count == 0 {
			viewPhotosButton.backgroundColor = UIColor.lightGray
		} else {
			viewPhotosButton.backgroundColor = AppColors.blueColor
		}
	}

	@IBAction func viewPhotosButtonTapped(_ sender: Any) {
		guard let job = job,
			let images = job.images else { AlertHelper.showAlert(view: view, title: "No Images", message: "The current job doesn't have images yet!", closeButtonText: "Dismiss"); return}
		let storyboard = UIStoryboard(name: "ImageViewStoryboard", bundle: nil)
		if let vc = storyboard.instantiateViewController(withIdentifier: "LargeImageController") as? ViewPhotosViewController {
			vc.showImages(images: images, senderView: view, selfView: vc, selectedIndex: 0)
		}
	}
}
