//
//  ExFloat.swift
//  iOSDataDisplay
//
//  Created by Flora on 2020/4/4.
//  Copyright © 2020年 yinmeng. All rights reserved.
//

import Foundation

extension Float {
    var cleanZero : String {
        var str = self.truncatingRemainder(dividingBy: 1) == 0 ? String(format: "%.0f", self) : String(format: "%.2f", self)
        // 27.00002
        if str.hasSuffix(".00") {
            str = String(str.prefix(str.count-3))
        }
        // 逻辑上不可能这样 但是写出来逻辑清晰
        else if str.hasSuffix(".0") {
            str = String(str.prefix(str.count-2))
        }
        // 27.20002 防止20
        else if str.hasSuffix("0") && str.contains(".") {
            str = String(str.prefix(str.count-1))
        }
        return str
    }
    
    var cleanZero4 : String {
        var str = self.truncatingRemainder(dividingBy: 1) == 0 ? String(format: "%.0f", self) : String(format: "%.4f", self)
        // 27.00002
        if str.hasSuffix(".0000") {
            str = String(str.prefix(str.count-5))
        }
        // 27.2000
        else if str.hasSuffix("000") && str.contains(".") {
            str = String(str.prefix(str.count-3))
        }
            
        else if str.hasSuffix("00") && str.contains(".") {
            str = String(str.prefix(str.count-2))
        }
            
        // 27.20
        else if str.hasSuffix("0") && str.contains(".") {
            str = String(str.prefix(str.count-1))
        }
        return str
    }
}
