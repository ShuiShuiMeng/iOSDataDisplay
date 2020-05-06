//
//  DepData.swift
//  iOSDataDisplay
//
//  Created by Flora on 2020/4/13.
//  Copyright © 2020年 yinmeng. All rights reserved.
//

class BarData {
    
    var name: String
    var percent: Float
    var total: Int
    var plan: Float
    var exc: Float
    
    init(name: String, percent: Float, total: Int, plan: Float, exc: Float) {
        self.name = name
        self.plan = plan
        self.percent = percent
        self.total = total
        self.exc = exc
    }
}

