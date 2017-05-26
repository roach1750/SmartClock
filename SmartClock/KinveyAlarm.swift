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
    dynamic var weatherCondition = ""
    dynamic var weatherDelayTime = Int()
    dynamic var geolocation: GeoPoint?

    
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
        
        
        //Standard Mapping:
        weatherCondition <- ("weatherCondition", map["weatherCondition"])
        weatherDelayTime <- ("weatherDelayTime", map["weatherDelayTime"])
        geolocation <- ("geolocation", map["geolocation"])
    }
    
}
