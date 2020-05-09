//
//  MsgViewController.swift
//  iOSDataDisplay
//
//  Created by Flora on 2020/4/10.
//  Copyright © 2020年 yinmeng. All rights reserved.
//

import UIKit
import Alamofire

class MsgViewController: UIViewController {

    @IBOutlet var wapper: UIView!
    var header: UIView!
    
    var height: CGFloat = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initial()
    }
    
    func initial() {
        wapper.backgroundColor = Colors.graybackground
        drawHeader()
        drawBoxes()
        drawLogout()
    }
    
    func drawHeader() {
        header = UIView(frame: CGRect(x: 0, y: 0, width: mainSize.width, height: 50))
        header.backgroundColor = Colors.blueBackground
        wapper.addSubview(header)
        
        // 返回键
        let backButton = BackButton(frame: CGRect(x: 5, y: 0, width: 100, height: 50))
        backButton.setImage(Icons.left.iconFontImage(fontSize: 30, color: .white), for: .normal)
        backButton.setTitle("返回", for: .normal)
        backButton.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        backButton.addTarget(self, action: #selector(back), for: .touchUpInside)
        header.addSubview(backButton)
        
        // 标题
        let title = UILabel(frame: CGRect(x: mainSize.width*0.5-75, y: 0, width: 150, height: 50))
        title.textColor = .white
        title.text = "个人信息"
        title.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        title.textAlignment = .center
        header.addSubview(title)
        
        height = header.frame.maxY
    }
    
    func drawBoxes() {
        // 留白
        let whiteView = UIView(frame: CGRect(x: 0, y: height, width: mainSize.width, height: 5))
        whiteView.backgroundColor = .white
        wapper.addSubview(whiteView)
        height = whiteView.frame.maxY
        
        // 姓名
        let nameView = UIView(frame: CGRect(x: 0, y: height, width: mainSize.width, height: 56))
        self.addElem(view: nameView, titleStr: "姓名", valueStr: getNameFromCookie()!)
        nameView.addSubview(drawLineView(x: 15, y: 55.5, width: mainSize.width-15, height: 0.5, color: Colors.minelinegray))
        wapper.addSubview(nameView)
        height = nameView.frame.maxY
        
        // 部门
        let deptView = UIView(frame: CGRect(x: 0, y: height, width: mainSize.width, height: 56))
        self.addElem(view: deptView, titleStr: "部门", valueStr: getDepartmentFromCookie()!)
        deptView.addSubview(drawLineView(x: 15, y: 55.5, width: mainSize.width-15, height: 0.5, color: Colors.minelinegray))
        wapper.addSubview(deptView)
        height = deptView.frame.maxY
        
        // 手机
        let phoneView = UIView(frame: CGRect(x: 0, y: height, width: mainSize.width, height: 56))
        self.addElem(view: phoneView, titleStr: "手机", valueStr: getPhoneFromCookie()!)
        phoneView.addSubview(drawLineView(x: 15, y: 55.5, width: mainSize.width-15, height: 0.5, color: Colors.minelinegray))
        wapper.addSubview(phoneView)
        height = phoneView.frame.maxY
        
        // 邮箱
        let emailView = UIView(frame: CGRect(x: 0, y: height, width: mainSize.width, height: 56))
        self.addElem(view: emailView, titleStr: "邮箱", valueStr: getEmailFromCookie()!)
        emailView.addSubview(drawLineView(x: 15, y: 55.5, width: mainSize.width-15, height: 0.5, color: Colors.minelinegray))
        wapper.addSubview(emailView)
        height = emailView.frame.maxY
        
        // 角色
        let authView = UIView(frame: CGRect(x: 0, y: height, width: mainSize.width, height: 56))
        var authStr = getRoleFromCookie()!
        if authStr == "Supervisor" {
            authStr = authStr + "(超级管理员)"
        }
        else {
            authStr = authStr + "(普通用户)"
        }
        self.addElem(view: authView, titleStr: "角色权限", valueStr: authStr)
        wapper.addSubview(authView)
        height = authView.frame.maxY
    }
    
    func drawLogout() {
        let logoutButton = UIButton(frame: CGRect(x: 0, y: height+8, width: mainSize.width, height: 56))
        logoutButton.setTitle("退出登录", for: .normal)
        logoutButton.setTitleColor(UIColor(red: 44/255.0, green: 113/255.0, blue: 222/255.0, alpha: 1), for: .normal)
        logoutButton.setBackgroundColor(color: .white, forState: .normal)
        logoutButton.titleLabel?.font = UIFont.systemFont(ofSize:16, weight: .medium)
        logoutButton.titleLabel?.textAlignment = .center
        logoutButton.addTarget(self, action: #selector(showBottombox), for: .touchUpInside)
        wapper.addSubview(logoutButton)
    }
    
    func addElem(view: UIView, titleStr:String, valueStr:String) {
        view.backgroundColor = .white
        
        // 标题
        let title = UILabel(frame: CGRect(x: 15, y: 13, width: 110, height: 30))
        title.text = titleStr
        title.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        title.textColor = .black
        view.addSubview(title)
        
        // 值
        let value =  UILabel(frame: CGRect(x: mainSize.width-215, y: 13, width: 200, height: 30))
        value.text = valueStr
        value.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        value.textColor = Colors.minetextgray
        value.textAlignment = .right
        view.addSubview(value)
    }
    
    func jumpToLogin() {
        let loginVC = self.storyboard?.instantiateViewController(withIdentifier: "LoginController") as! LoginController
        loginVC.modalPresentationStyle = .fullScreen
        self.present(loginVC, animated: true, completion: nil)
    }
    
    @objc func showBottombox(){
        let alertController = UIAlertController(title: "退出登录", message: "退出后返回登录页面",
                                                preferredStyle: .actionSheet)
        let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        let deleteAction = UIAlertAction(title: "确认退出", style: .destructive, handler: {
            action in
            self.logout()
        })
        alertController.addAction(cancelAction)
        alertController.addAction(deleteAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    @objc func back(sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func logout() {
        // 判断cookie中有无session
        if (UserDefaults.standard.string(forKey: "__session") != nil) {
            let header: HTTPHeaders = [
                "Cookie": UserDefaults.standard.string(forKey: "__session")!
            ]
            Alamofire.request(logoutUrl, method: .post, headers: header).responseJSON {
                response in
                // print(response)
                clearSession()
                self.jumpToLogin()
            }
        }
        else {
            self.jumpToLogin()
        }
    }
}
