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
    
    var userTextField: UITextField!
    var pwdTextField0: UITextField!
    var pwdTextField1: UITextField!
    var pwdTextField2: UITextField!
    
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
        title.text = "修改密码"
        title.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        title.textAlignment = .center
        header.addSubview(title)
        
        height = header.frame.maxY
    }
    
    func drawBoxs() {
        // 账号输入框
        drawUserBox()
        // 旧密码输入框
        drawOldPwdBox()
        // 新密码输入框
        drawNewPwdBox()
        // 确认输入框
        drawConfirmPwdBox()
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
        userTextField.placeholder = getLoginName()
        userTextField.isUserInteractionEnabled = false
        userBox.addSubview(userTextField)
        
        wapper.addSubview(drawLineView(x: 15, y:height-0.5, width: mainSize.width-0.5, height: 0.5, color: Colors.minelinegray))
    }
    
    
    func drawOldPwdBox() {
        // 总容器
        let pwdBox = UIView(frame: CGRect(x: 0, y: height, width: mainSize.width, height: 56))
        wapper.addSubview(pwdBox)
        height = pwdBox.frame.maxY
        
        // 旧密码
        let label = UILabel(frame: CGRect(x: 15, y: 13, width: 120, height: 30))
        label.textColor = .black
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        label.text = "旧密码"
        pwdBox.addSubview(label)
        
        // 旧密码输入框
        pwdTextField0 = UITextField(frame: CGRect(x: 120, y: 6, width: 220, height:44))
        pwdTextField0.delegate = self
        pwdTextField0.isSecureTextEntry = PwdStatus.INVISIBLE
        pwdTextField0.rightView = UIView(frame: CGRect(x: 0, y: 0, width: 44, height: 44))
        pwdTextField0.rightViewMode = UITextField.ViewMode.always
        pwdTextField0.placeholder = "请输入旧密码"
        
        // 旧密码输入框右侧图标
        let imgRightPwd = UIButton(frame: CGRect(x: 0, y: 0, width: 44, height: 44))
        imgRightPwd.setImage(Icons.eyeCloseIcon.iconFontImage(fontSize: 22, color: Colors.minetextgray), for: .normal)
        imgRightPwd.addTarget(self, action: #selector(changeEye0(sender:)), for: .touchUpInside)
        pwdTextField0.rightView!.addSubview(imgRightPwd)
        pwdBox.addSubview(pwdTextField0)
        
        wapper.addSubview(drawLineView(x: 15, y:height-0.5, width: mainSize.width-0.5, height: 0.5, color: Colors.minelinegray))
    }
    
    func drawNewPwdBox() {
        // 总容器
        let pwdBox = UIView(frame: CGRect(x: 0, y: height, width: mainSize.width, height: 56))
        wapper.addSubview(pwdBox)
        height = pwdBox.frame.maxY
        
        // 新密码
        let label = UILabel(frame: CGRect(x: 15, y: 13, width: 120, height: 30))
        label.textColor = .black
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        label.text = "新密码"
        pwdBox.addSubview(label)
        
        // 新密码输入框
        pwdTextField1 = UITextField(frame: CGRect(x: 120, y: 6, width: 220, height:44))
        pwdTextField1.delegate = self
        pwdTextField1.isSecureTextEntry = PwdStatus.INVISIBLE
        pwdTextField1.rightView = UIView(frame: CGRect(x: 0, y: 0, width: 44, height: 44))
        pwdTextField1.rightViewMode = UITextField.ViewMode.always
        pwdTextField1.placeholder = "请输入新密码"
        
        // 新密码输入框右侧图标
        let imgRightPwd = UIButton(frame: CGRect(x: 0, y: 0, width: 44, height: 44))
        imgRightPwd.setImage(Icons.eyeCloseIcon.iconFontImage(fontSize: 22, color: Colors.minetextgray), for: .normal)
        imgRightPwd.addTarget(self, action: #selector(changeEye1(sender:)), for: .touchUpInside)
        pwdTextField1.rightView!.addSubview(imgRightPwd)
        pwdBox.addSubview(pwdTextField1)
        
        wapper.addSubview(drawLineView(x: 15, y:height-0.5, width: mainSize.width-0.5, height: 0.5, color: Colors.minelinegray))
    }
    
    func drawConfirmPwdBox() {
        // 总容器
        let pwdBox = UIView(frame: CGRect(x: 0, y: height, width: mainSize.width, height: 56))
        wapper.addSubview(pwdBox)
        height = pwdBox.frame.maxY
        
        // 确认密码
        let label = UILabel(frame: CGRect(x: 15, y: 13, width: 120, height: 30))
        label.textColor = .black
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        label.text = "确认密码"
        pwdBox.addSubview(label)
        
        // 确认密码输入框
        pwdTextField2 = UITextField(frame: CGRect(x: 120, y: 6, width: 220, height:44))
        pwdTextField2.delegate = self
        pwdTextField2.isSecureTextEntry = PwdStatus.INVISIBLE
        pwdTextField2.rightView = UIView(frame: CGRect(x: 0, y: 0, width: 44, height: 44))
        pwdTextField2.rightViewMode = UITextField.ViewMode.always
        pwdTextField2.placeholder = "请再次输入新密码"
        
        // 确认密码输入框右侧图标
        let imgRightPwd = UIButton(frame: CGRect(x: 0, y: 0, width: 44, height: 44))
        imgRightPwd.setImage(Icons.eyeCloseIcon.iconFontImage(fontSize: 22, color: Colors.minetextgray), for: .normal)
        imgRightPwd.addTarget(self, action: #selector(changeEye2(sender:)), for: .touchUpInside)
        pwdTextField2.rightView!.addSubview(imgRightPwd)
        pwdBox.addSubview(pwdTextField2)
        
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
    
    @objc func changeEye0(sender: UIButton) {
        // 当前可见
        if (pwdTextField0.isSecureTextEntry == PwdStatus.VISIBLE) {
            pwdTextField0.isSecureTextEntry = PwdStatus.INVISIBLE
            sender.setImage(Icons.eyeCloseIcon.iconFontImage(fontSize: 22, color: Colors.minetextgray), for: .normal)
        }
        // 当前不可见
        else {
            pwdTextField0.isSecureTextEntry = PwdStatus.VISIBLE
            sender.setImage(Icons.eyeIcon.iconFontImage(fontSize: 22, color: Colors.minetextgray), for: .normal)
        }
    }
    
    @objc func changeEye1(sender: UIButton) {
        // 当前可见
        if (pwdTextField1.isSecureTextEntry == PwdStatus.VISIBLE) {
            pwdTextField1.isSecureTextEntry = PwdStatus.INVISIBLE
            sender.setImage(Icons.eyeCloseIcon.iconFontImage(fontSize: 22, color: Colors.minetextgray), for: .normal)
        }
        // 当前不可见
        else {
            pwdTextField1.isSecureTextEntry = PwdStatus.VISIBLE
            sender.setImage(Icons.eyeIcon.iconFontImage(fontSize: 22, color: Colors.minetextgray), for: .normal)
        }
    }
    
    @objc func changeEye2(sender: UIButton) {
        // 当前可见
        if (pwdTextField2.isSecureTextEntry == PwdStatus.VISIBLE) {
            pwdTextField2.isSecureTextEntry = PwdStatus.INVISIBLE
            sender.setImage(Icons.eyeCloseIcon.iconFontImage(fontSize: 22, color: Colors.minetextgray), for: .normal)
        }
        // 当前不可见
        else {
            pwdTextField2.isSecureTextEntry = PwdStatus.VISIBLE
            sender.setImage(Icons.eyeIcon.iconFontImage(fontSize: 22, color: Colors.minetextgray), for: .normal)
        }
    }
    
    @objc func modify(sender: UIButton) {
        if (pwdTextField0.text!.isEmpty) {
            showMsgbox(_message: "旧密码不能为空")
        }
        else if (pwdTextField1.text! != pwdTextField2.text!) {
            showMsgbox(_message: "两次输入的新密码不一致，请检查后重试。")
        }
        else if (pwdTextField1.text!.count < 6) {
            showMsgbox(_message: "密码长度至少为六位")
        }
        else {
            let header: HTTPHeaders = [
                "Cookie": getSession()!,
                "Content-Type": "application/x-www-form-urlencoded"
            ]
            let parameters = [
                "phone": getPhoneFromCookie()!,
                "passwd": pwdTextField0.text!,
                "new_passwd": pwdTextField1.text!
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
                            self.pwdTextField0.isUserInteractionEnabled = false
                            self.pwdTextField1.isUserInteractionEnabled = false
                            self.pwdTextField2.isUserInteractionEnabled = false
                            self.jumpMinebox(_message: "密码修改成功！")
                        }
                        else {
                            self.showMsgbox(_message: "密码修改失败，请重试。")
                        }
                    }
                }
                else {
                    self.showMsgbox(_message: "修改失败，网络错误，无法连接到服务器。")
                }
            }
        }
    }
    
    @objc func back(sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }

}
