//
//  AddAlarmsVC.swift
//  SmartClock
//
//  Created by Andrew Roach on 5/18/17.
//  Copyright © 2017 Andrew Roach. All rights reserved.
//

import UIKit
import CoreLocation
import FRHyperLabel
import Kinvey

class CreateAlarmVC: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate, CLLocationManagerDelegate {

    @IBOutlet weak var timePicker: UIDatePicker!

    @IBOutlet weak var conditionsLabel: FRHyperLabel!
    @IBOutlet weak var alarmAdjustmentLabel: FRHyperLabel!
    
    var weatherConditionsTextField: UITextField?
    var timeDelaysTextField: UITextField?

    var weatherConditions = ["Rain", "Cloudy", "Snowy"]
    var timeDelays = ["5 Minutes", "10 Minutes", "15 Minutes", "20 Minutes"]
    
    let locationFetcher = LocationFetcher()
    
    override func viewDidLoad() {
        
        setUpWeatherConditionsPickerView()
        setUpTimeDelayPickerView()
        setUpConditionsLabel(condition: weatherConditions[0])
        setUpAlarmAdjustmentLabel(timeDelay: timeDelays[0])
        locationFetcher.setUpLocationManager()
        super.viewDidLoad()
    }
    

    
    func setUpWeatherConditionsPickerView() {
        let pickerView = UIPickerView()
        pickerView.showsSelectionIndicator = true
        pickerView.delegate = self
        pickerView.dataSource = self
        
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.plain, target: self, action: #selector(CreateAlarmVC.doneButtonPressed))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
        toolBar.setItems([spaceButton, doneButton], animated: false)
        
        pickerView.tag = 1
        weatherConditionsTextField = UITextField(frame: CGRect.zero)
        weatherConditionsTextField!.inputView = pickerView
        weatherConditionsTextField!.inputAccessoryView = toolBar
        view.addSubview(weatherConditionsTextField!)
    }
    
    func setUpTimeDelayPickerView() {
        let pickerView = UIPickerView()
        pickerView.showsSelectionIndicator = true
        pickerView.delegate = self
        pickerView.dataSource = self
        
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.plain, target: self, action: #selector(CreateAlarmVC.doneButtonPressed))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
        toolBar.setItems([spaceButton, doneButton], animated: false)
        
        pickerView.tag = 2
        timeDelaysTextField = UITextField(frame: CGRect.zero)
        timeDelaysTextField!.inputView = pickerView
        timeDelaysTextField!.inputAccessoryView = toolBar
        view.addSubview(timeDelaysTextField!)
    }
    
    
    func setUpConditionsLabel(condition: String) {
        let string = "If conditions are: " + condition
        let attributes = [NSForegroundColorAttributeName: UIColor.black,
                          NSFontAttributeName: UIFont.preferredFont(forTextStyle: UIFontTextStyle.title1)]
        conditionsLabel.attributedText = NSAttributedString(string: string, attributes: attributes)
        conditionsLabel.setLinksForSubstrings([condition]) { (label, string) in
            self.weatherConditionsTextField?.becomeFirstResponder()
        }
    }
    
    func setUpAlarmAdjustmentLabel(timeDelay: String) {
        let string = "Wake me up eariler by: " + timeDelay
        let attributes = [NSForegroundColorAttributeName: UIColor.black,
                          NSFontAttributeName: UIFont.preferredFont(forTextStyle: UIFontTextStyle.subheadline)]
        alarmAdjustmentLabel.attributedText = NSAttributedString(string: string, attributes: attributes)
        alarmAdjustmentLabel.setLinksForSubstrings([timeDelay]) { (label, string) in
            self.timeDelaysTextField?.becomeFirstResponder()
        }
    }
    
    
    
    
    func doneButtonPressed() {
        weatherConditionsTextField?.resignFirstResponder()
        timeDelaysTextField?.resignFirstResponder()
    }

    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch pickerView.tag {
        case 1:
            return weatherConditions.count
        case 2:
            return timeDelays.count
        default:
            return 0
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch pickerView.tag {
        case 1:
            return weatherConditions[row]
        case 2:
            return timeDelays[row]
        default:
            return ""
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch pickerView.tag {
        case 1:
            setUpConditionsLabel(condition: weatherConditions[row])
        case 2:
            setUpAlarmAdjustmentLabel(timeDelay: timeDelays[row])
        default:
            break
        }
    }
    
    
    
    
    
    @IBAction func selectConditionsTextField(_ sender: UITextField) {
        
        
    }
    
    
    
    @IBAction func createAlarmButtonPressed(_ sender: UIButton) {
        createAlarm()
        navigationController?.popViewController(animated: true)

        
    }


    func createAlarm() {
//        let newAlarm = Alarm()
//        newAlarm.alarmTime = timePicker.date as NSDate
//        newAlarm.enabled = true
//        newAlarm.id = Int(Date().timeIntervalSince1970)
//        newAlarm.weatherCondition = (conditionsLabel.text?.lastWord)!
//        
//        let delayTimeString = alarmAdjustmentLabel.text!
//        
//        newAlarm.weatherDelayTime = Int(delayTimeString.components(separatedBy: " ")[5])!
//        
//        newAlarm.weatherCheckTime = newAlarm.alarmTime.addingTimeInterval(TimeInterval(-newAlarm.weatherDelayTime*60))
//        
//        let RI = RealmInteractor()
//        RI.saveAlarm(alarm: newAlarm)
//        let AL = AlarmLogic()
//        AL.scheduleAlarm(alarm: newAlarm)
        
        let kinveyAlarm = KinveyAlarm()
        kinveyAlarm.alarmTime = timePicker.date
        kinveyAlarm.weatherCondition = (conditionsLabel.text?.lastWord)!
        let delayTimeString = alarmAdjustmentLabel.text!
        kinveyAlarm.weatherDelayTimeMinutes = Int(delayTimeString.components(separatedBy: " ")[5])!
        
        let delayTimeInSeconds = kinveyAlarm.weatherDelayTimeMinutes * 60 * -1
        
        kinveyAlarm.weatherDelayTime = timePicker.date.addingTimeInterval(TimeInterval(delayTimeInSeconds))
        
        

        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: timePicker.date)
        let minutes = calendar.component(.minute, from: timePicker.date)
        kinveyAlarm.alarmTimeHours = hour
        kinveyAlarm.alarmTimeMinutes = minutes
        
        kinveyAlarm.location = GeoPoint(coordinate: (locationFetcher.locationManager.location?.coordinate)!)
        
        
        let KI = KinveyInteractor()
        KI.uploadAlarm(alarm: kinveyAlarm)
    }

    

    
    
    
}

extension String {
    var byWords: [String] {
        var result:[String] = []
        enumerateSubstrings(in: startIndex..<endIndex, options: .byWords) {
            guard let word = $0 else { return }
            print($1,$2,$3)
            result.append(word)
        }
        return result
    }
    var lastWord: String {
        return byWords.last ?? ""
    }
    func lastWords(_ max: Int) -> [String] {
        return Array(byWords.suffix(max))
    }
}




