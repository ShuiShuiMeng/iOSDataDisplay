//
//  PhoneViewController.swift
//  iOSDataDisplay
//
//  Created by Flora on 2020/4/12.
//  Copyright © 2020年 yinmeng. All rights reserved.
//

import UIKit
import Alamofire

class PhoneViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet var wapper: UIView!
    
    var header: UIView!
    var backButton: BackButton!
    
    var modifyBox: UIView!
    var userTextField: UITextField!
    var pwdTextField: UITextField!
    var phoneTextField: UITextField!
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
        //backButton = UIButton(frame: CGRect(x: 0, y: 10, width: 40, height: 40))
        // 返回键
        backButton = BackButton(frame: CGRect(x: 0, y: 0, width: 100, height: 50))
        backButton.setImage(Icons.left.iconFontImage(fontSize: 30, color: .white), for: .normal)
        backButton.addTarget(self, action: #selector(back), for: .touchUpInside)
        // 标题
        let title = UILabel(frame: CGRect(x: mainSize.width*0.5-75, y: 10, width: 150, height: 30))
        header.addSubview(backButton)
        title.textColor = .white
        title.text = "修改绑定手机"
        title.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        title.textAlignment = .center
        header.addSubview(title)
        wapper.addSubview(header)
    }
    
    func drawBox() {
        // 框背景
        modifyBox = UIView(frame: CGRect(x:15, y:80, width:mainSize.width-30, height:172))
        modifyBox.backgroundColor = Colors.graybackground
        wapper.addSubview(modifyBox)
        // 账号输入框
        drawUserTextField()
        // 密码输入框
        drawPwdTextField()
        // 新手机号输入框
        drawPhoneTextField()
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
        userTextField.placeholder = UserDefaults.standard.string(forKey: "userPhone")
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
        imgRightPwd.addTarget(self, action: #selector(changeEye(sender:)), for: .touchUpInside)
        // imgRightPwd.image = Icons.eyeCloseIcon.iconFontImage(fontSize: 20, color: .gray)
        pwdTextField.rightView!.addSubview(imgRightPwd)
        modifyBox.addSubview(pwdTextField)
    }
    
    func drawPhoneTextField() {
        //新手机输入
        phoneTextField = UITextField(frame: CGRect(x:10, y:128, width:modifyBox.frame.size.width-20, height:44))
        phoneTextField.delegate = self
        phoneTextField.layer.cornerRadius = 5
        phoneTextField.layer.borderColor = UIColor.lightGray.cgColor
        phoneTextField.layer.borderWidth = 0.5
        phoneTextField.isSecureTextEntry = PwdStatus.VISIBLE
        phoneTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 44, height: 44))
        phoneTextField.leftViewMode = UITextField.ViewMode.always
        phoneTextField.rightView = UIView(frame: CGRect(x: 0, y: 0, width: 44, height: 44))
        phoneTextField.rightViewMode = UITextField.ViewMode.always
        phoneTextField.placeholder = "请输入新手机号"
        // 密码输入框左侧图标
        let imgLeftPwd = UIImageView(frame: CGRect(x: 11, y: 11, width: 22, height: 22))
        imgLeftPwd.image = Icons.phone.iconFontImage(fontSize: 20, color: .gray)
        phoneTextField.leftView!.addSubview(imgLeftPwd)
        phoneTextField.addSubview(imgLeftPwd)
        modifyBox.addSubview(phoneTextField)
    }
    
    func drawModifyButton() {
        // 登陆按钮
        modifyButton = UIButton(frame: CGRect(x: 20, y: 300, width: mainSize.width-40, height: 40))
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
    
    @objc func back(sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func modify(sender: UIButton) {
        if pwdTextField.text!.isEmpty {
            showMsgbox(_message: "密码不能为空")
        }
        else if phoneTextField.text!.isEmpty {
            showMsgbox(_message: "新手机号不能为空")
        }
        else if !phoneTextField.text!.isPhoneNumber() {
            showMsgbox(_message: "新手机号不符合格式")
        }
        else {
            let header: HTTPHeaders = [
                "Cookie": getSession()!,
                "Content-Type": "application/x-www-form-urlencoded"
            ]
            let parameters = [
                "phone": getPhoneFromCookie()!,
                "passwd": pwdTextField.text!,
                "new_phone": phoneTextField.text!
            ]
            Alamofire.request(setAccountUrl, method: .post, parameters: parameters, headers: header).responseJSON {
                response in
                // print(response)
                // cookie 无效
                if (response.response?.statusCode != 200) {
                    self.jumpLoginbox(_message: "修改失败，登录权限过期，请重新登录")
                }
                
                else if response.result.isSuccess {
                    
                    // cookie 有效，登录成功
                    let res = SetAccountDecoder.decode(jsonData: response.data!)
                    if res.Code == 0 {
                        self.pwdTextField.isUserInteractionEnabled = false
                        self.phoneTextField.isUserInteractionEnabled = false
                        // 更新登录名
                        if (getPhoneFromCookie() == getLoginName()) {
                            refreshLoginName(name: self.phoneTextField.text!)
                        }
                        setPhoneToCookie(phone: self.phoneTextField.text!)
                        self.jumpMinebox(_message: "修改成功！")
                    }
                    else if res.ObjT == "Cannot match a user." {
                        self.showMsgbox(_message: "修改失败，密码错误")
                    }
                    else if res.ObjT == "duplicated phone!" {
                        self.showMsgbox(_message: "修改失败，手机号已被绑定，请尝试更换其他新手机号")
                    }
                    else {
                        self.showMsgbox(_message: "修改失败，发生了未知错误，请联系服务器管理员")
                    }
                }
                else {
                    self.showMsgbox(_message: "修改失败，网络错误，无法连接到服务器")
                }
            }
        }
    }
}
