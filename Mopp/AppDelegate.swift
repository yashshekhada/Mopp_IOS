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
import UserNotifications

import iOTool
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate  {
    
    
    let gcmMessageIDKey = "gcm.message_id"
    var window: UIWindow?
    var enableAllOrientation = false
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
       
        IQKeyboardManager.shared.enable = true
       // FirebaseApp.configure()
        
        // [START set_messaging_delegate]
      FirebaseApp.configure()

        // [START set_messaging_delegate]
        Messaging.messaging().delegate = self
        // [END set_messaging_delegate]
        // Register for remote notifications. This shows a permission dialog on first run, to
        // show the dialog at a more appropriate time move this registration accordingly.
        // [START register_for_notifications]
        if #available(iOS 10.0, *) {
          // For iOS 10 display notification (sent via APNS)
          UNUserNotificationCenter.current().delegate = self

          let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
          UNUserNotificationCenter.current().requestAuthorization(
            options: authOptions,
            completionHandler: {_, _ in })
        } else {
          let settings: UIUserNotificationSettings =
          UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
          application.registerUserNotificationSettings(settings)
        }

        application.registerForRemoteNotifications()

        
      //  Messaging.messaging().delegate = self
        
        let token = Messaging.messaging().fcmToken
        print("FCM token: \(token ?? "")")
        ClS.FCMtoken = token ?? ""
        
        
        //Added Code to display notification when app is in Foreground
        if #available(iOS 10.0, *) {
            UNUserNotificationCenter.current().delegate = self
        } else {
            // Fallback on earlier versions
        }
        if ClS.Uid.count != 0 {
            OnlineOfflineService.online(for: (ClS.Uid), status: true){ (success) in

                print("User ==>", success)

            }
        }
        
        application.registerForRemoteNotifications()
        
        // [END register_for_notifications]
        return true
    }
    
  // working code
    func application(_ application: UIApplication,
                     didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        Messaging.messaging().apnsToken = deviceToken as Data
    }
    
//  @available(iOS 10.0, *)
//     func userNotificationCenter(_ center: UNUserNotificationCenter,  willPresent notification: UNNotification, withCompletionHandler   completionHandler: @escaping (_ options:   UNNotificationPresentationOptions) -> Void) {
//
//         // custom code to handle push while app is in the foreground
//         print("Handle push from foreground \(notification.request.content.userInfo)")
//
//
//         // Reading message body
//         let dict = notification.request.content.userInfo["aps"] as! NSDictionary
//
//         var messageBody:String?
//         var messageTitle:String = "Alert"
//
//         if let alertDict = dict["alert"] as? Dictionary<String, String> {
//             messageBody = alertDict["body"]!
//             if alertDict["title"] != nil { messageTitle  = alertDict["title"]! }
//
//         } else {
//             messageBody = dict["alert"] as? String
//         }
//
//         print("Message body is \(messageBody!) ")
//         print("Message messageTitle is \(messageTitle) ")
//         // Let iOS to display message
//         completionHandler([.alert,.sound, .badge])
//    }
//    @available(iOS 10.0, *)
//    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
//
//        print("Message \(response.notification.request.content.userInfo)")
//
//        completionHandler()
//    }

 // [START receive_message]
 func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any]) {
   // If you are receiving a notification message while your app is in the background,
   // this callback will not be fired till the user taps on the notification launching the application.
   // TODO: Handle data of notification
   // With swizzling disabled you must let Messaging know about the message, for Analytics
   // Messaging.messaging().appDidReceiveMessage(userInfo)
   // Print message ID.
   if let messageID = userInfo[gcmMessageIDKey] {
     print("Message ID: \(messageID)")
   }

   // Print full message.
   print(userInfo)
 }

 func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any],
                  fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
   // If you are receiving a notification message while your app is in the background,
   // this callback will not be fired till the user taps on the notification launching the application.
   // TODO: Handle data of notification
   // With swizzling disabled you must let Messaging know about the message, for Analytics
   // Messaging.messaging().appDidReceiveMessage(userInfo)
   // Print message ID.
   if let messageID = userInfo[gcmMessageIDKey] {
     print("Message ID: \(messageID)")
   }

   // Print full message.
   print(userInfo)

   completionHandler(UIBackgroundFetchResult.newData)
 }
 // [END receive_message]
 func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
   print("Unable to register for remote notifications: \(error.localizedDescription)")
 }

 // This function is added here only for debugging purposes, and can be removed if swizzling is enabled.
 // If swizzling is disabled then this function must be implemented so that the APNs token can be paired to
 // the FCM registration token.

    
     
//    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any]) {
//        // Print full message.
//        print(userInfo)
//        
//    }

    
   
//    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
//      if application.applicationState == .active {
//        if let aps = userInfo["aps"] as? NSDictionary {
//          if let alertMessage = aps["alert"] as? String {
//            let alert = UIAlertController(title: "Notification", message: alertMessage, preferredStyle: UIAlertController.Style.alert)
//            let action = UIAlertAction(title: "Ok", style: .default, handler: nil)
//            alert.addAction(action)
//            self.window?.rootViewController?.present(alert, animated: true, completion: nil)
//          }
//        }
//      }
//      completionHandler(.newData)
//    }
    
    // This method will be called when app received push notifications in foreground
//    @available(iOS 10.0, *)
    
    //working code
//    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void)
//    { completionHandler([UNNotificationPresentationOptions.alert,UNNotificationPresentationOptions.sound,UNNotificationPresentationOptions.badge])
//    }
 

    // MARK:- Messaging Delegates
