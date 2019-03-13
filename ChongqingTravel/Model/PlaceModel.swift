//
//  PlaceModel.swift
//  ChongqingTravel
//
//  Created by yangxue_pc on 2019/3/6.
//  Copyright © 2019年 yangxue_pc. All rights reserved.
//

import Foundation
import HandyJSON

struct PlaceModel: HandyJSON {
    var placeName: String?
    var placeAddress: String?
    var placeType: String?
    var placeId: Int?
    var placeScore: String?
    var placeImage: String?
}
