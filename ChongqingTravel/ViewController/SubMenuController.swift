//
//  SubMenuController.swift
//  ChongqingTravel
//
//  Created by yangxue_pc on 2019/2/28.
//  Copyright © 2019年 yangxue_pc. All rights reserved.
//

import UIKit
import DNSPageView

class SubMenuController: BaseViewController {
    private var keyWord: String = ""
    
    convenience init(keyWord: String = "") {
        self.init()
        self.keyWord = keyWord
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        let style = DNSPageStyle()
        style.isTitleScaleEnabled = true
        style.isShowBottomLine = true
        style.titleSelectedColor = UIColor.black
        style.titleColor = UIColor.gray
        style.bottomLineColor = DominantColor
        style.bottomLineHeight = 2
        // Do any additional setup after loading the view.
        
        let titles = ["热门景点","全部","附近"]
        var viewControllers = [UIViewController]()
        for title in titles {
            let controller = PlaceViewController(placeType:title)
            viewControllers.append(controller)
        }
        for vc in viewControllers{
            self.addChildViewController(vc)
        }
        let pageView = DNSPageView(frame: CGRect(x: 0, y: navigationBarHeight, width: YYScreenWidth, height: YYScreenHeigth-navigationBarHeight), style: style, titles: titles, childViewControllers: viewControllers)
        
        view.addSubview(pageView)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(customView: rightBarButton)
        
    }


    private lazy var rightBarButton:UIButton = {
        let button = UIButton.init(type: UIButtonType.custom)
        button.frame = CGRect(x:0, y:0, width:30, height: 30)
        button.setImage(UIImage(named: "搜索"), for: UIControlState.normal)
        button.addTarget(self, action: #selector(rightBarButtonClick), for: UIControlEvents.touchUpInside)
        return button
    }()
    
    @objc func rightBarButtonClick() {
        
    }

}
