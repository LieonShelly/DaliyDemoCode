//
//  AppDelegate.swift
//  DemoCode
//
//  Created by lieon on 16/9/13.
//  Copyright © 2016年 lieon. All rights reserved.
//

import UIKit
import UserNotifications
import PromiseKit
import LRefresh


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey : Any]? = nil) -> Bool {
        window = UIWindow()
        window?.frame = UIScreen.main.bounds
//        guard let initialVc = UIStoryboard(name: "WebSocket", bundle: nil).instantiateInitialViewController() else { return true }
        window?.rootViewController = UINavigationController(rootViewController: AppStoreViewController())
        window?.makeKeyAndVisible()
        UITabBar.appearance().tintColor = UIColor.orange
        registerPush(application, launchOptions: launchOptions)
        
        return true
    }// 
    

}

extension AppDelegate: UNUserNotificationCenterDelegate {
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        print("deviceToke:\(deviceToken)")
      
    }
    
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print("didFailToRegisterForRemoteNotificationsWithError:\(error)")
    }
    
    fileprivate func registerPush(_ application: UIApplication, launchOptions: [UIApplicationLaunchOptionsKey: Any]?) {
        guard let version = Float(UIDevice.current.systemVersion) else { return }
        if version >= 10.0 {
            let center = UNUserNotificationCenter.current()
            center.delegate = self
            center.requestAuthorization(options: [.alert, .badge, .sound], completionHandler: { (granted, error) in
                if granted {
                    print("注册成功")
                    center.getNotificationSettings(completionHandler: { (setting) in
                        print(setting)
                    })
                } else {
                    print("注册失败")
                }
            })
        }
        UIApplication.shared.registerForRemoteNotifications()
    }
}

