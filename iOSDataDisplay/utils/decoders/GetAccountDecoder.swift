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

