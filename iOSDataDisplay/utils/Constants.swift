//
//  Constants.swift
//  iOSDataDisplay
//
//  Created by Flora on 2020/3/31.
//  Copyright © 2020年 yinmeng. All rights reserved.
//

import Foundation
import UIKit

let mainSize: CGSize = UIScreen.main.bounds.size

let baseUrl: String = "https://192.168.0.102:8088"
let getAccountUrl: String = baseUrl + "/api/getAccount"
let setAccountUrl: String = baseUrl + "/api/setAccount"
let logoutUrl: String = baseUrl + "/api/logout"
let getNumbersUrl: String = baseUrl + "/api/getOverallInfo"
let getDeptInfoUrl: String = baseUrl + "/api/getDeptProjectsInfo"

let testUser = "12345678999"

let DeptID: [String: String] = [
    "10": "数理科学部",
    "11": "化学科学部",
    "12": "生命科学部",
    "13": "地球科学部",
    "14": "工程与材料科学部",
    "15": "信息科学部",
    "16": "管理科学部",
    "17": "医学科学部"
]
