//
//  AppDelegate.swift
//  ios_part
//
//  Created by 菊池 紘 on 2020/09/16.
//  Copyright © 2020 菊池 紘. All rights reserved.
//

import UIKit
import Flutter
import FlutterPluginRegistrant
import Firebase

@UIApplicationMain
class AppDelegate: FlutterAppDelegate {
    lazy var flutterEngine = FlutterEngine(name: "my flutter engine")


    override func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Run flutter app and initilize FirebaseApp from Flutter.
        flutterEngine.run()
        GeneratedPluginRegistrant.register(with: self.flutterEngine)
        
        // I found the workaround to avoid double initialization of FirebaseApp. But...
        if FirebaseApp.app() == nil {
            FirebaseApp.configure()
        }
        
        // Using Firestore instance from platform before using it from Flutter application will cause carsh.
        Firestore.firestore().document("/counters/1").addSnapshotListener({ (snapshot, error) in print(snapshot)})
        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }

    // MARK: UISceneSession Lifecycle

    override func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    override func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

