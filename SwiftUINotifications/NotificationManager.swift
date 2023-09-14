//
//  NotificationManager.swift
//  SwiftUINotifications
//
//  Created by Cristian Cris on 13/09/23.
//

import Foundation
import UserNotifications

class NotificationManager {
    
    private init() { }
    
    static let instance = NotificationManager()
    
    func requestPermission(){
        
        let options: UNAuthorizationOptions = [.alert, .sound, .badge]
        
        UNUserNotificationCenter.current().requestAuthorization(options: options) { (success, error) in

            if let error = error {
                print("ERROR: \(error)")
                return
            }
            
            if success {
                print("ALLOW BY USER")
            } else {
                print("DENY BY USER")
            }
        }
    }
    
    func scheduleNotification() {
        
        let content = UNMutableNotificationContent()
        content.title = "Stay tuned!"
        content.subtitle = "It's time to win"
        content.sound = .default
        content.badge = 1
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5.0, repeats: false)
        
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request)
        
        print("Notification Scheduled")
    }
    
    func cancelNotifications() {
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
        UNUserNotificationCenter.current().removeAllDeliveredNotifications()
        
        print("Notifications Canceled")
    }
    
}
