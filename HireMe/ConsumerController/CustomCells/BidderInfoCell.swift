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

	func updateWith(bid: Bid, bidder: Bidder) {
		nameLabel.text = bid.user

		if let price = bid.price {
			priceLabel.text = price.convertToCurrency(includeDollarSign: true)
		}

		if let image = UIImage(named: bid.status) {
			statusIndicator.image = image
		}

		for i in 1...5 {
			switch i {
			case 1:
				starImage1.image = bidder.numberOfStars > 0 ? UIImage(named: "Star") : UIImage(named: "BlankStar")
			case 2:
				starImage2.image = bidder.numberOfStars > 1 ? UIImage(named: "Star") : UIImage(named: "BlankStar")
			case 3:
				starImage3.image = bidder.numberOfStars > 2 ? UIImage(named: "Star") : UIImage(named: "BlankStar")
			case 4:
				starImage4.image = bidder.numberOfStars > 3 ? UIImage(named: "Star") : UIImage(named: "BlankStar")
			case 5:
				starImage5.image = bidder.numberOfStars > 4 ? UIImage(named: "Star") : UIImage(named: "BlankStar")
			default:
				break
			}
		}
	}
}
