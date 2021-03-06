//
//  RealmInteractor.swift
//  SmartClock
//
//  Created by Andrew Roach on 5/18/17.
//  Copyright © 2017 Andrew Roach. All rights reserved.
//

import UIKit
import RealmSwift
class RealmInteractor: NSObject {

    
    func saveAlarm(alarm: Alarm) {
        let realm = try! Realm()
        do {
            try! realm.write {
                realm.create(Alarm.self, value: alarm, update: true)
            }
        }
    }
    
    func fetchAllAlarms() -> [Alarm]? {
        let realm = try! Realm()
        let results = Array(realm.objects(Alarm.self))
        return results
    }
    
    func deleteAlarm(alarm: Alarm) {
        let realm = try! Realm()
        do {
            try! realm.write {
                realm.delete(alarm)
            }
        }
    }
}
