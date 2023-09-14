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
                print("ALLOWED BY USER")
            } else {
                print("DENIED BY USER")
            }
        }
    }
    
    func scheduleNotification(timeInterval: TimeInterval, repeats: Bool) {
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: timeInterval, repeats: repeats)
        
        sendNotification(content: getNotificationContent(title: "Using TimeInterval"), trigger: trigger)
    }

    func scheduleNotification(dateComponent: DateComponents, repeats: Bool) {
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponent, repeats: repeats)
        
        sendNotification(content: getNotificationContent(title: "Using DateComponents"), trigger: trigger)
    }
    
    private func getNotificationContent(title: String) -> UNMutableNotificationContent {
        
        let content = UNMutableNotificationContent()
        content.title = title
        content.subtitle = "Stay hungy, Stay Foolish"
        content.body = "If today were the last day of your life, would you want to do what you are about to do today?"
        content.sound = .default
        content.badge = 1

        return content
    }
    
    private func sendNotification(content: UNMutableNotificationContent, trigger: UNNotificationTrigger) {
        let request = UNNotificationRequest(identifier: UUID().uuidString,
                                            content: content,
                                            trigger: trigger)
        
        UNUserNotificationCenter.current().add(request)
        
        print("Notification Scheduled")
    }
    
    func cancelNotifications() {
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
        UNUserNotificationCenter.current().removeAllDeliveredNotifications()
        
        print("Notifications Canceled")
    }
    
}
