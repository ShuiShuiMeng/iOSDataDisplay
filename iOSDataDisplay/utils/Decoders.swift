//
//  GetAccount.swift
//  iOSDataDisplay
//
//  Created by Flora on 2020/4/13.
//  Copyright © 2020年 yinmeng. All rights reserved.
//

import Foundation

class GetAccountDecoder {
    static func decode(jsonData: Data) -> GetAccountModel {
        let decoder = JSONDecoder()
        let result = try! decoder.decode(GetAccountModel.self, from: jsonData)
        return result
    }
}

class SetAccountDecoder {
    static func decode(jsonData: Data) -> SetAccountModel {
        let decoder = JSONDecoder()
        let result = try! decoder.decode(SetAccountModel.self, from: jsonData)
        return result
    }
}

class GetAllDecoder {
    static func decode(jsonData: Data) -> GetAllModel {
        let decoder = JSONDecoder()
        let result = try! decoder.decode(GetAllModel.self, from: jsonData)
        return result
    }
}

class GetDeptInfoDecoder {
    static func decode(jsonData: Data) -> GetDeptInfoModel {
        let dic = try! JSONSerialization.jsonObject(with: jsonData, options: .allowFragments) as! [String:Any]
        let dicObjT = dic["ObjT"] as! NSDictionary
        let nslist = dicObjT["DeptProjectInfoList"] as! NSArray
        // 解码数组元素
        var list: [GetDeptInfoModel.resObj.Projects] = []
        for item in nslist {
            let tmp = item as! NSDictionary
            list.append(GetDeptInfoModel.resObj.Projects(
                name: tmp["Name"] as! String,
                approvedItems: (tmp["ApprovedItems"] as! NSNumber).intValue,
                fundding: (tmp["Funding"] as! NSNumber).floatValue,
                limit: (tmp["Limit"] as! NSNumber).floatValue
            ))
        }
        
        let objt = GetDeptInfoModel.resObj(
            total: (dicObjT["TotalProjects"] as! NSNumber).intValue,
            list: list
        )
        
        return GetDeptInfoModel(
            code: (dic["Code"] as! NSNumber).intValue,
            action: dic["Action"] as! String,
            obj: objt
        )
    }
}

class GetProjectsInfoDecoder {
    static func decode(jsonData: Data) -> GetProjectsModel {
        let dic = try! JSONSerialization.jsonObject(with: jsonData, options: .allowFragments) as! [String:Any]
        let dicObjT = dic["ObjT"] as! NSDictionary
        let nslist = dicObjT["ProjectInfoList"] as! NSArray
        // 解码数组元素
        var list: [GetProjectsModel.resObj.ProjectsInfo] = []
        for item in nslist {
            let tmp = item as! NSDictionary
            list.append(GetProjectsModel.resObj.ProjectsInfo(
                name: tmp["Name"] as! String,
                items: (tmp["Items"] as! NSNumber).intValue,
                total: (tmp["TotalOfPlan"] as! NSNumber).floatValue,
                quota: (tmp["ExeQuota"] as! NSNumber).floatValue,
                rate: (tmp["ExeRate"] as! NSNumber).floatValue
            ))
        }
        let objt = GetProjectsModel.resObj(
            total: (dicObjT["TotalProjects"] as! NSNumber).intValue,
            list: list
        )
        return GetProjectsModel(
            code: (dic["Code"] as! NSNumber).intValue,
            action: dic["Action"] as! String,
            obj: objt
        )
    }
}
