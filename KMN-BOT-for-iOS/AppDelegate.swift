//
//  AppDelegate.swift
//  KMN-BOT-for-iOS
//
//  Created by 熊谷乾太 on 2016/9/19.
//  Copyright © 2016年 乾太. All rights reserved.
//

import UIKit
import OAuthSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    // 應用程式被呼叫時啟用
    func application(app: UIApplication, openURL handleOpenURL: NSURL, options: [String : AnyObject]) -> Bool {
        // Override point for customization after application launch.
        if (handleOpenURL.host == "oauth-callback") {
            if (handleOpenURL.path!.hasPrefix("/plurk")){
                NSLog("Run [application], url=\(handleOpenURL.absoluteString)")
                OAuthSwift.handleOpenURL(handleOpenURL)
            }
        }
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

