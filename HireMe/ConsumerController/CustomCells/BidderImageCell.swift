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
	@IBOutlet weak var statusLabel: UILabel!

	var view: UIViewController = UIViewController()
	var bid: Bid?

	func updateWith(bid: Bid, bidder: Bidder, job: Job, view: UIViewController) {

		self.view = view
		self.bid = bid

		updateStatus(bid: bid)

		acceptButton.layer.cornerRadius = 5.0
		acceptButton.layer.borderColor = UIColor.black.cgColor
		acceptButton.layer.borderWidth = 0.2

		declineButton.layer.cornerRadius = 5.0
		declineButton.layer.borderColor = UIColor.black.cgColor
		declineButton.layer.borderWidth = 0.2

		bidderImageView.roundCornersForAspectFit(radius: 10.0)

		if let price = bid.price {
			priceLabel.text = price.convertToCurrency(includeDollarSign: true)
		}

		let stars = [starImage1, starImage2, starImage3, starImage4, starImage5]
        RatingStarsHelper.show(bidder.numberOfStars, stars: stars)

		if job.status == JobStatus.cancelled.rawValue || job.status == JobStatus.completed.rawValue {
			acceptButton.isEnabled = false
			acceptButton.backgroundColor = UIColor.lightGray
			declineButton.isEnabled = false
			declineButton.backgroundColor = UIColor.lightGray
			priceLabel.textColor = UIColor.lightGray
			statusLabel.text = "Job \(job.status)"
			statusLabel.textColor = UIColor.lightGray
		}
	}

	func updateStatus(bid: Bid) {
		if bid.status == BidStatus.PendingResponse.rawValue {
			statusLabel.text = "Pending Response"
		} else if bid.status == BidStatus.Rejected.rawValue {
			statusLabel.text = "Rejected"
			statusLabel.textColor = UIColor.red
			priceLabel.textColor = UIColor.lightGray
			acceptButton.isEnabled = false
			acceptButton.backgroundColor = UIColor.lightGray
			declineButton.isEnabled = false
			declineButton.backgroundColor = UIColor.lightGray
		} else if bid.status == BidStatus.Selected.rawValue {
			statusLabel.text = "Selected"
			statusLabel.textColor = AppColors.greenColor
			acceptButton.isEnabled = false
			acceptButton.backgroundColor = UIColor.lightGray
			declineButton.isEnabled = false
			declineButton.backgroundColor = UIColor.lightGray
		}
	}
	
	@IBAction func declineButtonTapped(_ sender: UIButton) {
		let alert = UIAlertController(title: "Confirmation Required", message: "Are you sure you want to decline this bid? \n\nThe bidder will be sent a notification that this bid was declined.", preferredStyle: .alert)
		let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
		let okAction = UIAlertAction(title: "Yes, Decline", style: .destructive) { (action) in
			if let bid = self.bid {
				bid.status = BidStatus.Rejected.rawValue
				self.updateStatus(bid: bid)
			}
		}
		alert.addAction(cancelAction)
		alert.addAction(okAction)
		view.present(alert, animated: true, completion: nil)
	}

	@IBAction func acceptButtonTapped(_ sender: UIButton) {
		let alert = UIAlertController(title: "Confirmation Required", message: "Are you sure you want to accept this bid? \n\nThe bidder will be sent a notification that this bid has been accepted.", preferredStyle: .alert)
		let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
		let okAction = UIAlertAction(title: "Yes, Accept", style: .default) { (action) in
			if let bid = self.bid {
				bid.status = BidStatus.Selected.rawValue
				self.updateStatus(bid: bid)
				//TODO: Reject all other bids?
			}
		}
		alert.addAction(cancelAction)
		alert.addAction(okAction)
		view.present(alert, animated: true, completion: nil)
	}
}
