

import UIKit
import UserNotifications

class ViewController: UIViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // 1. REQUEST PERMISSION
    UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound], completionHandler: { (granted, error) in
      if granted {
        self.loadNotification()
      } else {
        print(error?.localizedDescription)
      }
    })
  }
  
  // 3. SCHEDULE NOTIFICATION
  @IBAction func notifyMeButtonTapped(sender: UIButton) {
    scheduleNotification(inSeconds: 5, completion: { success in
      if success {
        print("Successfully scheduled notification")
      } else {
        print("Error scheduling notification")
      }
    })
  }
  
  func loadNotification() {
    
  }
  
  // 2. CREATE NOTIFICATION
  func scheduleNotification(inSeconds: TimeInterval, completion: @escaping (_ Success: Bool) -> ()) {
    
    // Add an attachment
    let myImage = "bk"
    guard let imageUrl = Bundle.main.url(forResource: myImage, withExtension: "gif") else {
      completion(false)
      return
    }
    
    var attachment: UNNotificationAttachment
    
    attachment = try! UNNotificationAttachment(identifier: "myNotification", url: imageUrl, options: .none)
    
    // Create our notification content
    let notif = UNMutableNotificationContent()
    
    // ONLY FOR EXTENSION
    notif.categoryIdentifier = "myNotificationCategory"
    
    notif.title = "New Notification!"
    notif.subtitle = "These are great!"
    notif.body = "The new notification options in iOS 10 are what I've been waiting for! 👊"
    
    // Add our attachment
    notif.attachments = [attachment]
    
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

