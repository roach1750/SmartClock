//
//  AlarmsTVC.swift
//  SmartClock
//
//  Created by Andrew Roach on 5/18/17.
//  Copyright © 2017 Andrew Roach. All rights reserved.
//

import UIKit

class AlarmsTVC: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()


    }


    @IBAction func doneButtonPressed(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }

    // MARK: - Table view data source


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "alarmCell", for: indexPath)
        
        return cell
    }

   
}
