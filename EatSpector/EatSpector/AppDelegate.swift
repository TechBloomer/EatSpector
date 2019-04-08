//
//  AppDelegate.swift
//  EatSpector
//
//  Created by Pann Cherry on 10/2/18.
//  Copyright © 2018 TechBloomer. All rights reserved.
//

import UIKit
import Firebase;


@UIApplicationMain

class AppDelegate: UIResponder, UIApplicationDelegate {
    
    static let googleMapsApiKey = "AIzaSyBV2akct5tPf2nQ4mfzEpHj47SvMSMMlro"
    static let googlePlacesAPIKey = "AIzaSyBV2akct5tPf2nQ4mfzEpHj47SvMSMMlro"
    
    var window: UIWindow?
    var ref: DatabaseReference!
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure();
        // Check if there is a user logged in
        ref = Database.database().reference()
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
        for window in application.windows {
            window.rootViewController?.beginAppearanceTransition(false, animated: false)
            window.rootViewController?.endAppearanceTransition()
        }
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
        for window in application.windows {
            window.rootViewController?.beginAppearanceTransition(true, animated: false)
            window.rootViewController?.endAppearanceTransition()
        }

    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
  

}

