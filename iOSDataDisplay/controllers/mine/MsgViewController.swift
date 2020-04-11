//
//  MsgViewController.swift
//  iOSDataDisplay
//
//  Created by Flora on 2020/4/10.
//  Copyright © 2020年 yinmeng. All rights reserved.
//

import UIKit

class MsgViewController: UIViewController {

    @IBOutlet var wapper: UIView!
    
    var header: UIView!
    var backButton: BackButton!
    
    var nameView: UIView!
    var depView: UIView!
    var phoneView: UIView!
    var mailView: UIView!
    var authView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initial()
    }
    
    func initial() {
        wapper.backgroundColor = Colors.background
        drawHeader()
        drawBoxes()
    }
    
    func drawHeader() {
        header = UIView(frame: CGRect(x: 0, y: 0, width: mainSize.width, height: 60))
        header.backgroundColor = Colors.blue
        //backButton = UIButton(frame: CGRect(x: 0, y: 10, width: 40, height: 40))
        // 返回键
        backButton = BackButton(frame: CGRect(x: 0, y: 0, width: 100, height: 60))
        backButton.setImage(Icons.left.iconFontImage(fontSize: 30, color: .white), for: .normal)
        backButton.addTarget(self, action: #selector(back), for: .touchUpInside)
        // 标题
        let title = UILabel(frame: CGRect(x: mainSize.width*0.5-75, y: 15, width: 150, height: 30))
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
        nameView = UIView(frame: CGRect(x: 0, y: 60, width: mainSize.width, height: 50))
        addElem(view: nameView, titleStr: "姓名", valueStr: "沈耀")
        wapper.addSubview(nameView)
        // 部门
        depView = UIView(frame: CGRect(x: 0, y: 110, width: mainSize.width, height: 50))
        addElem(view: depView, titleStr: "部门", valueStr: "办公室")
        wapper.addSubview(depView)
        // 手机
        phoneView = UIView(frame: CGRect(x: 0, y: 160, width: mainSize.width, height: 50))
        addElem(view: phoneView, titleStr: "手机", valueStr: "13262285856")
        wapper.addSubview(phoneView)
        // 邮箱
        mailView = UIView(frame: CGRect(x: 0, y: 210, width: mainSize.width, height: 50))
        addElem(view: mailView, titleStr: "邮箱", valueStr: "yshen11@126.com")
        wapper.addSubview(mailView)
        // 角色
        authView = UIView(frame: CGRect(x: 0, y: 260, width: mainSize.width, height: 50))
        addElem(view: authView, titleStr: "角色权限", valueStr: "管理员")
        wapper.addSubview(authView)
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
    
    @objc func back(sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
}
