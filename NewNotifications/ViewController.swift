//
//  ViewController.swift
//  NewNotifications
//
//  Created by Burak Firik on 2/18/17.
//  Copyright © 2017 Code Path. All rights reserved.
//

import UIKit
import UserNotifications

class ViewController: UIViewController {

  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    UNUserNotificationCenter.current().requestAuthorization(options: [.alert,  .badge, .sound], completionHandler: { (granted,error) in
      
      if granted {
        print("Notification is granted")
      } else {
        print(error?.localizedDescription)
      }
     
    })
  }
  
  
  @IBAction func notifyMeButtonTapped(sender: UIButton) {
    scheduleNotification(inSeconds: 5, completion: { success in
      
      if success {
        print("schedule success")
      } else {
        print("Not scheduled")
      }
      
    })
  }

  
  func scheduleNotification(inSeconds: TimeInterval,  completion: @escaping (_: Bool) -> ()) {
    let notif = UNMutableNotificationContent()
    
    notif.title = "New Notification"
    notif.subtitle = "These are great"
    notif.body = "The new notification options are great in iOS 10"
    
    let notifTrigger = UNTimeIntervalNotificationTrigger(timeInterval: inSeconds, repeats: false)
    let request = UNNotificationRequest(identifier: "myNotification", content: notif, trigger: notifTrigger)
    
    UNUserNotificationCenter.current().add(request, withCompletionHandler: { error in
      if error != nil {
        print(error)
        completion(false)
      } else {
        completion(true)
      }
    })
    
  }

}

