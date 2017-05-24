//
//  AlarmsTVC.swift
//  SmartClock
//
//  Created by Andrew Roach on 5/18/17.
//  Copyright © 2017 Andrew Roach. All rights reserved.
//

import UIKit

class AlarmsTVC: UITableViewController {

    
    var alarms: [Alarm]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewWillAppear(_ animated: Bool) {
        reloadTable()
    }

    func reloadTable() {
        let RI = RealmInteractor()
        alarms = RI.fetchAllAlarms()
        tableView.reloadData()
    }
    
    @IBAction func doneButtonPressed(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }

    // MARK: - Table view data source


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return (alarms?.count)!
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "alarmCell", for: indexPath)
        if let alarm = alarms?[indexPath.row] {
            let formatter = DateFormatter()
            formatter.dateFormat = "H:mm a"
            let date = Date(timeIntervalSince1970: (alarm.alarmTime.timeIntervalSince1970))
            cell.textLabel?.text = formatter.string(from: date)
            cell.detailTextLabel?.text = "Waking up " + String(describing: alarm.weatherDelayTime) + " minutes early if " + (alarm.weatherCondition)
        }
        

        
        
        return cell
    }

   
}
