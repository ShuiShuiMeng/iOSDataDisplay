//
//  LoginController.swift
//  iOSDataDisplay
//
//  Created by Flora on 2020/3/30.
//  Copyright © 2020年 yinmeng. All rights reserved.
//

import UIKit
import Alamofire

class LoginController: UIViewController, UITextFieldDelegate {
    // 顶部栏
    var topBar: UINavigationBar!
    // 图标
    var nsfcImage: UIImageView!
    // 输入框
    var vLogin: UIView!
    var userTextField: UITextField!
    var pwdTextField: UITextField!

    // 登陆按钮
    var loginButton: UIButton!
    
    // 屏幕size
    // var mainSize: CGSize!
    
    // 登录框状态
    var showType: LoginShowType = LoginShowType.NONE
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 免证书Alamofire
        let manager = SessionManager.default
        manager.delegate.sessionDidReceiveChallenge = {
            session, challenge in
            return (URLSession.AuthChallengeDisposition.useCredential, URLCredential(trust: challenge.protectionSpace.serverTrust!))
        }
        // 异步获取 判断登录状态
        //self.showMsgbox(_message: UserDefaults.standard.string(forKey: "__session")!)
        //print(UserDefaults.standard.string(forKey: "__session")!)
        // 检查是否有session, 如果没有cookie直接开始登录页面
        if UserDefaults.standard.string(forKey: "__session") == nil {
            initial()
        }
        // 有cookie的时候，发送验证
        else {
            let header: HTTPHeaders = [
                "Cookie": UserDefaults.standard.string(forKey: "__session")!
            ]
            Alamofire.request(getAccountUrl, method: .post, headers: header).responseJSON {
                response in
                // cookie 无效
                if (response.response?.statusCode != 200) {
                    self.initial()
                }
                // cookie 有效，登录成功
                else {
                    refreshUser(resData: response.data!)
                    self.jumpToIndex()
                }
            }
        }
    }
    
    func initial() {
        drawTopBar()
        drawNSFC()
        drawLoginBox()
        drawUserTextField()
        drawPwdTextField()
        drawLoginButton()
    }
    
    func drawTopBar() {
        topBar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: mainSize.width, height: 44))
        
    }
    
    func drawNSFC() {
        // 顶部图标 14.11 10.58
        nsfcImage = UIImageView(frame: CGRect(x: 125, y: 80, width: mainSize.width-250, height: (mainSize.width-250)*0.75))
        nsfcImage.image = UIImage(named: "NSFC.jpeg")
        self.view.addSubview(nsfcImage)
    }
    
    func drawLoginButton() {
        // 登陆按钮
        loginButton = UIButton(frame: CGRect(x: 45, y: 370, width: mainSize.width-90, height: 40))
        loginButton.setTitleColor(.white, for: .normal)
        loginButton.setTitle("登录", for: .normal)
        loginButton.setTitleFontSize(size: 16)
        loginButton.setBackgroundColor(color: .blue, forState: .normal)
        loginButton.layer.cornerRadius = 5
        // 设置corner无效，因为设置了背景色（corner对subview无效）
        loginButton.layer.masksToBounds = true
        loginButton.addTarget(self, action: #selector(tapToIndex), for: .touchUpInside)
        self.view.addSubview(loginButton)
    }
    
    func drawLoginBox() {
        // 登录框背景
        vLogin = UIView(frame: CGRect(x:15, y:200, width:mainSize.width-30, height:160))
        vLogin.backgroundColor = UIColor.white
        self.view.addSubview(vLogin)
    }
    
    func drawUserTextField() {
        // 用户名输入
        userTextField = UITextField(frame: CGRect(x:30, y:30, width:vLogin.frame.size.width-60, height:44))
        userTextField.delegate = self
        userTextField.layer.cornerRadius = 5
        userTextField.layer.borderColor = UIColor.lightGray.cgColor
        userTextField.layer.borderWidth = 0.5
        userTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 44, height: 44))
        userTextField.leftViewMode = UITextField.ViewMode.always
        userTextField.placeholder = "手机号或邮箱"
        if (getLoginName() != nil) {
            userTextField.text = getLoginName()!
        }
        
        // 用户名输入框左侧图标
        let imgUser = UIImageView(frame: CGRect(x: 11, y: 11, width: 22, height: 22))
        imgUser.image = Icons.userIcon.iconFontImage(fontSize: 20, color: .gray)
        userTextField.leftView!.addSubview(imgUser)
        vLogin.addSubview(userTextField)
    }
    
    func drawPwdTextField() {
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
        pwdTextField.placeholder = "密码"
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
        if textField.isEqual(userTextField) {
            // 用以判断从哪里切换过来，留用添加功能
            if (showType != LoginShowType.PASS) {
                showType = LoginShowType.PASS
                return
            }
            showType = LoginShowType.USER
            // Do Something
        }
        // 密码输入
        else if textField.isEqual(pwdTextField) {
            if (showType != LoginShowType.USER) {
                showType = LoginShowType.PASS
                return
            }
            showType = LoginShowType.PASS
        }
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
    
    @objc func tapToIndex(sender: UIButton) {
        if (userTextField.text!.isEmpty && pwdTextField.text!.isEmpty) {
            showMsgbox(_message: "账号和密码不能为空")
            //jumpToIndex()
            //UserDefaults.standard.set(testUser, forKey: "username")
        }
        else if (userTextField.text!.isEmpty) {
            showMsgbox(_message: "账号不能为空")
        }
        else if (pwdTextField.text!.isEmpty) {
            showMsgbox(_message: "密码不能为空")
        }
        // 符合格式，开始登录
        else if userTextField.text!.isPhoneNumber() || userTextField.text!.isEmail() {
            let authHeader = getAuthHeader(username: userTextField.text!, password: pwdTextField.text!)
            // 跳转到登录页面说明一定需要header，且header中不需要带session
            let header: HTTPHeaders = [
                "Authorization": authHeader
            ]
            Alamofire.request(getAccountUrl, method: .post, headers: header).responseJSON  {
                [weak self] response in // weakSelf防止self混乱
                // 返回null admin用户
                if (response.result.value! is NSNull) {
                    self?.showMsgbox(_message: "您的用户是电脑端账户，不能用于登录App。请使用拥有权限的账户登录App。")
                }
                // 401 用户名密码错误
                else if (response.response?.statusCode != 200) {
                    self?.showMsgbox(_message: "用户名密码错误，请重新输入")
                }
                // 200 用户名密码正确
                else {
                    // 存取session到cookie中
                    let headerFields = response.response?.allHeaderFields as! [String: String]
                    refreshSession(session: headerFields["Set-Cookie"])
                    refreshUser(resData: response.data!)
                    refreshLoginName(name: (self?.userTextField.text)!)
                    self?.jumpToIndex()
                }
            }
        }
        else {
            showMsgbox(_message: "账号不符合格式，请输入手机号或邮箱")
        }
    }
    
    func jumpToIndex() {
        let tbVC = self.storyboard?.instantiateViewController(withIdentifier: "TabBarViewController") as! UITabBarController
        self.present(tbVC, animated: true, completion: nil)
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


