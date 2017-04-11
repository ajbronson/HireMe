//
//  JobImageCell.swift
//  HireMe
//
//  Created by AJ Bronson on 2/7/17.
//  Copyright © 2017 AJ Bronson. All rights reserved.
//

import UIKit

class JobImageCell: UICollectionViewCell {

	//MARK: - Outlets

	@IBOutlet weak var jobImage: UIImageView!

	//MARK: - Helper Functions
	
	func updateWith(image: UIImage) {
		jobImage.image = image
		jobImage.roundCornersForAspectFit(radius: 5.0)
	}
}
