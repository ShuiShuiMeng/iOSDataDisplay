//
//  Cookies.swift
//  iOSDataDisplay
//
//  Created by Flora on 2020/4/13.
//  Copyright © 2020年 yinmeng. All rights reserved.
//

import Foundation

public func refreshLoginName(name: String) {
    UserDefaults.standard.set(name, forKey: "loginName")
}

public func getLoginName() -> String? {
    return UserDefaults.standard.string(forKey: "loginName")
}

public func refreshUser(resData: Data) {
    let UserInfo = GetAccountDecoder.decode(jsonData: resData).ObjT
    UserDefaults.standard.set(UserInfo.Name, forKey: "userName")
    UserDefaults.standard.set(UserInfo.Department, forKey: "userDepartment")
    UserDefaults.standard.set(UserInfo.Role, forKey: "userRole")
    UserDefaults.standard.set(UserInfo.Phone, forKey: "userPhone")
    UserDefaults.standard.set(UserInfo.Email, forKey: "userEmail")
}

public func getNameFromCookie() -> String? {
    return UserDefaults.standard.string(forKey: "userName")
}

public func getDepartmentFromCookie() -> String? {
    return UserDefaults.standard.string(forKey: "userDepartment")
}

public func getRoleFromCookie() -> String? {
    return UserDefaults.standard.string(forKey: "userRole")
}

public func setPhoneToCookie(phone: String) {
    UserDefaults.standard.set(phone, forKey: "userPhone")
}

public func getPhoneFromCookie() -> String? {
    return UserDefaults.standard.string(forKey: "userPhone")
}

public func setEmailToCookie(email: String) {
    UserDefaults.standard.set(email, forKey: "userEmail")
}

public func getEmailFromCookie() -> String? {
    return UserDefaults.standard.string(forKey: "userEmail")
}

public func refreshSession(session: String?) {
    UserDefaults.standard.set(session, forKey: "__session")
}

public func getSession() -> String? {
    return UserDefaults.standard.string(forKey: "__session")
}

public func clearSession() {
    UserDefaults.standard.set(nil, forKey: "__session")
}
