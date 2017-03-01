//
//  JobImageCell.swift
//  HireMe
//
//  Created by AJ Bronson on 2/7/17.
//  Copyright © 2017 AJ Bronson. All rights reserved.
//

import UIKit

class JobImageCell: UICollectionViewCell {

	@IBOutlet weak var jobImage: UIImageView!

	func updateWith(image: UIImage) {
		jobImage.image = image
		jobImage.roundCornersForAspectFit(radius: 5.0)
	}
}
