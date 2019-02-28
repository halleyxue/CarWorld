//
//  SecurityTools.swift
//  ChongqingTravel
//
//  Created by yangxue_pc on 2019/2/21.
//  Copyright © 2019年 yangxue_pc. All rights reserved.
//

import Foundation
import SwiftyRSA
import CryptoSwift

class SecurityTools {
    fileprivate static let AES_IV = "1234567812345678";
    fileprivate static let str =    "MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCbAGDFFd0zMF4uYGgYWdxhk1n1fG4Dyad1H7qP75z5Jt+vPcSTQ3EvJWbSEjT0jMKd7ISWxgWfJdUNdXFBtSrTtnuT0vCPliTEb+QO1u+NAI/dNhV8thZwU88exMBGUmyreVCMvchLtH9D2Fj2WTlPZWZI1J1NUAuWDztBkv1VUQIDAQAB"
    
    class func encryptByAES(key: String, content: String) -> String {
        do {
            let ciphertext = try content.encryptToBase64(cipher: try AES(key: key, iv: AES_IV))
            return ciphertext!
        }catch {
            return ""
        }
    }
    
    class func decryptByAES(key: String, content: String) -> String {
        do {
            let result = try content.decryptBase64ToString(cipher: AES(key: key, iv: "1234567812345678"));
            return result;
        } catch {
            return "";
        }
    }
    
    class func encryptByRSA(content: String) -> String {
        do {
            let clear = try ClearMessage(string: content, using: .utf8);
            let publicKey = try PublicKey(pemEncoded: str);
            let encrypted = try clear.encrypted(with: publicKey, padding: .PKCS1);
            return encrypted.base64String;
        } catch {
            return "";
        }
    }
}
