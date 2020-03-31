//
//  Cookie.swift
//  iOSDataDisplay
//
//  Created by Flora on 2020/4/1.
//  Copyright © 2020年 yinmeng. All rights reserved.
//

import Foundation
import Alamofire

public func getAuthHeader(username: String, password: String) -> String {
    let auth = username + ":" + password
    let authHeader = "Basic " + auth.toBase64()!
    return authHeader
}
