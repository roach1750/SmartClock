//
//  WeatherFetcher.swift
//  SmartClock
//
//  Created by Andrew Roach on 5/18/17.
//  Copyright © 2017 Andrew Roach. All rights reserved.
//

import UIKit
import DarkSkyKit



class WeatherFetcher: NSObject {

    func fetchCurrentWeather() {
        
        let forecastClient = DarkSkyKit(apiToken: "870fe6436b9b0c6a4023e8ca113be3c9")
        
        forecastClient.current(latitude: 38.8845, longitude: -77.0939) { result in
            
            switch result {
            case .success:
                if let current = result.value?.currently {
                    print(current.temperature!)
                    print(current.summary!)
                }
            case .failure(let error):
                print(error)
                break
            }
        }
        
        
        
        
        
    }
    
    
    
    
    
}
