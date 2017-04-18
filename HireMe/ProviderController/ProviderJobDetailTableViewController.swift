//
//  ProviderJobDetailTableViewController.swift
//  HireMe
//
//  Created by Nathan Johnson on 3/18/17.
//  Copyright © 2017 AJ Bronson. All rights reserved.
//

import UIKit

//MARK: - Static Properties

fileprivate let NAME_KEY = "name"
fileprivate let TITLE_KEY = "title"
fileprivate let INFO_KEY = "info"
fileprivate let REUSE_ID_KEY = "reuseID"
fileprivate let INFO_REUSE_ID = "infoCell"
fileprivate let PERSON_REUSE_ID = "personCell"

class ProviderJobDetailTableViewController: UITableViewController {

	//MARK: - Outlets

	@IBOutlet weak var bidButton: UIBarButtonItem!

	//MARK: - Properties

	var job: Job!
	var bid: Bid?
	var enableBidButton = true
	var seguedFromMyJobs = false
	private var tableViewData = [[String: String]]()

    // MARK: - View controller life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.hideEmptyCells()
        tableView.estimatedRowHeight = 65
        tableView.rowHeight = UITableViewAutomaticDimension
        initializeTableViewData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setToolbarHidden(false, animated: false)
		if let _ = bid {
			bidButton.title = "View My Bid"
		} else {
			bidButton.title = "Place A Bid"
		}
		bidButton.isEnabled = enableBidButton
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setToolbarHidden(true, animated: false)
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "presentPhotos" {
            guard let images = job.images, let vc = segue.destination as? ViewPhotosViewController else { return }
            vc.images = images
		} else if segue.identifier == "toBid" {
			guard let destination = segue.destination as? NewBidViewController else { return }
			destination.updateWtihBid(bid: bid, job: job)
		}
    }

    // MARK: - UITableViewDataSource

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableViewData.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellInfo = tableViewData[indexPath.row]
        guard let reuseID = cellInfo[REUSE_ID_KEY] else { return UITableViewCell() }
        
        if reuseID == PERSON_REUSE_ID {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: reuseID, for: indexPath) as? JobAdvertiserTableViewCell else { return UITableViewCell() }
            cell.nameLabel.text = job.advertiser.fullName
            
            if job.advertiser.numberOfRatings > 0 {
                cell.ratingsLabel.text = "(\(job.advertiser.numberOfRatings))"
                
                let stars = [cell.starImageView1, cell.starImageView2, cell.starImageView3, cell.starImageView4, cell.starImageView5]
                RatingStarsHelper.show(job.advertiser.numberOfStars, stars: stars)
            } else {
                cell.starsStackView.isHidden = true
                cell.ratingsLabel.isHidden = true
                cell.noRatingsLabel.isHidden = false
            }
            
            cell.personImageView.image = job.advertiser.image ?? UIImage(named: "Person")
            
            // Turns image view into a circle
            cell.personImageView.layer.cornerRadius = cell.personImageView.frame.size.width / 2
            cell.personImageView.clipsToBounds = true
            
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: reuseID, for: indexPath) as? ProviderJobInfoItemTableViewCell else { return UITableViewCell() }
            cell.titleLabel.text = cellInfo[TITLE_KEY]
            cell.infoLabel.text = cellInfo[INFO_KEY]
            
            return cell
        }
    }
    
    // MARK: - IBActions
    
    @IBAction func didTapDone(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func didTapPlaceBid(_ sender: UIBarButtonItem) {
        let segueID = AuthenticationManager.shared.isSignedIn ? "toBid" : "presentSignIn"
        performSegue(withIdentifier: segueID, sender: nil)
    }

	@IBAction func viewPhotosTapped(_ sender: UIBarButtonItem) {
		guard job.images != nil else {
			AlertHelper.showAlert(view: self, title: "No Images", message: nil, closeButtonText: "OK")
			return
		}

		self.performSegue(withIdentifier: "presentPhotos", sender: nil)
	}

    // MARK: - Private functions
    
    private func initializeTableViewData() {
        var priceTitle: String
        var price: String
        
        if seguedFromMyJobs {
            priceTitle = "Bid Price"
            price = job.selectedBid?.price?.convertToCurrency() ?? ""
        } else {
            priceTitle = "Expected Price"
            price = job.priceRange()
        }
        
        tableViewData = [
            [REUSE_ID_KEY: PERSON_REUSE_ID],
            [TITLE_KEY: "Title", INFO_KEY: job.name, REUSE_ID_KEY: INFO_REUSE_ID],
            [TITLE_KEY: "Industry", INFO_KEY: job.industry ?? "", REUSE_ID_KEY: INFO_REUSE_ID],
            [TITLE_KEY: "Where", INFO_KEY: job.cityStateZip(), REUSE_ID_KEY: INFO_REUSE_ID],
            [TITLE_KEY: "When", INFO_KEY: job.timeFrame(dateFormat: "EEE MMM d"), REUSE_ID_KEY: INFO_REUSE_ID],
            [TITLE_KEY: priceTitle, INFO_KEY: price, REUSE_ID_KEY: INFO_REUSE_ID],
            [TITLE_KEY: "Description", INFO_KEY: job.description ?? "", REUSE_ID_KEY: INFO_REUSE_ID],
        ]
    }
}
