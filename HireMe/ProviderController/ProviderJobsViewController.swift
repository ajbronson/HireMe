//
//  ProviderJobsViewController.swift
//  HireMe
//
//  Created by Nathan Johnson on 3/23/17.
//  Copyright © 2017 AJ Bronson. All rights reserved.
//

import UIKit

class ProviderJobsViewController: UIViewController, UITableViewDataSource {
    
    @IBOutlet weak var noDataLabel: UILabel!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var tableView: UITableView!
    
    private var jobs: [Job]?
    private var completedJobs: [Job]?
    private var cancelledJobs: [Job]?
    private var tableViewData = [[Job]]()
    private var selectedSegmentIndex = 0

    // MARK: - View controller life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.hideEmptyCells()
        
        for _ in 1...segmentedControl.numberOfSegments {
            tableViewData.append([Job]())
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        initializeTableViewData()
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let navController = segue.destination as? UINavigationController,
            let vc = navController.childViewControllers.first as? ProviderJobDetailTableViewController,
            let cell = sender as? UITableViewCell,
            let indexPath = tableView.indexPath(for: cell) {
            vc.job = tableViewData[selectedSegmentIndex][indexPath.row]
            vc.seguedFromMyJobs = true
        }
    }

    // MARK: - UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard tableViewData.count > 0 else { return 0 }
        
        return tableViewData[selectedSegmentIndex].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "jobCell", for: indexPath)
        let job = tableViewData[selectedSegmentIndex][indexPath.row]
        cell.textLabel?.text = job.name
        cell.detailTextLabel?.text = job.industry
        
        return cell
    }
    
    // MARK: - IBActions
    
    @IBAction func segmentedControlValueChanged(_ sender: UISegmentedControl) {
        selectedSegmentIndex = sender.selectedSegmentIndex
        tableView.reloadData()
        setupView()
    }
    
    // MARK: - Private functions
    
    private func initializeTableViewData() {
        let me = BidController.shared.bids[0].bidder
        let myjobs = JobController.shared.jobs.filter{ $0.selectedBid?.bidder == me }
        jobs = myjobs.filter {$0.status == JobStatus.open.rawValue}
        completedJobs = myjobs.filter { $0.status == JobStatus.completed.rawValue }
        cancelledJobs = myjobs.filter { $0.status == JobStatus.cancelled.rawValue }
        
        if let jobs = jobs {
            tableViewData[0] = jobs
        }
        
        if let completedJobs = completedJobs {
            tableViewData[1] = completedJobs
        }
        
        if let cancelledJobs = cancelledJobs {
            tableViewData[2] = cancelledJobs
        }
        
        tableView.reloadData()
        setupView()
    }
    
    private func setupView() {
        if tableViewData[selectedSegmentIndex].count > 0 {
            noDataLabel.isHidden = true
            tableView.isHidden = false
        } else {
            noDataLabel.isHidden = false
            tableView.isHidden = true
        }
    }
}
