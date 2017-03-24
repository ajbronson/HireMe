//
//  ProviderJobsViewController.swift
//  HireMe
//
//  Created by Nathan Johnson on 3/23/17.
//  Copyright © 2017 AJ Bronson. All rights reserved.
//

import UIKit

class ProviderJobsViewController: UIViewController, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!

    // MARK: - View controller life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.hideEmptyCells()
    }

    // MARK: - UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    // MARK: - IBActions
    
    @IBAction func segmentedControlValueChanged(_ sender: UISegmentedControl) {
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
