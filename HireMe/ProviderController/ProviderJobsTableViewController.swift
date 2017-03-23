//
//  JobsViewController.swift
//  HireMe
//
//  Created by AJ Bronson on 11/3/16.
//  Copyright © 2016 AJ Bronson. All rights reserved.
//

import UIKit

class ProviderJobsTableViewController: UITableViewController {
    
    fileprivate let DETAIL_TEXT_KEY = "detailText"
    fileprivate let JOB_KEY = "job"
    
    var jobs: [Job]?
    var completedJobs: [Job]?
    var cancelledJobs: [Job]?
    
    private var tableViewData = [[String: Any]]()
    
    // MARK: - View controller life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.hideEmptyCells()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let me = BidController.shared.bids[0].bidder
        let myjobs = JobController.shared.jobs.filter{ $0.selectedBid?.bidder == me }
        jobs = myjobs.filter {$0.status == JobStatus.open.rawValue}
        completedJobs = myjobs.filter { $0.status == JobStatus.completed.rawValue }
        cancelledJobs = myjobs.filter { $0.status == JobStatus.cancelled.rawValue }
        initializeTableViewData()
        tableView.reloadData()
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let navController = segue.destination as? UINavigationController,
            let vc = navController.childViewControllers.first as? ProviderJobDetailTableViewController,
            let cell = sender as? UITableViewCell,
            let indexPath = tableView.indexPath(for: cell),
            let job = job(atIndexPath: indexPath) {
            vc.job = job
        }
    }
    
    // MARK: - UITableViewDataSource
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return tableViewData.count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return tableViewData[section][SECTION_TITLE_KEY] as? String
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let rows = tableViewData[section][ROWS_KEY] as? [[String: Any]] else { return 0 }
        
        return rows.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "jobCell"),
            let job = job(atIndexPath: indexPath) else {
                return UITableViewCell()
        }
        
        cell.textLabel?.text = job.name
        cell.detailTextLabel?.text = job.industry
        
        return cell
    }
    
    
    // MARK: - Private functions
    
    private func initializeTableViewData() {
        if let jobs = jobs {
            addTableViewDataSection(title: "Current Jobs", with: jobs)
        }
        
        if let completedJobs = completedJobs {
            addTableViewDataSection(title: "Completed Jobs", with: completedJobs)
        }
        
        if let cancelledJobs = cancelledJobs {
            addTableViewDataSection(title: "Cancelled Jobs", with: cancelledJobs)
        }
    }
    
    private func addTableViewDataSection(title: String, with jobs: [Job]) {
        var section = tableViewDataSection(title: title)
        
        
        if var rows = section[ROWS_KEY] as? [[String: Any]] {
            for job in jobs {
                rows.append(tableViewDataRow(for: job))
            }
            
            section[ROWS_KEY] = rows
            
            if rows.count > 0 {
                tableViewData.append(section)
            }
        }
    }
    
    private func tableViewDataSection(title: String) -> [String: Any] {
        return [
            SECTION_TITLE_KEY: title,
            ROWS_KEY: [[String: Any]]()
        ]
    }
    
    private func tableViewDataRow(for job: Job) -> [String: Any] {
        return [JOB_KEY: job]
    }
    
    private func job(atIndexPath indexPath: IndexPath) -> Job? {
        guard let rows = tableViewData[indexPath.section][ROWS_KEY] as? [[String: Any]],
            let job = rows[indexPath.row][JOB_KEY] as? Job else { return nil }
        
        return job
    }
    
}
