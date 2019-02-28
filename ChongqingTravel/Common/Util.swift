//
//  Util.swift
//  ChongqingTravel
//
//  Created by yangxue_pc on 2019/2/21.
//  Copyright © 2019年 yangxue_pc. All rights reserved.
//

import Foundation
import UIKit

class Util {
    
    class func mapToJson(map: [String: Any])-> String {
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: map, options: .prettyPrinted);
            return String.init(data: jsonData, encoding: .utf8)!;
        } catch {
            print(error.localizedDescription)
            return "";
        }
    }
    
    class func randomNumber(length: Int)-> String {
        var num: String = "";
        for _ in 1...length {
            num.append(String(arc4random_uniform(10)));
        }
        return num;
    }
    
    class func getStringByName(_ name: String)-> String {
        return NSLocalizedString(name, comment: "");
    }
}

class CodeMap {
    
    public static let COMMON_ERROR_CODE = -1;
    
}
