//
//  HttpUtil.swift
//  ChongqingTravel
//
//  Created by yangxue_pc on 2019/2/21.
//  Copyright © 2019年 yangxue_pc. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import EVReflection

class HttpUtil {
    public static var BASE_URL = "http://10.181.136.227:8080/CarWorld/"
    public static let alamofireVerifyManager = Alamofire.SessionManager.default;
    public static let suffix = ".do"

    
    class func sendPostRequest(url: String, jsonMsgIn: JsonMsgIn, handler: HttpHandler) {
        let aesKey = Util.randomNumber(length: 16)
        jsonMsgIn.aesKey = aesKey
        let content = SecurityTools.encryptByRSA(content: jsonMsgIn.toJsonString())
        let parameters: Parameters = setHttpParam(param: content)
        alamofireVerifyManager.request(BASE_URL + url, method: .post, parameters: parameters).responseString { response in
            if (response.result.isSuccess) {
                print("suucess")
                let json = SecurityTools.decryptByAES(key: aesKey, content: response.result.value!)
                let jsonMsgOut = JsonMsgOut(json: json)
                if jsonMsgOut.resultCode == CodeMap.COMMON_ERROR_CODE {
                    if let errorInfo = jsonMsgOut.errorInfos {
                        handler.onFail(error: errorInfo.errorMsg ?? "", code: errorInfo.getErrorCode()!)
                    } else {
                        handler.onFail(error: Util.getStringByName("http_request_error"), code: jsonMsgOut.resultCode)
                    }
                } else {
                    if let json = jsonMsgOut.obj {
                        handler.onSuccess(json: json)
                    } else {
                        if let errorInfo = jsonMsgOut.errorInfos {
                            handler.onFail(error: errorInfo.errorMsg ?? "", code: errorInfo.getErrorCode()!)
                        } else {
                            handler.onFail(error: Util.getStringByName("http_request_error"), code: jsonMsgOut.resultCode)
                        }
                    }
                }
            }else if (response.result.isFailure) {
                    handler.onFail(error: Util.getStringByName("http_default_error") + "\n" +
                        (response.result.error?.localizedDescription)!, code: CodeMap.COMMON_ERROR_CODE)
                }
        };
    }
    
    class func send(url: String, object: EVObject, handler: HttpHandler) {
        let jsonMsgIn = JsonMsgIn();
        jsonMsgIn.obj = object.toJsonString();
        sendPostRequest(url: url, jsonMsgIn: jsonMsgIn, handler: handler);
    }
    
    fileprivate class func setHttpParam(param: String)-> Parameters {
        let params: Parameters = ["jsonStr": param];
        return params;
    }
    
}

protocol HttpHandler {
    
    func onSuccess(json: String);
    
    func onFail(error: String, code: Int);
    
}
