//
//  SetAccountModel.swift
//  iOSDataDisplay
//
//  Created by Flora on 2020/4/13.
//  Copyright © 2020年 yinmeng. All rights reserved.
//

struct SetAccountModel : Codable {
    
    var Code: Int
    var Action: String
    var ObjT: String
   
    init(code: Int, action: String, objt: String) {
        Code = code
        Action = action
        ObjT = objt
    }
}
