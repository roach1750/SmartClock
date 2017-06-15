//
//  AppDelegate.swift
//  SmartClock
//
//  Created by Andrew Roach on 5/18/17.
//  Copyright © 2017 Andrew Roach. All rights reserved.
//

import UIKit
import RealmSwift
import UserNotifications
import Kinvey
import AVFoundation

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        print(Realm.Configuration.defaultConfiguration.fileURL!)
        UNUserNotificationCenter.current().delegate = self
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) {(accepted, error) in
            if !accepted {
                print("Notification access denied.")
            }
        }
        application.registerForRemoteNotifications()
        
        Kinvey.sharedClient.initialize(appKey: "kid_BksDalHbZ", appSecret: "e8c76b4b0ba64e5892ff13389306928d") { user, error in
            if let _ = user {
                
            } else {
                
                User.exists(username: "test") { exists, error in
                    if exists {
                        User.login(username: "test", password: "test") { user, error in
                            if let _ = user {
                                //do nothing
                            } else {
                                //do something!
                            }
                        }
                    } else {
                        User.signup(username: "test", password: "test") { user, error in
                            if let _ = user {
                                //do nothing
                            } else {
                                //do something!
                            }
                        }
                    }
                }
            }
        }

        
        Kinvey.sharedClient.ping() { (result: Result<EnvironmentInfo, Swift.Error>) in
            switch result {
            case .success(let envInfo):
                print(envInfo)
            //succeed
            case .failure(let error):
                print(error)
                //failed
            }
        }
        
        Kinvey.sharedClient.push.registerForNotifications() { succeed, error in
            print("succeed: \(succeed)")
            if let error = error {
                print("error: \(error)")
            }
        }
        
        UIApplication.shared.applicationIconBadgeNumber = 0

        registerAndPlaySound(volume: 0.0)
        player?.stop()
        
        return true
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        print("did enter background")
        
        var task =  UIBackgroundTaskInvalid
        task = application.beginBackgroundTask(withName: "time for music") {
            application.endBackgroundTask(task)
        }
        print("Alarm should go off at: \(Date() + 300)")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 300) {
            self.registerAndPlaySound(volume: 0.50)
        }
        

        
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }
    
    var player: AVAudioPlayer?

    func registerAndPlaySound(volume: Float) {

        AudioServicesPlayAlertSound(kSystemSoundID_Vibrate)
        print("regsiter and play sound called")
        
//        let filename = "rain"
//        let ext = "aiff"
//
//        if let soundUrl = Bundle.main.url(forResource: filename, withExtension: ext) {
//            var soundId: SystemSoundID = 0
//            
//            AudioServicesCreateSystemSoundID(soundUrl as CFURL, &soundId)
//            
//            AudioServicesAddSystemSoundCompletion(soundId, nil, nil, { (soundId, clientData) -> Void in
//                AudioServicesDisposeSystemSoundID(soundId)
//            }, nil)
//            
//            AudioServicesPlaySystemSound(soundId)

//        }
        
        guard let url = Bundle.main.url(forResource: "rain", withExtension: "aiff") else {
            print("error")
            return
        }
        
        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback)
            try AVAudioSession.sharedInstance().setActive(true)
            
            player = try AVAudioPlayer(contentsOf: url)
            guard let player = player else { return }
            player.volume = Float(volume)
            player.numberOfLoops = -1
            player.play()
        } catch let error {
            print(error.localizedDescription)
        }
        
        
        
    }
    
    
    
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        var token: String = ""
        for i in 0..<deviceToken.count {
            token += String(format: "%02.2hhx", deviceToken[i] as CVarArg)
        }
        print("DEVICE TOKEN = \(token)")
    }
    

    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        print("Received remote notificiation")
        
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
        
        
        let currentTime = Date()
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: currentTime)
        let minute = calendar.component(.minute, from: currentTime)
        
        var dateComponents = DateComponents()
        dateComponents.hour = hour
        dateComponents.minute = minute + 1
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
        
        let content = UNMutableNotificationContent()
        content.title = "Smart Clock"
        content.body = "Time to wake up"
//        content.sound = UNNotificationSound(named: String)
        let request = UNNotificationRequest(identifier: "alarmNotification", content: content, trigger: trigger)
        
        
        UNUserNotificationCenter.current().add(request) {(error) in
            if let error = error {
                print("Uh oh! We had an error: \(error)")
            }
        }
    
        completionHandler(.noData)
    }
    

    
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }



    func applicationWillEnterForeground(_ application: UIApplication) {
        print("applicationWillEnterForeground")
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        print("applicationDidBecomeActive")
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        print("applicationWillTerminate")
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    

    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        print("didReceive")
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        print("willpresent")
    }
    
    
        

}

