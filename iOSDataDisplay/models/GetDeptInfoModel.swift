//
//  GetDeptInfoModel.swift
//  iOSDataDisplay
//
//  Created by Flora on 2020/4/13.
//  Copyright © 2020年 yinmeng. All rights reserved.
//

struct GetDeptInfoModel {
    
    var Code: Int
    var Action: String
    var ObjT: resObj
    
    struct resObj {
        var TotalProjects: Int
        var DeptProjectInfoList: [Projects]
        
        struct Projects {
            var Name: String
            var ApprovedItems: Int
            var Fundding: Float
            var Limit: Float
            var TotalLimit: Float
            
            init(name: String, approvedItems: Int, fundding: Float, limit: Float, totalLimit: Float) {
                Name = name
                ApprovedItems = approvedItems
                Fundding = fundding
                Limit = limit
                TotalLimit = totalLimit
            }
        }
        
        init(total: Int, list: [Projects]) {
            TotalProjects = total
            DeptProjectInfoList = list
        }
    }
    
    init(code: Int, action: String, objt: resObj) {
        Code = code
        Action = action
        ObjT = objt
    }
    
    func getTotalLimit() -> Float {
        var tmp: Float = 0
        for item in ObjT.DeptProjectInfoList {
            tmp = tmp + item.Limit
        }
        return tmp
    }
    
    func getTotalFundding() -> Float {
        var tmp: Float = 0
        for item in ObjT.DeptProjectInfoList {
            tmp = tmp + item.Fundding
        }
        return tmp
    }
    
    func getTotalProjects() -> Int {
        var tmp: Int = 0
        for item in ObjT.DeptProjectInfoList {
            tmp = tmp + item.ApprovedItems
        }
        return tmp;
    }
}
