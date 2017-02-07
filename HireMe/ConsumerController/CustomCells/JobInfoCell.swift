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

	override func awakeFromNib() {
		super.awakeFromNib()

		viewPhotosButton.layer.cornerRadius = 5.0
		viewPhotosButton.layer.borderColor = UIColor.black.cgColor
		viewPhotosButton.layer.borderWidth = 0.2
	}

	func updateWith(job: Job) {
		locationLabel.text = job.locationCity
		industryLabel.text = job.industry
		timeFrameLabel.text = job.timeFrameStart
		priceRangeLabel.text = "\(job.priceRangeStart)"
	}

	@IBAction func viewPhotosButtonTapped(_ sender: Any) {
		
	}
}
