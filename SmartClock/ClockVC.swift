//
//  ClockVCViewController.swift
//  
//
//  Created by Andrew Roach on 5/18/17.
//
//

import UIKit
import UserNotifications
import AVFoundation
class ClockVC: UIViewController, UNUserNotificationCenterDelegate {

    @IBOutlet weak var timeLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(ClockVC.updateTimeLabel), userInfo: nil, repeats: true)
//        let wf = WeatherFetcher()
//        wf.fetchCurrentWeather()
    }
    
    @IBAction func TestButtonPressed(_ sender: UIButton) {
        scheduleAlarmForOneMinuteFromNow()
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        print("Presenting Notification!")
    }
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        print("didReceive")
    }
    
    func scheduleAlarmForOneMinuteFromNow(){
        
        
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
        
        
//        let currentTime = Date()
//        let calendar = Calendar.current
//        let hour = calendar.component(.hour, from: currentTime)
//        let minute = calendar.component(.minute, from: currentTime)
//        let second = calendar.component(.second, from: currentTime)
//
//        
//        var dateComponents = DateComponents()
//        dateComponents.hour = hour
//        dateComponents.minute = minute
//        dateComponents.second = second + 3
//        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
        
        let date = Date(timeIntervalSinceNow: 5)
        
        let triggerDate = Calendar.current.dateComponents([.year,.month,.day,.hour,.minute,.second,], from: date)
        let trigger = UNCalendarNotificationTrigger(dateMatching: triggerDate,
                                                    repeats: true)
        
        
        let content = UNMutableNotificationContent()
        content.title = "Notification Title"
        content.body = "Notificaiton body"
        content.sound = UNNotificationSound(named: "rain.aiff")

        
        let identifier = "UYLLocalNotification"
        let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)
        let center = UNUserNotificationCenter.current()
        center.delegate = self
        center.add(request, withCompletionHandler: { (error) in
            if let error = error {
                print(error)
            }
            else {
                print("scheduled notification: \(request.trigger.debugDescription)")
            }
        })

    }

    
    var player: AVAudioPlayer?
    
    @IBAction func playSound(_ sender: UIButton) {
        guard let url = Bundle.main.url(forResource: "rain", withExtension: "aiff") else {
            print("error")
            return
        }
        
        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback)
            try AVAudioSession.sharedInstance().setActive(true)
            
            player = try AVAudioPlayer(contentsOf: url)
            guard let player = player else { return }
            player.volume = 0.27
            player.numberOfLoops = -1
            player.play()
        } catch let error {
            print(error.localizedDescription)
        }
        
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
