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
        
        let timeFrame = job.timeFrame(dateFormat: "EEE MMM d")
        timeFrameLabel.text = timeFrame == "" ? "No time frame" : timeFrame
        priceRangeLabel.text = job.priceRange()
		statusLabel.text = job.status.rawValue
        
        var color: UIColor
        
        switch job.status {
        case .open: color = AppColors.yellowColor
        case .completed: color = AppColors.greenColor
        case .cancelled: color = UIColor.red
        case .pending: color = AppColors.blueColor
            // TODO: implement awarded
        default: color = UIColor.black
        }
        
        statusLabel.textColor = color
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
