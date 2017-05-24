//
//  Alarm.swift
//  SmartClock
//
//  Created by Andrew Roach on 5/18/17.
//  Copyright © 2017 Andrew Roach. All rights reserved.
//

import UIKit
import RealmSwift


class Alarm: Object {
    
    dynamic var alarmTime = NSDate()
    dynamic var weatherCheckTime = NSDate()
    dynamic var weatherCondition = ""
    dynamic var weatherDelayTime = Int()
    dynamic var enabled = true
    dynamic var id = 0
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
}
