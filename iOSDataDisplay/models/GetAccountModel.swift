//
//  GetAccountModel.swift
//  iOSDataDisplay
//
//  Created by Flora on 2020/4/13.
//  Copyright © 2020年 yinmeng. All rights reserved.
//

struct GetAccountModel : Codable {
    
    var Code: Int
    var Action: String
    var ObjT: Account
    
    struct Account : Codable {
        var Name: String
        var Department: String
        var Role: String
        var Email: String
        var Phone: String
        
        init(name:String, dept:String, role:String, email:String, phone:String) {
            Name = name
            Department = dept
            Role = role
            Email = email
            Phone = phone
        }
    }
    
    init(code:Int, action:String, objt: Account) {
        Code = code
        Action = action
        ObjT = objt
    }
}
