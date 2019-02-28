//
//  JsonMsgOut.swift
//  ChongqingTravel
//
//  Created by yangxue_pc on 2019/2/22.
//  Copyright © 2019年 yangxue_pc. All rights reserved.
//

import Foundation
import EVReflection

class JsonMsgOut: BaseMsgEntity {
    
    public var resultCode = 0;
    
    public var errorInfos: ErrorInfo?;
    
    public var obj: String?;
    
}

class ErrorInfo: EVObject {
    
    public var errorCode: String?;
    
    public var errorMsg: String?;
    
    func getErrorCode() -> Int? {
        if (self.errorCode != nil) {
            let code: Int? = Int(self.errorCode!);
            return code;
        }
        return CodeMap.COMMON_ERROR_CODE;
    }
    
}
