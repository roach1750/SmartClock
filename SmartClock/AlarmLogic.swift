//
//  AlarmLogic.swift
//  SmartClock
//
//  Created by Andrew Roach on 5/23/17.
//  Copyright © 2017 Andrew Roach. All rights reserved.
//

import UIKit
import UserNotifications

class AlarmLogic: NSObject {

    func scheduleAlarm(alarm: Alarm) {
        
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
        let trigger = UNCalendarNotificationTrigger.init(dateMatching: getDateComponents(for: alarm.alarmTime as Date), repeats: false)
        
        let content = UNMutableNotificationContent()
        content.title = "Smart Clock"
        content.body = "Time to wake up"
        content.sound = UNNotificationSound.default()
        
        let request = UNNotificationRequest(identifier: "alarmNotification", content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request) {(error) in
            if let error = error {
                print("Uh oh! We had an error: \(error)")
            }
        }
        
        
        
    }
    
    func getDateComponents(for date: Date) -> DateComponents {
        let calendar = Calendar(identifier: .gregorian)
        let components = calendar.dateComponents(in: .current, from: date)
        return DateComponents(calendar: calendar, timeZone: .current, month: components.month, day: components.day, hour: components.hour, minute: components.minute)
    }
    
    
}
