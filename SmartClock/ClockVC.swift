//
//  ClockVCViewController.swift
//  
//
//  Created by Andrew Roach on 5/18/17.
//
//

import UIKit

class ClockVC: UIViewController {

    @IBOutlet weak var timeLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(ClockVC.updateTimeLabel), userInfo: nil, repeats: true)
//        let wf = WeatherFetcher()
//        wf.fetchCurrentWeather()
        
    }
    
    
    func updateTimeLabel(){
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = .short
        timeLabel.text = String(dateFormatter.string(from: Date()))
    }
    
    
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    

}
