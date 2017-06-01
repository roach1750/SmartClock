//
//  KinveyAlarm.swift
//  SmartClock
//
//  Created by Andrew Roach on 5/25/17.
//  Copyright © 2017 Andrew Roach. All rights reserved.
//

import Kinvey

class KinveyAlarm: Entity {

    dynamic var alarmTime = Date()
    dynamic var alarmTimeMinutes = Int()
    dynamic var alarmTimeHours = Int()
    dynamic var weatherCondition = ""
    dynamic var weatherDelayTime = Date()
    dynamic var weatherDelayTimeMinutes = Int()
    dynamic var location: GeoPoint?
    
    
    

    override class func collectionName() -> String {
        //return the name of the backend collection corresponding to this entity
        return "KinveyAlarm"
    }
    
    //Map properties in your backend collection to the members of this entity
    override func propertyMapping(_ map: Map) {
        //This maps the "_id", "_kmd" and "_acl" properties
        super.propertyMapping(map)
        //Speical Date Mapping
        alarmTime <- ("alarmTime", map["alarmTime"], KinveyDateTransform())
        weatherDelayTime <- ("weatherDelayTime", map["weatherDelayTime"], KinveyDateTransform())

        //Standard Mapping:
        weatherCondition <- ("weatherCondition", map["weatherCondition"])
        weatherDelayTimeMinutes <- ("weatherDelayTimeMinutes", map["weatherDelayTimeMinutes"])

        location <- ("location", map["location"])
        alarmTimeMinutes <- ("alarmTimeMinutes", map["alarmTimeMinutes"])
        alarmTimeHours <- ("alarmTimeHours", map["alarmTimeHours"])
    }
    
}
