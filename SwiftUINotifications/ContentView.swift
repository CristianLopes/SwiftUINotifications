//
//  ContentView.swift
//  SwiftUINotifications
//
//  Created by Cristian Cris on 13/09/23.
//

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
                Text("Schedule a notification")
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
