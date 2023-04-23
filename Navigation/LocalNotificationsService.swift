//
//  LocalNotificationsService.swift
//  Navigation
//
//  Created by ROMAN VRONSKY on 22.04.2023.
//


import UserNotifications
import UIKit

class LocalNotificationsService {
    
    func registeForLatestUpdatesIfPossible() {
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.alert, .sound, .badge, .provisional]) { success, error in
            if let error = error {
                print(error)
            }
            if success {
                DispatchQueue.main.async {
                    self.sendNotification()
                }
                
            }
        }
       
    }
    func sendNotification() {
        let center = UNUserNotificationCenter.current()
        let content = UNMutableNotificationContent()
        content.title = "Посмотрите последние обновления"
        content.body = "Проверьте обновления"
        content.sound = .default
        content.badge = (UIApplication.shared.applicationIconBadgeNumber) + 1 as NSNumber
        var dateComponents = DateComponents()
        dateComponents.hour = 19
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        center.add(request)
    }
}
