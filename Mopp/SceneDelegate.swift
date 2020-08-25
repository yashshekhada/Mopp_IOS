//
//  SceneDelegate.swift
//  Mopp
//
//  Created by yash shekhada on 02/07/20.
//  Copyright © 2020 yash shekhada. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth
class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    
    @available(iOS 13.0, *)
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        
        if ClS.Uid.count != 0 {
            OnlineOfflineService.online(for: (Auth.auth().currentUser?.uid)!, status: true)
            {
                (success) in
                print("User ==>", success)
            }
        }
        guard let _ = (scene as? UIWindowScene) else { return }
        
    }
    
    @available(iOS 13.0, *)
    func sceneDidDisconnect(_ scene: UIScene) {
        if ClS.Uid.count != 0 {
            OnlineOfflineService.online(for: (Auth.auth().currentUser?.uid)!, status: false){ (success) in
                
                print("User ==>", success)
            }
        }
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not neccessarily discarded (see `application:didDiscardSceneSessions` instead).
    }
    
    @available(iOS 13.0, *)
    func sceneDidBecomeActive(_ scene: UIScene) {
        if ClS.Uid.count != 0 {
            OnlineOfflineService.online(for: (Auth.auth().currentUser?.uid)!, status: true){ (success) in
                
                print("User ==>", success)
            }
        }
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }
    
    @available(iOS 13.0, *)
    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }
    
    @available(iOS 13.0, *)
    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.  if ClS.Uid.count != 0 {if Auth.auth().currentUser != nil {
       if ClS.Uid.count != 0 {
        OnlineOfflineService.online(for: (Auth.auth().currentUser?.uid)!, status: false){ (success) in
            
            print("User ==>", success)
        }
        }
    }
    
    
    @available(iOS 13.0, *)
    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
        //https://apps.apple.com/us/app/hireme-healthcare-app/id1433604865
        if ClS.Uid.count != 0 {
            OnlineOfflineService.online(for: (Auth.auth().currentUser?.uid)!, status: false){ (success) in
                
                print("User ==>", success)
            }
            
        }
    }
        
        
}

