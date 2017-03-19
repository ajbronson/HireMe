//
//  BidderInfoCell.swift
//  HireMe
//
//  Created by AJ Bronson on 1/29/17.
//  Copyright © 2017 AJ Bronson. All rights reserved.
//

import UIKit

class BidderInfoCell: UITableViewCell {

	@IBOutlet weak var statusIndicator: UIImageView!
	@IBOutlet weak var nameLabel: UILabel!
	@IBOutlet weak var priceLabel: UILabel!
	@IBOutlet weak var starImage1: UIImageView!
	@IBOutlet weak var starImage2: UIImageView!
	@IBOutlet weak var starImage3: UIImageView!
	@IBOutlet weak var starImage4: UIImageView!
	@IBOutlet weak var starImage5: UIImageView!

	func updateWith(bid: Bid) {
		nameLabel.text = "\(bid.bidder.firstName) \(bid.bidder.lastName)"

		if let price = bid.price {
			priceLabel.text = price.convertToCurrency(includeDollarSign: true)
		}

		if let image = UIImage(named: bid.status) {
			statusIndicator.image = image
		}
		
        let stars = [starImage1, starImage2, starImage3, starImage4, starImage5]
        RatingStarsHelper.show(bid.bidder.numberOfStars, stars: stars)
	}
}
