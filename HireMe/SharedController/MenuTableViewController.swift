//
//  MenuViewController.swift
//  HireMe
//
//  Created by Nathan Johnson on 1/20/17.
//  Copyright © 2017 AJ Bronson. All rights reserved.
//

import FBSDKLoginKit

typealias switchModesClosure = () -> Void

// MARK: - Constants

let ROWS_KEY = "rows"
fileprivate let TITLE_KEY = "title"
let SEGUE_ID_KEY = "segueID"
let ACTION_KEY = "action"
let PROVIDER_INITIAL_VC_ID = "ProviderTabBarController"
let CONSUMER_INITIAL_VC_ID = "RootNavConsumerView"
let SECTION_TITLE_KEY = "sectionTitle"
let SECTION_FOOTER_TEXT_CONSUMER_KEY = "sectionFooterTextConsumer"
let SECTION_FOOTER_TEXT_PROVIDER_KEY = "sectionFooterTextProvider"

class MenuTableViewController: UITableViewController {
    private enum UserMode {
        case consumer
        case provider
    }
    
    private var presentingVC: UIViewController? // This controller's presenting view controller
    private var tableViewData = [[String: Any]]()
    private lazy var switchModes: () -> Void = {
        guard let userMode = self.userMode() else { return }
        
        var viewController: UIViewController?
        
        switch (userMode) {
            case .consumer:
                let storyboard = UIStoryboard(name: "ProviderStoryboard", bundle: nil)
                viewController = storyboard.instantiateViewController(withIdentifier: PROVIDER_INITIAL_VC_ID) as? UITabBarController
            case .provider:
                let storyboard = UIStoryboard(name: "ConsumerStoryboard", bundle: nil)
                viewController = storyboard.instantiateViewController(withIdentifier: CONSUMER_INITIAL_VC_ID) as? UINavigationController
        }
        
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        appDelegate?.window?.rootViewController = viewController
    }
    
    
    // MARK: - View controller life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.hideEmptyCells()
        
        self.initalizeTableViewData()
        
        // self.presentingViewController returns nil in self.switchModes, so it's saved to a variable here to be accessible in self.switchModes
        self.presentingVC = self.presentingViewController
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let indexPath = self.tableView.indexPathForSelectedRow {
            self.tableView.deselectRow(at: indexPath, animated: true)
        }
        
        if SignInHelper.isSignedIn(),
            let profile = SignInHelper.userProfile(),
            let fullName = profile["fullName"] {
            self.tableViewData[0][SECTION_TITLE_KEY] = fullName
        }
    }
    
    
    // MARK: - UITableViewDataSource
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return self.tableViewData.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let rows = self.tableViewDataRows(forSection: section) {
            return rows.count
        }
        
        return 0
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return self.tableViewData[section][SECTION_TITLE_KEY] as? String
    }
    
    override func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        guard let userMode = self.userMode() else { return nil }
        
        switch (userMode) {
        case .consumer: return self.tableViewData[section][SECTION_FOOTER_TEXT_CONSUMER_KEY] as? String
        case .provider: return self.tableViewData[section][SECTION_FOOTER_TEXT_PROVIDER_KEY] as? String
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "menuCell", for: indexPath)
        cell.textLabel?.text = self.tableViewDataRow(forIndexPath: indexPath)?[TITLE_KEY] as? String
        
        return cell
    }
    
    
    // MARK: - UITableViewDelegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let row = self.tableViewDataRow(forIndexPath: indexPath) {
            self.dismiss(animated: true, completion: {
                if let segueID = row[SEGUE_ID_KEY] as? String {
                    guard let appDelegate = UIApplication.shared.delegate as? AppDelegate,
                        let rootVC = appDelegate.window?.rootViewController else {
                        return
                    }
                    
                    if let tab = rootVC as? ProviderTabBarController {
                        tab.performSegue(withIdentifier: segueID, sender: nil)
                    } else if let nav = rootVC as? UINavigationController,
                        let consumerJobsVC = nav.visibleViewController as? ConsumerJobTableViewController {
                        consumerJobsVC.performSegue(withIdentifier: segueID, sender: nil)
                    }
                } else if let action = row[ACTION_KEY] as? switchModesClosure {
                    action() // Switch modes
                }
            })
        }
    }
    
    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let headerView = view as! UITableViewHeaderFooterView
        
        /*
         Setting the text in this function as well as in tableView(_:titleForHeaderInSection:) will make the text
         not be in all caps. The text must match in both functions for it to work though.
         */
        headerView.textLabel?.text = self.tableViewData[section][SECTION_TITLE_KEY] as? String
        headerView.textLabel?.font = UIFont.systemFont(ofSize: 17.0)
    }
    
    
    // MARK: - Custom functions
    
    private func initalizeTableViewData() {
        // NOTE: segueID must be the same in both the consumer and provider storyboards
        
        if SignInHelper.isSignedIn() {
            self.tableViewData = [
                [SECTION_TITLE_KEY: "",
                 ROWS_KEY: [
                    [TITLE_KEY: "Edit account", SEGUE_ID_KEY: "presentAccount"],
                    [TITLE_KEY: "Settings", SEGUE_ID_KEY: "presentSettings"]
                    ]],
                self.switchModesSection()
            ]
        } else {
            self.tableViewData = [
                [SECTION_TITLE_KEY: "", ROWS_KEY: [[TITLE_KEY: "Sign in", SEGUE_ID_KEY: "presentSignIn"]]],
                self.switchModesSection()
            ]
        }
        
        self.tableView.reloadData()
    }
    
    private func switchModesSection() -> [String: Any] {
        return [
            SECTION_TITLE_KEY: "",
            SECTION_FOOTER_TEXT_PROVIDER_KEY: "Post jobs that you want others to complete.", // text to show when in provider mode
            SECTION_FOOTER_TEXT_CONSUMER_KEY: "Search for and make bids on jobs you want to complete", // text to show when in consumer mode
            ROWS_KEY: [[TITLE_KEY: "Switch Modes", "action": self.switchModes]]
        ]
    }
    
    private func tableViewDataRows(forSection section: Int) -> [[String: Any]]? {
        return self.tableViewData[section][ROWS_KEY] as? [[String: Any]]
    }
    
    private func tableViewDataRow(forIndexPath indexPath: IndexPath) -> [String: Any]? {
        guard let rows = self.tableViewDataRows(forSection: indexPath.section) else { return nil }

        return rows[indexPath.row]
    }
    
    private func userMode() -> UserMode? {
        guard let vc = self.presentingVC else { return nil }
        
        return vc.storyboardName == "ConsumerStoryboard" ? .consumer : .provider
    }
}
