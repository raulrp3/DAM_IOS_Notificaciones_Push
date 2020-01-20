//
//  AppDelegate.swift
//  DAM_IOS_Notificaciones_Push
//
//  Created by raul.ramirez on 20/01/2020.
//  Copyright © 2020 Raul Ramirez. All rights reserved.
//

import UIKit
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        self.registerForPushNotifications()
        
        return true
    }
    
    func registerForPushNotifications(){
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]){ [weak self] granted, error in
            print("Permiso: \(granted)")
            
            guard granted else { return }
            self?.getNotificationsSettings()
        }
    }
    
    func getNotificationsSettings(){
        UNUserNotificationCenter.current().getNotificationSettings{ settings in
            print("Configuración push: \(settings)")
            
            guard settings.authorizationStatus == .authorized else { return }
            
            DispatchQueue.main.async {
                UIApplication.shared.registerForRemoteNotifications()
            }
        }
    }
    
    //SE HA COMPLETADO EL REGISTRO CON APNs
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data){
        let tokenParts = deviceToken.map{ data in String(format: "%02.2hhx", data) }
        let token = tokenParts.joined()
        
        print("Device token: \(token)")
    }
    
    //SI FALLA EL REGISTRO CON APNs
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error){
        print("Error en el registro: \(error)")
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

