//
//  NavigationController.swift
//  ChongqingTravel
//
//  Created by yangxue_pc on 2019/2/27.
//  Copyright © 2019年 yangxue_pc. All rights reserved.
//

import UIKit

class NavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setNavBarAppearence()
    }
    
    func setNavBarAppearence()
    {
        // 设置导航栏默认的背景颜色
        self.navigationBar.barTintColor = UIColor.init(red: 245/255.0, green: 245/255.0, blue: 245/255.0, alpha: 1)
        // 设置导航栏所有按钮的默认颜色
        self.navigationBar.tintColor = UIColor.init(red: 242/255.0, green: 77/255.0, blue: 51/255.0, alpha: 1)
        // 设置导航栏标题默认颜色
        self.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.init(red: 38/255.0, green: 38/255.0, blue: 38/255.0, alpha: 1.0), NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16.0)]       // 统一设置状态栏样式
        //        WRNavigationBar.defaultStatusBarStyle = .lightContent
        // 如果需要设置导航栏底部分割线隐藏，可以在这里统一设置
        
    }
}

extension NavigationController {
    override func pushViewController(_ viewController: UIViewController, animated: Bool){
        if childViewControllers.count > 0 {
            viewController.hidesBottomBarWhenPushed = true
        }
        super.pushViewController(viewController, animated: animated)
    }
}

