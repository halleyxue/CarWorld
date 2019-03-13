//
//  AppDelegate.swift
//  ChongqingTravel
//
//  Created by yangxue_pc on 2019/1/30.
//  Copyright © 2019年 yangxue_pc. All rights reserved.
//

import UIKit
import ESTabBarController_swift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        Thread .sleep(forTimeInterval: 0.5)
        let tab = self.customIrregularityStyle(delegate: self as? UITabBarControllerDelegate)
        self.window?.rootViewController = tab
        self.window?.makeKeyAndVisible()
        return true
    }
    
    func customIrregularityStyle(delegate: UITabBarControllerDelegate?) -> ESTabBarController {
        let tabBarController = ESTabBarController()
        tabBarController.delegate = delegate
        tabBarController.title = "Irregularity"
        tabBarController.tabBar.shadowImage = UIImage(named: "transparent")
        let mainViewController = MainViewController()
        let discoveryViewController = DiscoveryViewController()
        let myInfoViewController = MyInfoViewController()
        
        mainViewController.tabBarItem = ESTabBarItem.init(IrregularityBasicContentView(), title: "首页", image: UIImage(named: "home"), selectedImage: UIImage(named: "home_1"))
        discoveryViewController.tabBarItem = ESTabBarItem.init(IrregularityBasicContentView(), title: "我听", image: UIImage(named: "find"), selectedImage: UIImage(named: "find_1"))
        myInfoViewController.tabBarItem = ESTabBarItem.init(IrregularityBasicContentView(), title: "我的", image: UIImage(named: "me"), selectedImage: UIImage(named: "me_1"))
        let n1 = NavigationController.init(rootViewController: mainViewController)
        let n2 = NavigationController.init(rootViewController: discoveryViewController)
        let n3 = NavigationController.init(rootViewController: myInfoViewController)
        
        tabBarController.viewControllers = [n1, n2, n3]
        return tabBarController
    }

    func applicationWillResignActive(_ application: UIApplication) {
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
    }

    func applicationWillTerminate(_ application: UIApplication) {
    }


}

