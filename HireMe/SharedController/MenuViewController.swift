//
//  MenuViewController.swift
//  HireMe
//
//  Created by Nathan Johnson on 1/20/17.
//  Copyright © 2017 AJ Bronson. All rights reserved.
//

import FBSDKLoginKit

typealias switchModesClosure = () -> Void

class MenuViewController: UITableViewController {
    
    var fbUserProfile: [String: Any]?
    var googleUserProfile: [String: String]?
    private var name: String?
    private var tableViewData = [[String: Any]]()
    private var switchModes = {() -> Void in
        var viewController: UIViewController?
        
        if UIApplication.visibleViewController()?.storyboardName == "ConsumerStoryboard" {
            let storyboard = UIStoryboard(name: "ProviderStoryboard", bundle: nil)
            viewController = storyboard.instantiateViewController(withIdentifier: "ProviderTabBarController") as? UITabBarController
        } else {
            let storyboard = UIStoryboard(name: "ConsumerStoryboard", bundle: nil)
            viewController = storyboard.instantiateViewController(withIdentifier: "RootNavConsumerView") as? UINavigationController
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
    }
    
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "editAccount" {
            if let editAccountNavC = segue.destination as? UINavigationController,
                let accountVC = editAccountNavC.childViewControllers.first as? AccountViewController {
                accountVC.fbUserProfile = self.fbUserProfile
                accountVC.googleUserProfile = self.googleUserProfile
            }
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
        return self.name
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "menuCell", for: indexPath)
        cell.textLabel?.text = self.tableViewDataRow(forIndexPath: indexPath)?["title"] as? String
        
        return cell
    }
    
    
    // MARK: - UITableViewDelegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let row = self.tableViewDataRow(forIndexPath: indexPath) {
            self.dismiss(animated: true, completion: { 
                if let _ = row["segueID"] as? String {
                    NotificationCenter.default.post(name: signInRowNotificationName, object: nil)
                } else if let action = row["action"] as? switchModesClosure {
                    action() // Switch modes
                }
            })
        }
    }
    
    
    // MARK: Custom functions
    
    private func initalizeTableViewData() {
        if isSignedIn() {
            print("MenuViewController initalizeTableViewData() signed in")
        } else {
            self.tableViewData = [
                ["sectionTitle": "", "rows": [["title": "Sign in", "segueID": "presentSignIn"]]],
                ["sectionTitle": "", "rows": [["title": "Switch Modes", "action": self.switchModes]]]
            ]
        }
        
        self.tableView.reloadData()
    }
    
    private func initializeUserProfile() {
        print("Initializing user profile...") // DEBUG
        switch getSignInMethod() {
            case .Facebook:
                print("Facebook token: \(FBSDKAccessToken.current().tokenString)") // DEBUG
                self.resetUserProfiles()
                self.fbUserProfile = UserDefaults.standard.dictionary(forKey: "fbUserProfile")
                print("Facebook profile initialized") // DEBUG
            case .Google:
                self.resetUserProfiles()
                self.googleUserProfile = UserDefaults.standard.dictionary(forKey: "googleUserProfile") as? [String: String]
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
        return self.tableViewData[section]["rows"] as? [[String: Any]]
    }
    
    private func tableViewDataRow(forIndexPath indexPath: IndexPath) -> [String: Any]? {
        guard let rows = self.tableViewDataRows(forSection: indexPath.section) else { return nil }
        print("row title: \(rows[indexPath.row]["title"] as? String)")
        return rows[indexPath.row]
    }
}
