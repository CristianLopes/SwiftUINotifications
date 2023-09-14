import SwiftUI

struct ContentView: View {
    
    var body: some View {
        VStack {
            Button(action: {
                NotificationManager.instance.requestPermission()
            }, label: {
                Text("Request permission")
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(.blue)
                    .foregroundColor(.white)
            })
            
            Button(action: {
                NotificationManager.instance.scheduleNotification(timeInterval: 5.0, repeats: false)
            }, label: {
                Text("Schedule a notification ")
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(.blue)
                    .foregroundColor(.white)
            })
            
            Button(action: {
                var date = Date()
                print("Date from device: \(date)")
                
                date.addTimeInterval(60.0)
                
                print("Date from device after change: \(date)")
                let calendar = Calendar.current
                let hour = calendar.component(.hour, from: date)
                let minutes = calendar.component(.minute, from: date)
                
                var dateComponents = DateComponents()
                dateComponents.hour = hour
                dateComponents.minute = minutes
                
                NotificationManager.instance.scheduleNotification(dateComponent: dateComponents, repeats: true)
                
            }, label: {
                Text("Schedule a notification using date")
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(.blue)
                    .foregroundColor(.white)
            })
            
            Button(action: {
                NotificationManager.instance.cancelNotifications()
            }, label: {
                Text("Cancel notification")
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(.red)
                    .foregroundColor(.white)
            })
        }
        .padding()
        .onAppear(perform: {
            UIApplication.shared.applicationIconBadgeNumber = 0
        })
        
    }
        
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
