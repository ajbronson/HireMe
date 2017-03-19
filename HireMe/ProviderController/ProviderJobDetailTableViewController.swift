//
//  ProviderJobDetailTableViewController.swift
//  HireMe
//
//  Created by Nathan Johnson on 3/18/17.
//  Copyright © 2017 AJ Bronson. All rights reserved.
//

import UIKit

fileprivate let NAME_KEY = "name"
fileprivate let TITLE_KEY = "title"
fileprivate let INFO_KEY = "info"
fileprivate let REUSE_ID_KEY = "reuseID"
fileprivate let INFO_REUSE_ID = "infoCell"
fileprivate let PERSON_REUSE_ID = "personCell"

class ProviderJobDetailTableViewController: UITableViewController {
    var job: Job!
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
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setToolbarHidden(true, animated: false)
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "presentPhotos" {
            guard let images = job.images else {
                return
            }
            
            if let vc = segue.destination as? ViewPhotosViewController {
                vc.images = images
            }
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
            cell.ratingsLabel.text = "(\(job.advertiser.numberOfRatings))"
            
            let stars = [cell.starImageView1, cell.starImageView2, cell.starImageView3, cell.starImageView4, cell.starImageView5]
            RatingStarsHelper.show(job.advertiser.numberOfStars, stars: stars)
            
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
    
    @IBAction func didTapViewPhotos(_ sender: UIBarButtonItem) {
        guard job.images != nil else {
            AlertHelper.showAlert(view: self, title: "No Images", message: nil, closeButtonText: "OK")
            return
        }
        
        self.performSegue(withIdentifier: "presentPhotos", sender: nil)
    }
    
    
    // MARK: - Private functions
    
    private func initializeTableViewData() {
        var location = ""
        
        if let city = job.locationCity {
            location += city
        }
        
        if let state = job.locationState {
            if location.characters.count > 0 {
                location += ", "
            }
            
            location += state
        }
        
        if let zip = job.locationZip {
            location += " " + zip
        }
        
        var timeFrame = ""
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEE MMM d"
        
        if let start = job.timeFrameStart?.dateFromString() {
            timeFrame += dateFormatter.string(from: start)
        }
        
        if let end = job.timeFrameEnd?.dateFromString() {
            timeFrame += " - " + dateFormatter.string(from: end)
        }
        
        var priceRange = ""
        
        if let startingPrice = job.priceRangeStart?.convertToCurrency() {
            priceRange += startingPrice
        }
        
        if let endingPrice = job.priceRangeEnd?.convertToCurrency() {
            priceRange += " - " + endingPrice
        }
        
        tableViewData = [
            [REUSE_ID_KEY: PERSON_REUSE_ID],
            [TITLE_KEY: "What I Need Done", INFO_KEY: job.name, REUSE_ID_KEY: INFO_REUSE_ID],
            [TITLE_KEY: "Industry", INFO_KEY: job.industry ?? "", REUSE_ID_KEY: INFO_REUSE_ID],
            [TITLE_KEY: "Where", INFO_KEY: location, REUSE_ID_KEY: INFO_REUSE_ID],
            [TITLE_KEY: "When", INFO_KEY: timeFrame, REUSE_ID_KEY: INFO_REUSE_ID],
            [TITLE_KEY: "Expected Price", INFO_KEY: priceRange, REUSE_ID_KEY: INFO_REUSE_ID],
            [TITLE_KEY: "Description", INFO_KEY: job.description ?? "", REUSE_ID_KEY: INFO_REUSE_ID],
        ]
    }
}
