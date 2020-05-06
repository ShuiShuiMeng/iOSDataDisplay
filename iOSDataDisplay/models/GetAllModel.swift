//
//  GetAllModel.swift
//  iOSDataDisplay
//
//  Created by Flora on 2020/4/13.
//  Copyright © 2020年 yinmeng. All rights reserved.
//

struct GetAllModel : Codable {
    
    var Code: Int
    var Action: String
    var ObjT: AllInfo
    
    struct AllInfo : Codable {
        var Budget: Float
        var TotalOfPlan: Float
        var ExeQuota: Float
        var ExeRate: Float
        
        init(budget: Float, total: Float, quota: Float, rate: Float) {
            Budget = budget
            TotalOfPlan = total
            ExeQuota = quota
            ExeRate = rate
        }
    }
    
    init(code: Int, action: String, objt: AllInfo) {
        Code = code
        Action = action
        ObjT = objt
    }
}
