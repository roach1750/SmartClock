//
//  LocationFetcher.swift
//  SmartClock
//
//  Created by Andrew Roach on 5/30/17.
//  Copyright © 2017 Andrew Roach. All rights reserved.
//

import UIKit
import CoreLocation

class LocationFetcher: NSObject, CLLocationManagerDelegate {

    
    var locationManager: CLLocationManager = CLLocationManager()

    func setUpLocationManager() {
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let currentLocation = locations.last
        print(currentLocation?.coordinate as Any)
        locationManager.stopUpdatingLocation()
    }
    
}
