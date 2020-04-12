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
    var backButton: BackButton!
    
    var nameView: UIView!
    var depView: UIView!
    var phoneView: UIView!
    var mailView: UIView!
    var authView: UIView!
    
    var logoutButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initial()
    }
    
    func initial() {
        wapper.backgroundColor = Colors.background
        drawHeader()
        drawBoxes()
        drawLogout()
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
        title.text = "个人信息"
        title.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        title.textAlignment = .center
        header.addSubview(title)
        wapper.addSubview(header)
    }
    
    func drawBoxes() {
        // 姓名
        nameView = UIView(frame: CGRect(x: 0, y: 50, width: mainSize.width, height: 50))
        addElem(view: nameView, titleStr: "姓名", valueStr: getNameFromCookie()!)
        wapper.addSubview(nameView)
        // 部门
        depView = UIView(frame: CGRect(x: 0, y: 100, width: mainSize.width, height: 50))
        addElem(view: depView, titleStr: "部门", valueStr: getDepartmentFromCookie()!)
        wapper.addSubview(depView)
        // 手机
        phoneView = UIView(frame: CGRect(x: 0, y: 150, width: mainSize.width, height: 50))
        addElem(view: phoneView, titleStr: "手机", valueStr: getPhoneFromCookie()!)
        wapper.addSubview(phoneView)
        // 邮箱
        mailView = UIView(frame: CGRect(x: 0, y: 200, width: mainSize.width, height: 50))
        addElem(view: mailView, titleStr: "邮箱", valueStr: getEmailFromCookie()!)
        wapper.addSubview(mailView)
        // 角色
        authView = UIView(frame: CGRect(x: 0, y: 250, width: mainSize.width, height: 50))
        addElem(view: authView, titleStr: "角色权限", valueStr: getRoleFromCookie()!)
        wapper.addSubview(authView)
    }
    
    func drawLogout() {
        logoutButton = UIButton(frame: CGRect(x: 0, y: 300, width: mainSize.width, height: 50))
        logoutButton.setTitle("退出登录", for: .normal)
        logoutButton.setTitleColor(.red, for: .normal)
        logoutButton.titleLabel?.font = UIFont.systemFont(ofSize:17, weight: .regular)
        logoutButton.titleLabel?.textAlignment = .center
        logoutButton.addTarget(self, action: #selector(showBottombox), for: .touchUpInside)
        logoutButton.addSubview(drawGrayLineView(x: 0, y: 49.5, height: 0.5))
        wapper.addSubview(logoutButton)
    }
    
    func addElem(view: UIView, titleStr:String, valueStr:String) {
        // 标题
        let title = UILabel(frame: CGRect(x: 15, y: 10, width: 110, height: 30))
        title.text = titleStr
        title.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        title.textColor = Colors.deepGray
        view.addSubview(title)
        // 值
        let value =  UILabel(frame: CGRect(x: mainSize.width-215, y: 10, width: 200, height: 30))
        value.text = valueStr
        value.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        value.textColor = Colors.deepGray
        value.textAlignment = .right
        view.addSubview(value)
        view.addSubview(drawGrayLineView(x: 0, y: 49.5, height: 0.5))
    }
    
    func jumpToLogin() {
        let loginVC = self.storyboard?.instantiateViewController(withIdentifier: "LoginController") as! LoginController
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
