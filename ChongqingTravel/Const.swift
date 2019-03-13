//
//  Const.swift
//  ChongqingTravel
//
//  Created by yangxue_pc on 2019/2/1.
//  Copyright © 2019年 yangxue_pc. All rights reserved.
//

import Foundation
import UIKit
import Kingfisher
import SnapKit

let YYScreenWidth = UIScreen.main.bounds.size.width
let YYScreenHeigth = UIScreen.main.bounds.size.height
let DominantColor = UIColor.init(red: 242/255.0, green: 77/255.0, blue: 51/255.0, alpha: 1)

let isIphoneX = YYScreenHeigth == 812 ? true : false
let navigationBarHeight : CGFloat = isIphoneX ? 88 : 64
