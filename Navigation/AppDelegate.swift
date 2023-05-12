//
//  AppDelegate.swift
//  Navigation
//
//  Created by ROMAN VRONSKY on 14.07.2022.
//

import UIKit
import Firebase
import FirebaseCore
import KeychainAccess
import UserNotifications
let keyChain = Keychain(service: "Roman-Vronsky.Navigation")
@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
                
        let notificationCenter = LocalNotificationsService()
        notificationCenter.registeForLatestUpdatesIfPossible()
       let center = UNUserNotificationCenter.current()
        center.delegate = self
        let pass = try? keyChain.getData("pass")
        
        FirebaseApp.configure()
        
        return true
    }
    
    
    // MARK: UISceneSession Lifecycle
    
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
    
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    
    
}
extension AppDelegate: UNUserNotificationCenterDelegate {
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        switch response.actionIdentifier {
        case UNNotificationDefaultActionIdentifier :
            UIApplication.shared.applicationIconBadgeNumber = 0
        case "updating":
            UIApplication.shared.applicationIconBadgeNumber = 0
        default:
            print("default")
        }
        completionHandler()
    }
}
