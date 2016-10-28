//
//  AppDelegate.swift
//  FitnessApp
//
//  Created by Giorgio Doganiero on 9/2/16.
//  Copyright © 2016 Giorgio Doganiero. All rights reserved.
//

import UIKit
import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    var storyboard : UIStoryboard?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        //firebase config
        FIRApp.configure()
        
        //nav bar backgorund color
        UINavigationBar.appearance().barTintColor = UIColor.customDarkGray()
        UINavigationBar.appearance().isTranslucent = false
        
        //pagecontroller 
        let pageController = UIPageControl.appearance()
        pageController.pageIndicatorTintColor = UIColor.customDarkGray()
        pageController.currentPageIndicatorTintColor = UIColor.customLightGray()
        
        //status bar font color
        application.statusBarStyle = .lightContent
        
        //launch for the first time
        //if let bundle = Bundle.main.bundleIdentifier {
        //    UserDefaults.standard.removePersistentDomain(forName: bundle)
        //}
        
        //tabbar colors
        //UITabBar.appearance().isTranslucent = false
        //UITabBar.appearance().tintColor = UIColor.customGreen()
        //UITabBar.appearance().barTintColor = UIColor.customDarkGray()
        
        /*
        if let bundle = Bundle.main.bundleIdentifier {
            UserDefaults.standard.removePersistentDomain(forName: bundle)
        }
        */
 
        
        return true
    }
    
    func application(_ application: UIApplication, performActionFor shortcutItem: UIApplicationShortcutItem, completionHandler: @escaping (Bool) -> Void) {
        
        let handleShortcutItem = self.handleShortcutItem(shortcutItem)
        completionHandler(handleShortcutItem)
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
        self.window?.rootViewController?.dismiss(animated: false, completion: nil)
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    //Quick Action code
    enum ShortcutIdentifier: String
    {
        case First
        case Second
        
        init?(fullType: String)
        {
            guard let last = fullType.components(separatedBy: ".").last else {return nil}
            self.init(rawValue: last)
        }
        
        var type: String{
            return Bundle.main.bundleIdentifier! + ".\(self.rawValue)"
        }
    }
    
    func handleShortcutItem(_ shortcutItem: UIApplicationShortcutItem) -> Bool
    {
        var handle = false
        
        guard ShortcutIdentifier(fullType: shortcutItem.type) != nil else {return false}
        guard let shortcutType = shortcutItem.type as String? else {return false}
        
        switch (shortcutType)
        {
        case ShortcutIdentifier.First.type:
            handle = true
            // search - search for an exercise
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let navVC = storyboard.instantiateViewController(withIdentifier: "newRecord") as! UINavigationController
            self.window?.rootViewController?.present(navVC, animated: true, completion: nil)
            
            break
        case ShortcutIdentifier.Second.type:
            handle = true
            //add progress - load the view used to add a new record to the progress view
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let navVC = storyboard.instantiateViewController(withIdentifier: "startWorkout")
            self.window?.rootViewController?.present(navVC, animated: true, completion: nil)
            
            break
        default:
            break
        }
        return handle
    }
    
}
