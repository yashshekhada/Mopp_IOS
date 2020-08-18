//
//  AppDelegate.swift
//  Mopp
//
//  Created by yash shekhada on 02/07/20.
//  Copyright © 2020 yash shekhada. All rights reserved.
//

import UIKit
import Firebase



import FirebaseAuth
import FirebaseDatabase

import MapKit



import iOTool
import IQKeyboardManagerSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate
{
    
    
    var window: UIWindow?
    var enableAllOrientation = false
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool
    {
        // Override point for customization after application launch.
        
     // FirebaseApp.configure()
          

        IQKeyboardManager.shared.enable = true
        return true
    }

    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data)
    {
        let deviceTokenString = deviceToken.reduce("", {$0 + String(format: "%02X", $1)})
        ud.setValue(deviceTokenString, forKey: "deviceToken")
        ud.synchronize()
        print("APNs device token: \(deviceTokenString)")
    }
}
