//
//  EmailViewController.swift
//  iOSDataDisplay
//
//  Created by Flora on 2020/4/12.
//  Copyright © 2020年 yinmeng. All rights reserved.
//

import UIKit
import Alamofire

class EmailViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet var wapper: UIView!
    
    var header: UIView!
    var backButton: BackButton!
    
    var userTextField: UITextField!
    var pwdTextField: UITextField!
    var emailTextField: UITextField!
    var modifyButton: UIButton!
    
    var height: CGFloat = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initial()
    }
    
    func initial() {
        wapper.backgroundColor = Colors.graybackground
        drawHeader()
        drawBoxs()
    }
    
    func drawHeader() {
        header = UIView(frame: CGRect(x: 0, y: 0, width: mainSize.width, height: 50))
        header.backgroundColor = Colors.blueBackground
        wapper.addSubview(header)
        
        // 返回键
        backButton = BackButton(frame: CGRect(x: 0, y: 0, width: 100, height: 50))
        backButton.setImage(Icons.left.iconFontImage(fontSize: 30, color: .white), for: .normal)
        backButton.setTitle("返回", for: .normal)
        backButton.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        backButton.addTarget(self, action: #selector(back), for: .touchUpInside)
        
        // 标题
        let title = UILabel(frame: CGRect(x: mainSize.width*0.5-75, y: 10, width: 150, height: 30))
        header.addSubview(backButton)
        title.textColor = .white
        title.text = "修改绑定邮箱"
        title.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        title.textAlignment = .center
        header.addSubview(title)
        
        height = header.frame.maxY
    }
    
    func drawBoxs() {
        // 账号输入框
        drawUserBox()
        // 密码输入框
        drawPwdBox()
        // 新邮箱输入框
        drawNewEmailBox()
        // 确认修改按钮
        drawModifyButton()
    }
    
    func drawUserBox() {
        // 留白
        let whiteView = UIView(frame: CGRect(x: 0, y: height, width: mainSize.width, height: 5))
        wapper.addSubview(whiteView)
        height = whiteView.frame.maxY
        
        // 总容器
        let userBox = UIView(frame: CGRect(x: 0, y: height, width: mainSize.width, height: 56))
        wapper.addSubview(userBox)
        height = userBox.frame.maxY
        
        // 账号
        let label = UILabel(frame: CGRect(x: 15, y: 13, width: 120, height: 30))
        label.textColor = Colors.minetextgray
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        label.text = "账号"
        userBox.addSubview(label)
        
        // 用户名输入
        userTextField = UITextField(frame: CGRect(x: 120, y: 6, width: 220, height:44))
        userTextField.delegate = self
        userTextField.placeholder = UserDefaults.standard.string(forKey: "userEmail")
        userTextField.isUserInteractionEnabled = false
        userBox.addSubview(userTextField)
        
        wapper.addSubview(drawLineView(x: 15, y:height-0.5, width: mainSize.width-0.5, height: 0.5, color: Colors.minelinegray))
    }
    
    func drawPwdBox() {
        // 总容器
        let pwdBox = UIView(frame: CGRect(x: 0, y: height, width: mainSize.width, height: 56))
        wapper.addSubview(pwdBox)
        height = pwdBox.frame.maxY
        
        // 密码
        let label = UILabel(frame: CGRect(x: 15, y: 13, width: 120, height: 30))
        label.textColor = .black
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        label.text = "密码"
        pwdBox.addSubview(label)
        
        // 密码输入框
        pwdTextField = UITextField(frame: CGRect(x: 120, y: 6, width: 220, height:44))
        pwdTextField.delegate = self
        pwdTextField.isSecureTextEntry = PwdStatus.INVISIBLE
        pwdTextField.rightView = UIView(frame: CGRect(x: 0, y: 0, width: 44, height: 44))
        pwdTextField.rightViewMode = UITextField.ViewMode.always
        pwdTextField.placeholder = "请输入密码"
        
        // 密码输入框右侧图标
        let imgRightPwd = UIButton(frame: CGRect(x: 0, y: 0, width: 44, height: 44))
        imgRightPwd.setImage(Icons.eyeCloseIcon.iconFontImage(fontSize: 22, color: Colors.minetextgray), for: .normal)
        imgRightPwd.addTarget(self, action: #selector(changeEye(sender:)), for: .touchUpInside)
        pwdTextField.rightView!.addSubview(imgRightPwd)
        pwdBox.addSubview(pwdTextField)
        
        wapper.addSubview(drawLineView(x: 15, y:height-0.5, width: mainSize.width-0.5, height: 0.5, color: Colors.minelinegray))
    }
    
    func drawNewEmailBox() {
        // 总容器
        let emailBox = UIView(frame: CGRect(x: 0, y: height, width: mainSize.width, height: 56))
        wapper.addSubview(emailBox)
        height = emailBox.frame.maxY
        
        // 新邮箱
        let label = UILabel(frame: CGRect(x: 15, y: 13, width: 120, height: 30))
        label.textColor = .black
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        label.text = "新邮箱"
        emailBox.addSubview(label)
        
        //新手机输入
        emailTextField = UITextField(frame: CGRect(x: 120, y: 6, width: 220, height:44))
        emailTextField.delegate = self
        emailTextField.isSecureTextEntry = PwdStatus.VISIBLE
        emailTextField.placeholder = "请输入新邮箱"
        emailBox.addSubview(emailTextField)
        
        wapper.addSubview(drawLineView(x: 15, y:height-0.5, width: mainSize.width-0.5, height: 0.5, color: Colors.minelinegray))
    }
    
    func drawModifyButton() {
        // 登陆按钮
        modifyButton = UIButton(frame: CGRect(x: 50, y: height+35, width: mainSize.width-100, height: 44))
        modifyButton.setTitleColor(.white, for: .normal)
        modifyButton.setTitle("提交修改", for: .normal)
        modifyButton.setTitleFontSize(size: 17)
        modifyButton.setBackgroundColor(color: Colors.blueBackground, forState: .normal)
        modifyButton.layer.cornerRadius = 22
        // 设置corner无效，因为设置了背景色（corner对subview无效）
        modifyButton.layer.masksToBounds = true
        modifyButton.addTarget(self, action: #selector(modify(sender:)), for: .touchUpInside)
        wapper.addSubview(modifyButton)
    }
    
    @objc func changeEye(sender: UIButton) {
        // 当前可见
        if (pwdTextField.isSecureTextEntry == PwdStatus.VISIBLE) {
            pwdTextField.isSecureTextEntry = PwdStatus.INVISIBLE
            sender.setImage(Icons.eyeCloseIcon.iconFontImage(fontSize: 22, color: Colors.minetextgray), for: .normal)
        }
            // 当前不可见
        else {
            pwdTextField.isSecureTextEntry = PwdStatus.VISIBLE
            sender.setImage(Icons.eyeIcon.iconFontImage(fontSize: 22, color: Colors.minetextgray), for: .normal)
        }
    }
    
    @objc func back(sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func modify(sender: UIButton) {
        if pwdTextField.text!.isEmpty {
            showMsgbox(_message: "密码不能为空")
        }
        else if emailTextField.text!.isEmpty {
            showMsgbox(_message: "新邮箱不能为空")
        }
        else if !emailTextField.text!.isEmail() {
            showMsgbox(_message: "新邮箱不符合格式")
        }
        else {
            let header: HTTPHeaders = [
                "Cookie": getSession()!,
                "Content-Type": "application/x-www-form-urlencoded"
            ]
            let parameters = [
                "email": getEmailFromCookie()!,
                "passwd": pwdTextField.text!,
                "new_email": emailTextField.text!
            ]
            Alamofire.request(setAccountUrl, method: .post, parameters: parameters, headers: header).responseJSON {
                response in
                if response.result.isSuccess {
                    // cookie 无效
                    if (response.response?.statusCode != 200) {
                        self.jumpLoginbox(_message: "修改失败，登录过期，请重新登录。")
                    }
                        // cookie 有效，登录成功
                    else {
                        // print(response)
                        let res = SetAccountDecoder.decode(jsonData: response.data!)
                        if res.Code == 0 {
                            self.pwdTextField.isUserInteractionEnabled = false
                            self.emailTextField.isUserInteractionEnabled = false
                            if (getEmailFromCookie() == getLoginName()) {
                                refreshLoginName(name: self.emailTextField.text!)
                            }
                            setEmailToCookie(email: self.emailTextField.text!)
                            self.jumpMinebox(_message: "绑定邮箱修改成功！")
                        }
                        else if res.ObjT == "Cannot match a user." {
                            self.showMsgbox(_message: "修改失败，密码错误。")
                        }
                        else {
                            self.showMsgbox(_message: "修改失败，该邮箱已被他人绑定。")
                        }
                    }
                }
                else {
                    self.showMsgbox(_message: "修改失败，网络错误，无法连接到服务器")
                }
            }
        }
    }
}
