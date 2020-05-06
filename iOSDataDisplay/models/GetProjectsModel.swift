//
//  GetProjectsModel.swift
//  iOSDataDisplay
//
//  Created by Flora on 2020/4/13.
//  Copyright © 2020年 yinmeng. All rights reserved.
//

struct GetProjectsModel {
    
    var Code: Int
    var Action: String
    var ObjT: resObj
    
    struct resObj {
        var TotalProjects: Int
        var ProjectInfoList: [ProjectsInfo]
        
        struct ProjectsInfo {
            var Name: String
            var Items: Int
            var TotalOfPlan: Float
            var ExeQuota: Float
            var ExeRate: Float
            
            init(name: String, items: Int, total plan: Float, quota: Float, rate: Float) {
                Name = name
                Items = items
                TotalOfPlan = plan
                ExeQuota = quota
                ExeRate = rate
            }
        }
        
        init(total: Int, list: [ProjectsInfo]) {
            TotalProjects = total
            ProjectInfoList = list
        }
    }
    
    init(code: Int, action: String, objt: resObj) {
        Code = code
        Action = action
        ObjT = objt
    }
}
