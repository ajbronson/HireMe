//
//  BidderImageCell.swift
//  HireMe
//
//  Created by AJ Bronson on 1/29/17.
//  Copyright © 2017 AJ Bronson. All rights reserved.
//

import UIKit

class BidderImageCell: UITableViewCell {

	@IBOutlet weak var priceLabel: UILabel!
	@IBOutlet weak var bidderImageView: UIImageView!
	@IBOutlet weak var starImage1: UIImageView!
	@IBOutlet weak var starImage2: UIImageView!
	@IBOutlet weak var starImage3: UIImageView!
	@IBOutlet weak var starImage4: UIImageView!
	@IBOutlet weak var starImage5: UIImageView!
	@IBOutlet weak var declineButton: UIButton!
	@IBOutlet weak var acceptButton: UIButton!

	func updateWith(bid: Bid, bidder: Bidder) {

		acceptButton.layer.cornerRadius = 5.0
		acceptButton.layer.borderColor = UIColor.black.cgColor
		acceptButton.layer.borderWidth = 0.2

		declineButton.layer.cornerRadius = 5.0
		declineButton.layer.borderColor = UIColor.black.cgColor
		declineButton.layer.borderWidth = 0.2

		bidderImageView.roundCornersForAspectFit(radius: 10.0)

		if let price = bid.price {
			priceLabel.text = price.convertToCurrency()
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
	
	@IBAction func declineButtonTapped(_ sender: UIButton) {
	}
	@IBAction func acceptButtonTapped(_ sender: UIButton) {
	}
}
