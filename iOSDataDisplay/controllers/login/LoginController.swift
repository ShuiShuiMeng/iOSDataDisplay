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
    // x取消输入
    var cancel: UIButton!
    // 登陆按钮
    var loginButton: UIButton!
    
    var height: CGFloat = 0
    
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
                "Cookie": getSession()!
            ]
            Alamofire.request(getAccountUrl, method: .post, headers: header).responseJSON {
                response in
                if (response.result.isSuccess) {
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
                else {
                    self.initial()
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
        nsfcImage = UIImageView(frame: CGRect(x: 100, y: 80, width: mainSize.width-200, height: (mainSize.width-200)*0.66))
        nsfcImage.image = UIImage(named: "NSFC.jpg")
        view.addSubview(nsfcImage)
        height = nsfcImage.frame.maxY
    }
    
    func drawLoginButton() {
        // 登陆按钮
        loginButton = UIButton(frame: CGRect(x: 45, y: height+10, width: mainSize.width-90, height: 40))
        loginButton.setTitleColor(.white, for: .normal)
        loginButton.setTitle("登录", for: .normal)
        loginButton.setTitleFontSize(size: 16)
        loginButton.setBackgroundColor(color: Colors.loginblue, forState: .normal)
        loginButton.layer.cornerRadius = 20
        // 设置corner无效，因为设置了背景色（corner对subview无效）
        loginButton.layer.masksToBounds = true
        loginButton.addTarget(self, action: #selector(login), for: .touchUpInside)
        view.addSubview(loginButton)
    }
    
    func drawLoginBox() {
        // 登录框背景
        vLogin = UIView(frame: CGRect(x:15, y:height+10, width:mainSize.width-30, height:160))
        vLogin.backgroundColor = UIColor.white
        view.addSubview(vLogin)
        height = vLogin.frame.maxY
    }
    
    func drawUserTextField() {
        // 用户名输入
        userTextField = UITextField(frame: CGRect(x:30, y:40, width:vLogin.frame.size.width-60, height:44))
        userTextField.delegate = self
        userTextField.rightView = UIView(frame: CGRect(x: 0, y: 0, width: 44, height: 44))
        userTextField.rightViewMode = UITextField.ViewMode.always
        userTextField.placeholder = "手机号或邮箱"
        if (getLoginName() != nil) {
            userTextField.text = getLoginName()!
        }
        
        // 右侧
        cancel = UIButton(frame: CGRect(x: 11, y: 11, width: 22, height: 22))
        cancel.setImage(Icons.cancel.iconFontImage(fontSize: 20, color: .gray), for: .normal)
        cancel.addTarget(self, action: #selector(cancelText(sender:)), for: .touchUpInside)
        userTextField.rightView!.addSubview(cancel)
        // 检测变化
        userTextField.addTarget(self, action: #selector(openCancel), for: .editingChanged)
        // 取消标志
        cancel.isHidden = userTextField.text!.count == 0
        vLogin.addSubview(userTextField)
        vLogin.addSubview(drawLineView(x: 30, y: 83.5, width: vLogin.frame.size.width-60, height: 0.5, color: Colors.lineGray))
    }
    
    func drawPwdTextField() {
        // 密码输入框
        pwdTextField = UITextField(frame: CGRect(x:30, y:95, width:vLogin.frame.size.width-60, height:44))
        pwdTextField.delegate = self
        pwdTextField.isSecureTextEntry = PwdStatus.INVISIBLE
        pwdTextField.rightView = UIView(frame: CGRect(x: 0, y: 0, width: 44, height: 44))
        pwdTextField.rightViewMode = UITextField.ViewMode.always
        pwdTextField.placeholder = "请输入登录密码"
        
        // 密码输入框右侧图标
        let imgRightPwd = UIButton(frame: CGRect(x: 11, y: 11, width: 22, height: 22))
        imgRightPwd.setImage(Icons.eyeCloseIcon.iconFontImage(fontSize: 20, color: .gray), for: .normal)
        imgRightPwd.addTarget(self, action: #selector(changeEye(sender:)), for: .touchUpInside)
        pwdTextField.rightView!.addSubview(imgRightPwd)
        vLogin.addSubview(pwdTextField)
        vLogin.addSubview(drawLineView(x: 30, y: 137.5, width: vLogin.frame.size.width-60, height: 0.5, color: Colors.lineGray))
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
    
    @objc func login(sender: UIButton) {
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
                // print(response)
                if (response.response?.statusCode != 200) {
                    self?.showMsgbox(_message: "用户名密码错误")
                }
                else if (response.result.isSuccess) {
                    if (response.result.value! is NSNull) {
                        self?.showMsgbox(_message: "您的账号权限类型为 Admin，不能用于登录 APP。请联系管理员修改权限。")
                    }
                    // 200 用户名密码正确
                    else if response.response?.statusCode == 200 {
                        // 存取session到cookie中
                        let headerFields = response.response?.allHeaderFields as! [String: String]
                        refreshSession(session: headerFields["Set-Cookie"])
                        refreshUser(resData: response.data!)
                        refreshLoginName(name: (self?.userTextField.text)!)
                        self?.jumpToIndex()
                    }
                }
                else {
                    self?.showMsgbox(_message: "网络错误，连接不到服务器")
                }
            }
        }
        else {
            showMsgbox(_message: "输入的账号不符合格式，请输入正确的手机号或邮箱")
        }
    }
    
    @objc func cancelText(sender: UIButton) {
        userTextField.text = ""
        cancel.isHidden = true
    }
    
    @objc func openCancel() {
        cancel.isHidden = userTextField.text!.count == 0
    }
    
    func jumpToIndex() {
        let tbVC = self.storyboard?.instantiateViewController(withIdentifier: "TabBarViewController") as! UITabBarController
        tbVC.modalPresentationStyle = .fullScreen
        self.present(tbVC, animated: true, completion: nil)
    }
    
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        /*
        if userTextField == textField {
            // 限制只能输入数字
            let length = string.lengthOfBytes(using: .utf8)
            for loopIndex in 0..<length {
                let char = (string as NSString).character(at: loopIndex)
                if char < 48 || char > 57 {
                    return false
                }
            }
            // 限制长度
            let proposeLength = (textField.text?.lengthOfBytes(using: .utf8))! - range.length + string.lengthOfBytes(using: .utf8)
            if proposeLength > 11 {
                return false
            }
        }*/
        if pwdTextField == textField {
            // do
        }
        return true
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


