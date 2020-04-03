//
//  ExString.swift
//  iOSDataDisplay
//
//  Created by Flora on 2020/4/1.
//  Copyright © 2020年 yinmeng. All rights reserved.
//

import Foundation

extension String {
    // base64编码
    func toBase64() -> String? {
        if let data = self.data(using: .utf8) {
            return data.base64EncodedString()
        }
        return nil
    }
    
    // base64解码
    func fromBase64() -> String? {
        if let data = Data(base64Encoded: self) {
            return String(data: data, encoding: .utf8)
        }
        return nil
    }
    
    // 判断手机号格式
    func isPhoneNumber() -> Bool {
        let phonePattern = "^((1[3-9][0-9]))\\d{8}$"
        let predicate = NSPredicate(format:"SELF MATCHES %@", phonePattern)
        return predicate.evaluate(with: self)
    }
    
    // 判断邮箱格式
    func isEmail() -> Bool {
        let emailPattern = "^[A-Z,a-z,\\d]+([-_.][A-Z,a-z,\\d]+)*@([A-Z,a-z,\\d]+[-.])+[A-Z,a-z,\\d]{2,4}"
        let predicate = NSPredicate(format: "SELF MATCHES %@", emailPattern)
        return predicate.evaluate(with: self)
    }
}