//    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String) {
//        InstanceID.instanceID().instanceID { (result, error) in
//            if let error = error {
//                print("Error fetching remote instange ID: \(error)")
//            } else if let result = result {
//                print("Remote instance ID token: \(result.token)")
//                  ClS.FCMtoken = result.token
//            }
//        }
//    }
    // online ofline code for firbase chat
    func applicationDidEnterBackground(_ application: UIApplication) {
           
            if ClS.Uid.count != 0 {
                           OnlineOfflineService.online(for: (ClS.Uid), status: false){ (success) in

                               print("User ==>", success)
                           }
                       }
       }
       func applicationDidBecomeActive(_ application: UIApplication) {
      if ClS.Uid.count != 0 {
                           OnlineOfflineService.online(for: (ClS.Uid), status: true){ (success) in

                               print("User ==>", success)
                           }
                       }
       }
       func applicationWillEnterForeground(_ application: UIApplication) {
            if ClS.Uid.count != 0 {
                           OnlineOfflineService.online(for: (ClS.Uid), status: false){ (success) in

                               print("User ==>", success)
                           }
                       }
       }
    func applicationWillTerminate(_ application: UIApplication) {
 
          if ClS.Uid.count != 0 {
               OnlineOfflineService.online(for: (ClS.Uid), status: false){ (success) in

                   print("User ==>", success)
               }
           }
    }
//    func messaging(_ messaging: Messaging, didReceive remoteMessage: MessagingRemoteMessage) {
//        print("received remote notification")
//    }
    
    
    
}
struct OnlineOfflineService {
    static func online(for uid: String, status: Bool, success: @escaping (Bool) -> Void) {
        //True == Online, False == Offline
        let onlinesRef = Database.database().reference().child("Students").child(ClS.Uid).child("online")
        onlinesRef.setValue(status) {(error, _ ) in

            if let error = error {
                assertionFailure(error.localizedDescription)
                success(false)
            }
            success(true)
        }
        
    }
}
@available(iOS 10, *)
extension AppDelegate : UNUserNotificationCenterDelegate {

  // Receive displayed notifications for iOS 10 devices.
     func userNotificationCenter(_ center: UNUserNotificationCenter,
                              willPresent notification: UNNotification,
    withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
    let userInfo = notification.request.content.userInfo

    // With swizzling disabled you must let Messaging know about the message, for Analytics
    // Messaging.messaging().appDidReceiveMessage(userInfo)
    // Print message ID.
    if let messageID = userInfo[gcmMessageIDKey] {
      print("Message ID: \(messageID)")
    }
        
       let defaults = UserDefaults.standard

    // Print full message.
        var dataModel = userInfo as! [String:AnyObject?]
        var dataobject: [String:Any]?
        dataobject=defaults.dictionary(forKey: ClS.Sf_DataOfNotification) as [String : AnyObject]?//(forKey: <#T##String#>)
        if dataModel["data"] != nil
        {
            
//            let aps = dataModel["aps"] as! [String:AnyObject]//["alert"]
//                      let alert = aps["alert"] as! [String:AnyObject]
//                      let Body = alert["body"]
//                      let title = alert["title"]
//
//                      dataobject = ["type":1,"title":title,"Body":Body]
//                      defaults.setValue(dataobject, forKey: ClS.Sf_DataOfNotification)
            
        }else if dataModel["aps"] != nil{
            let aps = dataModel["aps"] as! [String:AnyObject]//["alert"]
            let alert = aps["alert"] as! [String:AnyObject]
            let Body = alert["body"]
            let title = alert["title"]
            
            
            if dataobject!["Data"] != nil{
                var Data : [[String:AnyObject]?]
                Data=[(dataobject!["Data"] as! [String:AnyObject])]
              //  Data.
                Data.append(["type":1,"title":title,"Body":Body] as [String : AnyObject])
            var newdata = ["Data": Data]
                 defaults.setValue(dataobject, forKey: ClS.Sf_DataOfNotification)
            }
            else{
                 dataobject = ["Data": [["type":1,"title":title,"Body":Body]]]
            }
            defaults.setValue(dataobject, forKey: ClS.Sf_DataOfNotification)
        }
//        let dictionary: [String:AnyObject] = ["key":"Value"]  //Dictionary which you want to save
//
//        defaults.setValue(dictionary, forKey: "DictValue") //Saved the Dictionary in user default
//
//        let dictValue = defaults.value(forKey: "DictValue") //Retrieving the value from user default

        print(dataModel)  // Printing the value

    // Change this to your preferred presentation option
    completionHandler([[.alert, .sound]])
  }

    
     func userNotificationCenter(_ center: UNUserNotificationCenter,
                              didReceive response: UNNotificationResponse,
                              withCompletionHandler completionHandler: @escaping () -> Void) {
    let userInfo = response.notification.request.content.userInfo
    // Print message ID.
    if let messageID = userInfo[gcmMessageIDKey] {
      print("Message ID: \(messageID)")
    }

    // With swizzling disabled you must let Messaging know about the message, for Analytics
    // Messaging.messaging().appDidReceiveMessage(userInfo)
    // Print full message.
    print(userInfo)

    completionHandler()
  }
}
// [END ios_10_message_handling]

extension AppDelegate : MessagingDelegate {
  // [START refresh_token]
     func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String) {
          print("Firebase registration token: \(fcmToken)")
          
          let dataDict:[String: String] = ["token": fcmToken]
          NotificationCenter.default.post(name: Notification.Name("FCMToken"), object: nil, userInfo: dataDict)
        InstanceID.instanceID().instanceID { (result, error) in
            if let error = error {
                print("Error fetching remote instange ID: \(error)")
            } else if let result = result {
                print("Remote instance ID token: \(result.token)")
                  ClS.FCMtoken = result.token
            }
        }
    }
   // private func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String) {
  
    // TODO: If necessary send token to application server.
    // Note: This callback is fired at each app startup and whenever a new token is generated.
 // }
  // [END refresh_token]
}
