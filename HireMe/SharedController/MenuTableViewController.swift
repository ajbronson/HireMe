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
    
    // MARK: - Outlets
    
    @IBOutlet weak var tableHeaderImageView: UIImageView!
    @IBOutlet weak var tableHeaderNameLabel: UILabel!
    
    // MARK: - Properties
    
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
        tableView.hideEmptyCells()
        tableHeaderImageView.layer.cornerRadius = tableHeaderImageView.frame.height / 2 // make image a circle
        
        initalizeTableViewData()
        
        // self.presentingViewController returns nil in self.switchModes, so it's saved to a variable here to be accessible in self.switchModes
        presentingVC = presentingViewController
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let indexPath = self.tableView.indexPathForSelectedRow {
            tableView.deselectRow(at: indexPath, animated: true)
        }
        
        // TODO: get user info
//        if AuthenticationManager.shared.isSignedIn {
//            let user = UserController.shared.user
//            
//            tableHeaderNameLabel.text = user.fullName
//            
//            if let urlStr = user.imageURL, let url = URL(string: urlStr) {
//                DispatchQueue.global().async {
//                    if let data = try? Data(contentsOf: url) {
//                        DispatchQueue.main.async {
//                            self.tableHeaderImageView.image = UIImage(data: data)
//                        }
//                    }
//                }
//            }
//        }
    }
    
    
    // MARK: - UITableViewDataSource
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return tableViewData.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let rows = tableViewDataRows(forSection: section) {
            return rows.count
        }
        
        return 0
    }
    
    override func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        guard let userMode = userMode() else { return nil }
        
        switch (userMode) {
			case .consumer: return tableViewData[section][SECTION_FOOTER_TEXT_CONSUMER_KEY] as? String
			case .provider: return tableViewData[section][SECTION_FOOTER_TEXT_PROVIDER_KEY] as? String
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "menuCell", for: indexPath)
        cell.textLabel?.text = tableViewDataRow(forIndexPath: indexPath)?[TITLE_KEY] as? String
        
        return cell
    }
    
    
    // MARK: - UITableViewDelegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let row = tableViewDataRow(forIndexPath: indexPath) {
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
    
    // MARK: - Custom functions
    
    private func initalizeTableViewData() {
        // NOTE: segueID must be the same in both the consumer and provider storyboards
        
        if AuthenticationManager.shared.isSignedIn {
            self.tableViewData = [
                [SECTION_TITLE_KEY: "",
                 ROWS_KEY: [
                    [TITLE_KEY: "Edit account", SEGUE_ID_KEY: "presentAccount"],
                    [TITLE_KEY: "Settings", SEGUE_ID_KEY: "presentSettings"]
                    ]],
                switchModesSection()
            ]
        } else {
            self.tableViewData = [
                [SECTION_TITLE_KEY: "", ROWS_KEY: [[TITLE_KEY: "Sign in", SEGUE_ID_KEY: "presentSignIn"]]],
                switchModesSection()
            ]
        }
        
        tableView.reloadData()
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
        return tableViewData[section][ROWS_KEY] as? [[String: Any]]
    }
    
    private func tableViewDataRow(forIndexPath indexPath: IndexPath) -> [String: Any]? {
        guard let rows = tableViewDataRows(forSection: indexPath.section) else { return nil }

        return rows[indexPath.row]
    }
    
    private func userMode() -> UserMode? {
        guard let vc = presentingVC else { return nil }
        
        return vc.storyboardName == "ConsumerStoryboard" ? .consumer : .provider
    }
}
