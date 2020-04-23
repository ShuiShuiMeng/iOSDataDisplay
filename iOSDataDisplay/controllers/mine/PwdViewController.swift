//
//  PwdViewController.swift
//  iOSDataDisplay
//
//  Created by Flora on 2020/4/12.
//  Copyright © 2020年 yinmeng. All rights reserved.
//

import UIKit
import Alamofire

class PwdViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet var wapper: UIView!
    
    var header: UIView!
    var backButton: BackButton!
    
    var modifyBox: UIView!
    var userTextField: UITextField!
    var pwdTextField: UITextField!
    var newPwdTextField1: UITextField!
    var newPwdTextField2: UITextField!
    
    var modifyButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initial()
    }
    
    func initial() {
        wapper.backgroundColor = Colors.graybackground
        drawHeader()
        drawBox()
    }
    
    func drawHeader() {
        header = UIView(frame: CGRect(x: 0, y: 0, width: mainSize.width, height: 50))
        header.backgroundColor = Colors.blue
        // 返回键
        backButton = BackButton(frame: CGRect(x: 0, y: 0, width: 100, height: 50))
        backButton.setImage(Icons.left.iconFontImage(fontSize: 30, color: .white), for: .normal)
        backButton.addTarget(self, action: #selector(back), for: .touchUpInside)
        // 标题
        let title = UILabel(frame: CGRect(x: mainSize.width*0.5-75, y: 10, width: 150, height: 30))
        header.addSubview(backButton)
        title.textColor = .white
        title.text = "修改密码"
        title.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        title.textAlignment = .center
        header.addSubview(title)
        wapper.addSubview(header)
    }
    
    func drawBox() {
        // 框背景
        modifyBox = UIView(frame: CGRect(x:15, y:80, width:mainSize.width-30, height:240))
        modifyBox.backgroundColor = Colors.graybackground
        wapper.addSubview(modifyBox)
        // 账号输入框
        drawUserTextField()
        // 密码输入框
        drawPwdTextField()
        // 新手机号输入框
        drawNewPwdTextField()
        // 确认修改
        drawModifyButton()
    }
    
    func drawUserTextField() {
        // 用户名输入
        userTextField = UITextField(frame: CGRect(x:10, y:0, width:modifyBox.frame.size.width-20, height:44))
        userTextField.delegate = self
        userTextField.layer.cornerRadius = 5
        userTextField.layer.borderColor = UIColor.lightGray.cgColor
        userTextField.layer.borderWidth = 0.5
        userTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 44, height: 44))
        userTextField.leftViewMode = UITextField.ViewMode.always
        userTextField.placeholder = getLoginName()
        userTextField.isUserInteractionEnabled = false
        
        // 用户名输入框左侧图标
        let imgUser = UIImageView(frame: CGRect(x: 11, y: 11, width: 22, height: 22))
        imgUser.image = Icons.userIcon.iconFontImage(fontSize: 20, color: .gray)
        userTextField.leftView!.addSubview(imgUser)
        modifyBox.addSubview(userTextField)
    }
    
    func drawPwdTextField() {
        // 密码输入框
        pwdTextField = UITextField(frame: CGRect(x:10, y:64, width:modifyBox.frame.size.width-20, height:44))
        pwdTextField.delegate = self
        pwdTextField.layer.cornerRadius = 5
        pwdTextField.layer.borderColor = UIColor.lightGray.cgColor
        pwdTextField.layer.borderWidth = 0.5
        pwdTextField.isSecureTextEntry = PwdStatus.INVISIBLE
        pwdTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 44, height: 44))
        pwdTextField.leftViewMode = UITextField.ViewMode.always
        pwdTextField.rightView = UIView(frame: CGRect(x: 0, y: 0, width: 44, height: 44))
        pwdTextField.rightViewMode = UITextField.ViewMode.always
        pwdTextField.placeholder = "请输入密码"
        // 密码输入框左侧图标
        let imgLeftPwd = UIImageView(frame: CGRect(x: 11, y: 11, width: 22, height: 22))
        imgLeftPwd.image = Icons.pwdIcon.iconFontImage(fontSize: 20, color: .gray)
        pwdTextField.leftView!.addSubview(imgLeftPwd)
        
        // 密码输入框右侧图标
        // let imgRightPwd = UIImageView(frame: CGRect(x: 11, y: 11, width: 22, height: 22))
        let imgRightPwd = UIButton(frame: CGRect(x: 11, y: 11, width: 22, height: 22))
        imgRightPwd.setImage(Icons.eyeCloseIcon.iconFontImage(fontSize: 20, color: .gray), for: .normal)
        imgRightPwd.addTarget(self, action: #selector(changeEye0(sender:)), for: .touchUpInside)
        // imgRightPwd.image = Icons.eyeCloseIcon.iconFontImage(fontSize: 20, color: .gray)
        pwdTextField.rightView!.addSubview(imgRightPwd)
        modifyBox.addSubview(pwdTextField)
    }
    
    func drawNewPwdTextField() {
        // 密码输入框
        newPwdTextField1 = UITextField(frame: CGRect(x:10, y:128, width:modifyBox.frame.size.width-20, height:44))
        newPwdTextField1.delegate = self
        newPwdTextField1.layer.cornerRadius = 5
        newPwdTextField1.layer.borderColor = UIColor.lightGray.cgColor
        newPwdTextField1.layer.borderWidth = 0.5
        newPwdTextField1.isSecureTextEntry = PwdStatus.INVISIBLE
        newPwdTextField1.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 44, height: 44))
        newPwdTextField1.leftViewMode = UITextField.ViewMode.always
        newPwdTextField1.rightView = UIView(frame: CGRect(x: 0, y: 0, width: 44, height: 44))
        newPwdTextField1.rightViewMode = UITextField.ViewMode.always
        newPwdTextField1.placeholder = "请输入新密码"
        // 密码输入框左侧图标
        let imgLeftPwd1 = UIImageView(frame: CGRect(x: 11, y: 11, width: 22, height: 22))
        imgLeftPwd1.image = Icons.pwdIcon.iconFontImage(fontSize: 20, color: .gray)
        newPwdTextField1.leftView!.addSubview(imgLeftPwd1)
        
        // 密码输入框右侧图标
        // let imgRightPwd = UIImageView(frame: CGRect(x: 11, y: 11, width: 22, height: 22))
        let imgRightPwd1 = UIButton(frame: CGRect(x: 11, y: 11, width: 22, height: 22))
        imgRightPwd1.setImage(Icons.eyeCloseIcon.iconFontImage(fontSize: 20, color: .gray), for: .normal)
        imgRightPwd1.addTarget(self, action: #selector(changeEye1(sender:)), for: .touchUpInside)
        // imgRightPwd.image = Icons.eyeCloseIcon.iconFontImage(fontSize: 20, color: .gray)
        newPwdTextField1.rightView!.addSubview(imgRightPwd1)
        modifyBox.addSubview(newPwdTextField1)
        
        // 密码输入框
        newPwdTextField2 = UITextField(frame: CGRect(x:10, y:192, width:modifyBox.frame.size.width-20, height:44))
        newPwdTextField2.delegate = self
        newPwdTextField2.layer.cornerRadius = 5
        newPwdTextField2.layer.borderColor = UIColor.lightGray.cgColor
        newPwdTextField2.layer.borderWidth = 0.5
        newPwdTextField2.isSecureTextEntry = PwdStatus.INVISIBLE
        newPwdTextField2.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 44, height: 44))
        newPwdTextField2.leftViewMode = UITextField.ViewMode.always
        newPwdTextField2.rightView = UIView(frame: CGRect(x: 0, y: 0, width: 44, height: 44))
        newPwdTextField2.rightViewMode = UITextField.ViewMode.always
        newPwdTextField2.placeholder = "请再次输入新密码"
        // 密码输入框左侧图标
        let imgLeftPwd2 = UIImageView(frame: CGRect(x: 11, y: 11, width: 22, height: 22))
        imgLeftPwd2.image = Icons.pwdIcon.iconFontImage(fontSize: 20, color: .gray)
        newPwdTextField2.leftView!.addSubview(imgLeftPwd2)
        
        // 密码输入框右侧图标
        // let imgRightPwd = UIImageView(frame: CGRect(x: 11, y: 11, width: 22, height: 22))
        let imgRightPwd2 = UIButton(frame: CGRect(x: 11, y: 11, width: 22, height: 22))
        imgRightPwd2.setImage(Icons.eyeCloseIcon.iconFontImage(fontSize: 20, color: .gray), for: .normal)
        imgRightPwd2.addTarget(self, action: #selector(changeEye2(sender:)), for: .touchUpInside)
        // imgRightPwd.image = Icons.eyeCloseIcon.iconFontImage(fontSize: 20, color: .gray)
        newPwdTextField2.rightView!.addSubview(imgRightPwd2)
        modifyBox.addSubview(newPwdTextField2)
    }
    
    func drawModifyButton() {
        // 登陆按钮
        modifyButton = UIButton(frame: CGRect(x: 20, y: 340, width: mainSize.width-40, height: 40))
        modifyButton.setTitleColor(.white, for: .normal)
        modifyButton.setTitle("提交修改", for: .normal)
        modifyButton.setTitleFontSize(size: 16)
        modifyButton.setBackgroundColor(color: Colors.blue, forState: .normal)
        modifyButton.layer.cornerRadius = 5
        // 设置corner无效，因为设置了背景色（corner对subview无效）
        modifyButton.layer.masksToBounds = true
        modifyButton.addTarget(self, action: #selector(modify(sender:)), for: .touchUpInside)
        wapper.addSubview(modifyButton)
    }
    
    @objc func changeEye0(sender: UIButton) {
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
    
    @objc func changeEye1(sender: UIButton) {
        // 当前可见
        if (newPwdTextField1.isSecureTextEntry == PwdStatus.VISIBLE) {
            newPwdTextField1.isSecureTextEntry = PwdStatus.INVISIBLE
            sender.setImage(Icons.eyeCloseIcon.iconFontImage(fontSize: 20, color: .gray), for: .normal)
        }
            // 当前不可见
        else {
            newPwdTextField1.isSecureTextEntry = PwdStatus.VISIBLE
            sender.setImage(Icons.eyeIcon.iconFontImage(fontSize: 20, color: .gray), for: .normal)
        }
    }
    
    @objc func changeEye2(sender: UIButton) {
        // 当前可见
        if (newPwdTextField2.isSecureTextEntry == PwdStatus.VISIBLE) {
            newPwdTextField2.isSecureTextEntry = PwdStatus.INVISIBLE
            sender.setImage(Icons.eyeCloseIcon.iconFontImage(fontSize: 20, color: .gray), for: .normal)
        }
            // 当前不可见
        else {
            newPwdTextField2.isSecureTextEntry = PwdStatus.VISIBLE
            sender.setImage(Icons.eyeIcon.iconFontImage(fontSize: 20, color: .gray), for: .normal)
        }
    }
    
    @objc func modify(sender: UIButton) {
        if (newPwdTextField1.text! != newPwdTextField2.text!) {
            showMsgbox(_message: "两次输入的新密码不同，请检查后再试")
        }
        else if (newPwdTextField1.text!.count < 6) {
            showMsgbox(_message: "密码长度大于六位")
        }
        else {
            let header: HTTPHeaders = [
                "Cookie": getSession()!,
                "Content-Type": "application/x-www-form-urlencoded"
            ]
            let parameters = [
                "phone": getPhoneFromCookie()!,
                "passwd": pwdTextField.text!,
                "new_passwd": newPwdTextField1.text!
            ]
            Alamofire.request(setAccountUrl, method: .post, parameters: parameters, headers: header).responseJSON {
                response in
                if response.result.isSuccess {
                    // cookie 无效
                    if (response.response?.statusCode != 200) {
                        self.jumpLoginbox(_message: "修改失败，登录权限过期，请重新登录")
                    }
                        // cookie 有效，登录成功
                    else {
                        // print(response)
                        let res = SetAccountDecoder.decode(jsonData: response.data!)
                        if res.Code == 0 {
                            self.pwdTextField.isUserInteractionEnabled = false
                            self.newPwdTextField1.isUserInteractionEnabled = false
                            self.newPwdTextField2.isUserInteractionEnabled = false
                            self.jumpMinebox(_message: "修改成功！")
                        }
                        else {
                            self.showMsgbox(_message: "修改失败，请重试")
                        }
                    }
                }
                else {
                    self.showMsgbox(_message: "修改失败，网络错误，无法连接到服务器")
                }
            }
        }
    }
    
    @objc func back(sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }

}
