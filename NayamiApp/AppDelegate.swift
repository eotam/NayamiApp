//
//  AppDelegate.swift
//  NayamiApp
//
//  Created by yamaguchi iori on 2021/05/23.
//

import UIKit
import Firebase
import NendAd

@main
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
//        インタースティシャル広告（ロードのみ）
        
        NADInterstitial.sharedInstance()?.loadAd(withSpotID: 1037642, apiKey: "f5971b873b1bc26b84de82f6f837a591aa6bcb75")
        
        FirebaseApp.configure()
        
//        let firebaseAuth = Auth.auth()
//        do{
//            try firebaseAuth.signOut()
//        }catch let signOutError as NSError {
//            print("Error signing out: %`", signOutError)
//
//        }
        
        
        
        // Override point for customization after application launch.
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

