//
//  AddAlarmsVC.swift
//  SmartClock
//
//  Created by Andrew Roach on 5/18/17.
//  Copyright © 2017 Andrew Roach. All rights reserved.
//

import UIKit

class CreateAlarmVC: UIViewController {

    @IBOutlet weak var timePicker: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func createAlarmButtonPressed(_ sender: UIButton) {
        createAlarm()
        navigationController?.popViewController(animated: true)
    
    }


    func createAlarm() {
        let newAlarm = Alarm()
        newAlarm.alarmTime = timePicker.date as NSDate
        newAlarm.enabled = true
        newAlarm.id = Int(Date().timeIntervalSince1970)
    }

}
