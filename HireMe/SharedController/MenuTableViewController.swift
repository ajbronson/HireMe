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
let TITLE_KEY = "title"
let SEGUE_ID_KEY = "segueID"
let ACTION_KEY = "action"
let PROVIDER_INITIAL_VC_ID = "ProviderTabBarController"
let CONSUMER_INITIAL_VC_ID = "RootNavConsumerView"
let SECTION_TITLE_KEY = "sectionTitle"

class MenuTableViewController: UITableViewController {
    
    var fbUserProfile: [String: Any]?
    var googleUserProfile: [String: String]?
    private var name: String?
    private var tableViewData = [[String: Any]]()
    private var switchModes = {() -> Void in
        var viewController: UIViewController?
        
        if UIApplication.visibleViewController()?.storyboardName == "ConsumerStoryboard" {
            let storyboard = UIStoryboard(name: "ProviderStoryboard", bundle: nil)
            viewController = storyboard.instantiateViewController(withIdentifier: PROVIDER_INITIAL_VC_ID) as? UITabBarController
        } else {
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
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let indexPath = self.tableView.indexPathForSelectedRow {
            self.tableView.deselectRow(at: indexPath, animated: true)
        }
        
        self.initializeUserProfile()
        
        if let fbUser = self.fbUserProfile {
            self.name = fbUser["name"] as? String
        } else if let googleUser = self.googleUserProfile {
            self.name = googleUser["fullName"]
        }
        
        self.tableViewData[0][SECTION_TITLE_KEY] = self.name
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
                [SECTION_TITLE_KEY: "", ROWS_KEY: [[TITLE_KEY: "Switch Modes", "action": self.switchModes]]]
            ]
        } else {
            self.tableViewData = [
                [SECTION_TITLE_KEY: "", ROWS_KEY: [[TITLE_KEY: "Sign In", SEGUE_ID_KEY: "presentSignIn"]]],
                [SECTION_TITLE_KEY: "", ROWS_KEY: [[TITLE_KEY: "Switch Modes", ACTION_KEY: self.switchModes]]]
            ]
        }
        
        self.tableView.reloadData()
    }
    
    private func initializeUserProfile() {
        print("Initializing user profile...") // DEBUG
        switch SignInHelper.getSignInMethod() {
            case .Facebook:
                print("Facebook token: \(FBSDKAccessToken.current().tokenString)") // DEBUG
                self.resetUserProfiles()
                self.fbUserProfile = UserDefaults.standard.dictionary(forKey: FB_PROFILE_KEY)
                print("Facebook profile initialized") // DEBUG
            case .Google:
                self.resetUserProfiles()
                self.googleUserProfile = UserDefaults.standard.dictionary(forKey: GOOGLE_PROFILE_KEY) as? [String: String]
                print("Google profile initialized") // DEBUG
            case .ThisApp:
                print("LimitedHire profile initialized") // DEBUG
                self.resetUserProfiles()
            default:
                print("Not signed in") // DEBUG
                break
        }
    }
    
    private func resetUserProfiles() {
        self.fbUserProfile = nil
        self.googleUserProfile = nil
    }
    
    private func tableViewDataRows(forSection section: Int) -> [[String: Any]]? {
        return self.tableViewData[section][ROWS_KEY] as? [[String: Any]]
    }
    
    private func tableViewDataRow(forIndexPath indexPath: IndexPath) -> [String: Any]? {
        guard let rows = self.tableViewDataRows(forSection: indexPath.section) else { return nil }

        return rows[indexPath.row]
    }
}
