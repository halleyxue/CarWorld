//
//  HomePageModel.swift
//  ChongqingTravel
//
//  Created by yangxue_pc on 2019/1/31.
//  Copyright © 2019年 yangxue_pc. All rights reserved.
//
import Foundation
import HandyJSON

struct FMHomeRecommendModel: HandyJSON {
    var ret:Int = 0
    var list:[HomeRecommendModel]?
}

struct HomeRecommendModel: HandyJSON {
    var list: [RecommendListModel]?
    var moduleId: Int = 0
    var moduleType: String?
}

struct RecommendListModel: HandyJSON {
    var title: String?
    var coverPath: String?
    
}

struct FocusModel: HandyJSON {
    var data: [BannerData]?
}

struct BannerData: HandyJSON {
    var clickType: Int = 0
    var cover: String?
    var targetId: Int = 0
}

struct SquareModel: HandyJSON {
    var id: String?
    var coverPath: String?
    var title: String?
    var keyword: String?
}

