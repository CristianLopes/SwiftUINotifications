#  SwiftUI - Simple Local Notifications

This is just a simple repository focused on giving a brief introduction to Local Notifications on IOS.

On this repository, we will have a singleton class **NotificationManager** which will handle everything related.

The first step will be to ask for permission.

For this, we will need to use the **UNUserNotificationCenter**

```swift
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
```

After accepting this permission we already are able to schedule notifications. 

**The most important part of the Notification is the Message.**

Which in this case needs to be a **UNMutableNotificationContent**. 
On this object, we can set a lot of information, 
for this example, we will set just the essentials. 
**title, subtitle, body, sound, badge**

```swift
    private func getNotificationContent(title: String) -> UNMutableNotificationContent {
        
        let content = UNMutableNotificationContent()
        content.title = title
        content.subtitle = "Stay hungy, Stay Foolish"
        content.body = "If today were the last day of your life, would you want to do what you are about to do today?"
        content.sound = .default
        content.badge = 1

        return content
    }
```

Before sending a request we will need to choose what will be the trigger for the notification.
We can use three different types of triggers.

**UNTimeIntervalNotificationTrigger** - This is where we should set a TimeInvertal in seconds from the moment you create a request.
```swift
    func scheduleNotification(timeInterval: TimeInterval, repeats: Bool) {
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: timeInterval, repeats: repeats)
        
        sendNotification(content: getNotificationContent(title: "Using TimeInterval"), trigger: trigger)
    }
```

**UNCalendarNotificationTrigger** - This is where we can schedule a notification for a specific time of day, 
or maybe on another day if that is what you want to do.
```swift
    func scheduleNotification(dateComponent: DateComponents, repeats: Bool) {
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponent, repeats: repeats)
        
        sendNotification(content: getNotificationContent(title: "Using DateComponents"), trigger: trigger)
    }
```

**UNLocationNotificationTrigger** - Last but not least, this is the trigger that could be used to notify users when they
enters or leaves in a specific location. 

All of these three can be set up to repeat.

Then now, we just need to send our message. 
```swift
    private func sendNotification(content: UNMutableNotificationContent, trigger: UNNotificationTrigger) {
        let request = UNNotificationRequest(identifier: UUID().uuidString,
                                            content: content,
                                            trigger: trigger)
        
        UNUserNotificationCenter.current().add(request)
        
        print("Notification Scheduled")
    }
```

We can cancel our notifications when necessary, for example, when we are using repetitions and want to stop them.
```swift
    func cancelNotifications() {
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
        UNUserNotificationCenter.current().removeAllDeliveredNotifications()
        
        print("Notifications Canceled")
    }
```

And another thing, to clear badges we will need to access UIApplication and set it to zero again.
```swift
    var body: some View {
        VStack {...}
        .padding()
        .onAppear(perform: {
            UIApplication.shared.applicationIconBadgeNumber = 0
        })
        
    }
```


And a few recommendations:

I couldn't help but recommend this amazing **[Nick's SwiftUi YouTube channel](https://www.youtube.com/@SwiftfulThinking)** 

And last, but not least... 
**[Hacking with Swift](https://www.hackingwithswift.com/)**

Thank you guys, I hope this simple code could save someone's time.
### **Don't Settle, The better is coming soon**

>**"If your dreams don't scare you, They Are Too Small"** Richard Branson
