//
//  AppDelegate.swift
//  Navigation
//
//  Created by ROMAN VRONSKY on 14.07.2022.
//

import UIKit
import Firebase
import FirebaseCore
import RealmSwift
import KeychainAccess
let keyChain = Keychain(service: "Roman-Vronsky.Navigation")
@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        //        var key = Data(count: 64)
        //        _ = key.withUnsafeMutableBytes { (pointer: UnsafeMutableRawBufferPointer) in
        //            SecRandomCopyBytes(kSecRandomDefault, 64, pointer.baseAddress!)
        //        }
        //        keyChain[data: "pass"] = key
        let pass = try? keyChain.getData("pass")
        
        FirebaseApp.configure()
        let config = Realm.Configuration(encryptionKey: pass)
        Realm.Configuration.defaultConfiguration = config
        
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

