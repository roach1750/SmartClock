//
//  KinveyInteractor.swift
//  SmartClock
//
//  Created by Andrew Roach on 5/25/17.
//  Copyright © 2017 Andrew Roach. All rights reserved.
//

import UIKit
import Kinvey
class KinveyInteractor: NSObject {

    
    func uploadAlarm(alarm: KinveyAlarm) {
        let dataStore = DataStore<KinveyAlarm>.collection()
        dataStore.save(alarm) { alarm, error in
            if let alarm = alarm {
                //succeed
                print("Uploaded alarm: \(alarm)")
            } else {
                //fail
            }
        }
        
        dataStore.sync() { (count, books, error) -> Void in
            if let books = books, let count = count {
                //succeed
                print("\(count) Books: \(books)")
            } else {
                print(error)
                //fail
            }
        }
    
    }
    
    func findAllAlarms() {
        let dataStore = DataStore<KinveyAlarm>.collection()
        dataStore.find() { alarms, error in
            if let alarms = alarms {
                //succeed
                print("alarms: \(alarms)")
            } else {
                //fail
            }
        }
    }
}
