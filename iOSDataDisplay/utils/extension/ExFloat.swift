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
        return self.truncatingRemainder(dividingBy: 1) == 0 ? String(format: "%.0f", self) : String(format: "%.2f", self)
    }
}
