//
//  NotificationViewController.swift
//  MyContentExtension
//
//  Created by Burak Firik on 2/19/17.
//  Copyright © 2017 Code Path. All rights reserved.
//

import UIKit
import UserNotifications
import UserNotificationsUI

class NotificationViewController: UIViewController, UNNotificationContentExtension {

  @IBOutlet weak var imageView: UIImageView!
  
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any required interface initialization here.
    }
    
    func didReceive(_ notification: UNNotification) {
      guard let attachment = notification.request.content.attachments.first else {
        return 
      }
      
      if attachment.url.startAccessingSecurityScopedResource() {
        let imageData = try? Data.init(contentsOf: attachment.url)
        
        if let img = imageData {
          imageView.image = UIImage(data: img)
        }
      }
     
    }
  
  func didReceive(_ response: UNNotificationResponse, completionHandler completion: @escaping (UNNotificationContentExtensionResponseOption) -> Void) {
    if response.actionIdentifier == "Ok" || response.actionIdentifier == "dismiss" {
      completion(.dismissAndForwardAction)
    } 
  }

}
