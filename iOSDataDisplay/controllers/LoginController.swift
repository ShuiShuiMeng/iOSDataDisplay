//
//  LoginController.swift
//  iOSDataDisplay
//
//  Created by Flora on 2020/3/30.
//  Copyright © 2020年 yinmeng. All rights reserved.
//

import UIKit

class LoginController: UIViewController, UITextFieldDelegate {
    // 输入框
    var userTextField: UITextField!
    var pwdTextField: UITextField!

    // 登陆按钮
    var loginButton: UIButton!
    
    
    // 登录框状态
    var showType: LoginShowType = LoginShowType.NONE
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initial()
    }
    
    func initial() {
        let mainSize = UIScreen.main.bounds.size
        
        // 登录框背景
        let vLogin = UIView(frame: CGRect(x:15, y:200, width:mainSize.width-30, height:160))
        vLogin.backgroundColor = UIColor.white
        self.view.addSubview(vLogin)
        
        // 用户名输入
        userTextField = UITextField(frame: CGRect(x:30, y:30, width:vLogin.frame.size.width-60, height:44))
        userTextField.delegate = self
        userTextField.layer.cornerRadius = 5
        userTextField.layer.borderColor = UIColor.lightGray.cgColor
        userTextField.layer.borderWidth = 0.5
        userTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 44, height: 44))
        userTextField.leftViewMode = UITextField.ViewMode.always
        
        // 用户名输入框左侧图标
        let imgUser = UIImageView(frame: CGRect(x: 11, y: 11, width: 22, height: 22))
        imgUser.image = Icons.userIcon.iconFontImage(fontSize: 20, color: .gray)
        userTextField.leftView!.addSubview(imgUser)
        vLogin.addSubview(userTextField)
        
        // 密码输入框
        pwdTextField = UITextField(frame: CGRect(x:30, y:90, width:vLogin.frame.size.width-60, height:44))
        pwdTextField.delegate = self
        pwdTextField.layer.cornerRadius = 5
        pwdTextField.layer.borderColor = UIColor.lightGray.cgColor
        pwdTextField.layer.borderWidth = 0.5
        pwdTextField.isSecureTextEntry = PwdStatus.INVISIBLE
        pwdTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 44, height: 44))
        pwdTextField.leftViewMode = UITextField.ViewMode.always
        pwdTextField.rightView = UIView(frame: CGRect(x: 0, y: 0, width: 44, height: 44))
        pwdTextField.rightViewMode = UITextField.ViewMode.always
        
        // 密码输入框左侧图标
        let imgLeftPwd = UIImageView(frame: CGRect(x: 11, y: 11, width: 22, height: 22))
        imgLeftPwd.image = Icons.pwdIcon.iconFontImage(fontSize: 20, color: .gray)
        pwdTextField.leftView!.addSubview(imgLeftPwd)
        
        // 密码输入框右侧图标
        // let imgRightPwd = UIImageView(frame: CGRect(x: 11, y: 11, width: 22, height: 22))
        let imgRightPwd = UIButton(frame: CGRect(x: 11, y: 11, width: 22, height: 22))
        imgRightPwd.setImage(Icons.eyeCloseIcon.iconFontImage(fontSize: 20, color: .gray), for: .normal)
        imgRightPwd.addTarget(self, action: #selector(changeEye(sender:)), for: .touchUpInside)
        // imgRightPwd.image = Icons.eyeCloseIcon.iconFontImage(fontSize: 20, color: .gray)
        pwdTextField.rightView!.addSubview(imgRightPwd)
        vLogin.addSubview(pwdTextField)
    }
    
    // 输入框获取焦点开始编辑
    func textFieldDidEndEditing(_ textField: UITextField) {
        // 用户名输入
        if (textField.isEqual(userTextField)) {
            // 用以判断从哪里切换过来，留用添加功能
            if (showType != LoginShowType.PASS) {
                showType = LoginShowType.PASS
                return
            }
            showType = LoginShowType.USER
            // Do Something
        }
        // 密码输入
        else if (textField.isEqual(pwdTextField)) {
            if (showType != LoginShowType.USER) {
                showType = LoginShowType.PASS
                return
            }
            showType = LoginShowType.PASS
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @objc func changeEye(sender: UIButton) {
        // 当前可见
        if (pwdTextField.isSecureTextEntry == PwdStatus.VISIBLE) {
            pwdTextField.isSecureTextEntry = PwdStatus.INVISIBLE
            sender.setImage(Icons.eyeCloseIcon.iconFontImage(fontSize: 20, color: .gray), for: .normal)
        }
        // 当前不可见
        else {
            pwdTextField.isSecureTextEntry = PwdStatus.VISIBLE
            sender.setImage(Icons.eyeIcon.iconFontImage(fontSize: 20, color: .gray), for: .normal)
        }
    }

}

// 登录框状态枚举
enum LoginShowType {
    case NONE
    case USER
    case PASS
}

// 密码明文密文
struct PwdStatus {
    static let VISIBLE:Bool = false
    static let INVISIBLE:Bool = true
}
