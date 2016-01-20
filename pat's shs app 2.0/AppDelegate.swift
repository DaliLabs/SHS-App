//
//  AppDelegate.swift
//  pat's shs app 2.0
//
//  Created by Patrick Li on 10/12/15.
//  Copyright © 2015 Dali Labs, Inc. All rights reserved.
//

import UIKit
import Parse
import Bolts

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var walkthrough:MMPlayStandPageViewController?
    var plistPathInDocument:String = String()
    var plist2PathInDocument:String = String()

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        self.preparePlist()
        self.preparePlist2()
        // Override point for customization after application launch.
        UINavigationBar.appearance().barTintColor = UIColor.redColor()
        UINavigationBar.appearance().titleTextAttributes = [NSForegroundColorAttributeName : UIColor.whiteColor()]
        UINavigationBar.appearance().tintColor = UIColor.whiteColor()
        let main = UIStoryboard(name: "Main", bundle: nil)
        walkthrough = main.instantiateViewControllerWithIdentifier("playstand") as? MMPlayStandPageViewController

        Parse.setApplicationId("mBeDrmdeuRATh3rO7CqbTZMYKcXkuSrCKPEkPFDG", clientKey: "VoIiZFddiKtfH9i7iz5jyQMsT9H45KgnDUOtEDo2")

        return true
    }
    
    
    func preparePlist()
    {
        let rootPath = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, .UserDomainMask, true)[0]
        let url = NSURL(string: rootPath)
        plistPathInDocument = (url?.URLByAppendingPathComponent("planner.plist").path)!
        
        if !NSFileManager.defaultManager().fileExistsAtPath(plistPathInDocument){
            let plistPathInBundle = NSBundle.mainBundle().pathForResource("planner", ofType: "plist")!
            do {
                try NSFileManager.defaultManager().copyItemAtPath(plistPathInBundle, toPath: plistPathInDocument)
                print("plist copied")
            }
            catch{
                print("error copying plist!")
            }
        }
        else{
            print("plst exists \(plistPathInDocument)")
        }
        
    }
    
    
    func preparePlist2()
    {
        let rootPath = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, .UserDomainMask, true)[0]
        let url = NSURL(string: rootPath)
        plist2PathInDocument = (url?.URLByAppendingPathComponent("sortedSections.plist").path)!
        
        if !NSFileManager.defaultManager().fileExistsAtPath(plist2PathInDocument){
            let plistPathInBundle = NSBundle.mainBundle().pathForResource("sortedSections", ofType: "plist")!
            do {
                try NSFileManager.defaultManager().copyItemAtPath(plistPathInBundle, toPath: plist2PathInDocument)
                print("plist copied")
            }
            catch{
                print("error copying plist!")
            }
        }
        else{
            print("plst exists \(plist2PathInDocument)")
        }
        
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    
}

