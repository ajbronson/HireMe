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

    // MARK: - UITableViewDataSource

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableViewData.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let reuseID = tableViewData[indexPath.row][REUSE_ID_KEY] else { return UITableViewCell() }
        
        if reuseID == PERSON_REUSE_ID {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: reuseID, for: indexPath) as? JobAdvertiserTableViewCell else { return UITableViewCell() }
            cell.nameLabel.text = job.advertiser.fullName
            cell.ratingsLabel.text = "(\(job.advertiser.numberOfRatings))"
            cell.personImageView.image = job.advertiser.image ?? UIImage(named: "Person")
            
            // Turns image view into a circle
            cell.personImageView.layer.cornerRadius = cell.personImageView.frame.size.width / 2
            cell.personImageView.clipsToBounds = true
            
            return cell
        } else {
//            let cell = tableView.dequeueReusableCell(withIdentifier: reuseID, for: indexPath) as? JobAdvertiserTableViewCell
            return UITableViewCell()
        }
    }
    
    // MARK: - Private functions
    
    private func initializeTableViewData() {
        tableViewData = [
            [REUSE_ID_KEY: PERSON_REUSE_ID],
            [TITLE_KEY: "What I Need Done", INFO_KEY: job.name, REUSE_ID_KEY: INFO_REUSE_ID]
        ]
    }
}
