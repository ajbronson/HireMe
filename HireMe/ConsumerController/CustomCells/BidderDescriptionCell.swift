//
//  BidderDescriptionCell.swift
//  HireMe
//
//  Created by AJ Bronson on 1/29/17.
//  Copyright © 2017 AJ Bronson. All rights reserved.
//

import UIKit

class BidderDescriptionCell: UITableViewCell {

	@IBOutlet weak var descriptionTextView: UITextView!

	func updateWith(description: String) {
		descriptionTextView.text = description

		let fixedWidth = descriptionTextView.frame.size.width
		descriptionTextView.sizeThatFits(CGSize(width: fixedWidth, height: CGFloat.greatestFiniteMagnitude))
		let newSize = descriptionTextView.sizeThatFits(CGSize(width: fixedWidth, height: CGFloat.greatestFiniteMagnitude))
		var newFrame = descriptionTextView.frame
		newFrame.size = CGSize(width: max(newSize.width, fixedWidth), height: newSize.height)
		descriptionTextView.frame = newFrame;
	}
}
