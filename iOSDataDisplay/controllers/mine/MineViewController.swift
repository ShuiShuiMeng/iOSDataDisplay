//
//  MineViewController.swift
//  iOSDataDisplay
//
//  Created by Flora on 2020/4/1.
//  Copyright © 2020年 yinmeng. All rights reserved.
//

import UIKit

class MineViewController: UIViewController {

    @IBOutlet var mineItem: UITabBarItem!
    @IBOutlet var wapper: UIView!
    var header: UIView!
    
    var photo: UIImageView!
    var nameLabel: UILabel!
    var deptLabel: UILabel!
    
    var msgButton: UIButton!
    var phoneButton: UIButton!
    var mailButton: UIButton!
    var pwdButton: UIButton!
    var settingButton: UIButton!
    
    // 高度
    var height: CGFloat!
    
    var name: String = "" {
        didSet {
            nameLabel.text = name
        }
    }
    
    var dept: String = "" {
        didSet {
            deptLabel.text = dept
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initial()
    }

    func initial() {
        mineItem.selectedImage = Icons.mineIconB.iconFontImage(fontSize: 35, color: .gray)
        wapper.backgroundColor = Colors.graybackground
        drawHeader()
        drawBoxes()
    }
    
    func drawHeader() {
        header = UIView(frame: CGRect(x: 0, y: 0, width: mainSize.width, height: 210))
        header.backgroundColor = Colors.blueBackground
        wapper.addSubview(header)
        
        // 标题
        let titleLabel = UILabel(frame: CGRect(x: mainSize.width*0.5-40, y: 10, width: 80, height: 30))
        titleLabel.textColor = .white
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        titleLabel.text = "我的"
        wapper.addSubview(titleLabel)
        
        // 头像
        photo = UIImageView(frame: CGRect(x: mainSize.width*0.5-45, y: 58, width: 90, height: 90))
        photo.image = UIImage(named: "head.jpg")//Icons.userIcon.iconFontImage(fontSize: 75, color: .gray)
        photo.cornerRadius(radius: 45)
        header.addSubview(photo)
        
        // 名字
        nameLabel = UILabel(frame: CGRect(x:mainSize.width*0.5-100, y: 160, width: 200, height: 20))
        nameLabel.textColor = .white
        nameLabel.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        nameLabel.textAlignment = .center
        header.addSubview(nameLabel)
        name = getNameFromCookie()!
        
        // 部门
        deptLabel = UILabel(frame: CGRect(x:mainSize.width*0.5-100, y: 180, width: 200, height: 20))
        deptLabel.textColor = UIColor(red: 151/255.0, green: 197/255.0, blue: 255/255.0, alpha: 1)
        deptLabel.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        deptLabel.textAlignment = .center
        header.addSubview(deptLabel)
        dept = getDepartmentFromCookie()!
        
        height = header.frame.maxY
    }
    
    func drawBoxes() {
        // 个人详细信息
        msgButton = UIButton(frame: CGRect(x: 0, y: height, width: mainSize.width, height: 56))
        addElem(button: msgButton, titleStr: "查看个人信息", named: "me.jpg", tag: 0)
        wapper.addSubview(msgButton)
        height = msgButton.frame.maxY
        
        // 绑定手机号
        phoneButton = UIButton(frame: CGRect(x: 0, y: height, width: mainSize.width, height: 56))
        addElem(button: phoneButton, titleStr: "修改绑定手机", named: "mobile.jpg", tag: 1)
        wapper.addSubview(phoneButton)
        height = phoneButton.frame.maxY
        
        // 绑定邮箱
        mailButton = UIButton(frame: CGRect(x: 0, y: height, width: mainSize.width, height: 56))
        addElem(button: mailButton, titleStr: "修改绑定邮箱", named: "email.jpg", tag: 2)
        wapper.addSubview(mailButton)
        height = mailButton.frame.maxY
        
        // 修改密码
        pwdButton = UIButton(frame: CGRect(x: 0, y: height, width: mainSize.width, height: 56))
        addElem(button: pwdButton, titleStr: "修改密码", named: "password.jpg", tag: 3)
        wapper.addSubview(pwdButton)
        height = pwdButton.frame.maxY
        
        // 设置
        // settingButton = UIButton(frame: CGRect(x: 0, y: 320, width: mainSize.width, height: 50))
        // addElem(button: settingButton, titleStr: "设置", lficon: Icons.settingIcon2, tag: 4)
        // 暂无设置
        // wapper.addSubview(settingButton)
    }
    
    func addElem(button: UIButton, titleStr:String, named name:String, tag: Int) {
        // 背景
        button.setBackgroundColor(color: .white, forState: .normal)
        // 图标
        let icon = UIImageView(frame: CGRect(x: 20, y: 18, width: 20, height: 20))
        // icon.image = lficon.iconFontImage(fontSize: 25, color: Colors.deepGray)
        icon.image = UIImage(named: name)
        
        button.addSubview(icon)
        // 标题
        let title = UILabel(frame: CGRect(x: 55, y: 13, width: 100, height: 30))
        title.text = titleStr
        title.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        title.textColor = .black
        button.addSubview(title)
        // 右侧箭头
        let right = UIImageView(frame: CGRect(x: mainSize.width-45, y: 13, width: 30, height: 30))
        right.image = Icons.right.iconFontImage(fontSize: 25, color: Colors.minegray)
        button.addSubview(right)
        if tag != 3 {
            button.addSubview(drawLineView(x: 20, y: 55, width: mainSize.width-15, height: 1, color: Colors.minelinegray))
        }
        // 跳转传参
        button.tag = tag
        button.addTarget(self, action: #selector(jump(sender:)), for: .touchUpInside)
    }
    
    @objc func jump(sender: UIButton) {
        switch sender.tag {
        case 0:
            let VC = self.storyboard?.instantiateViewController(withIdentifier: "MsgViewController") as! MsgViewController
            VC.modalPresentationStyle = .fullScreen
            self.present(VC, animated: true, completion: nil)
            break
        case 1:
            let VC = self.storyboard?.instantiateViewController(withIdentifier: "PhoneViewController") as! PhoneViewController
            VC.modalPresentationStyle = .fullScreen
            self.present(VC, animated: true, completion: nil)
            break;
        case 2:
            let VC = self.storyboard?.instantiateViewController(withIdentifier: "EmailViewController") as! EmailViewController
            VC.modalPresentationStyle = .fullScreen
            self.present(VC, animated: true, completion: nil)
            break;
        case 3:
            let VC = self.storyboard?.instantiateViewController(withIdentifier: "PwdViewController") as! PwdViewController
            VC.modalPresentationStyle = .fullScreen
            self.present(VC, animated: true, completion: nil)
            break;
        case 4:
            let VC = self.storyboard?.instantiateViewController(withIdentifier: "SettingViewController") as! SettingViewController
            VC.modalPresentationStyle = .fullScreen
            self.present(VC, animated: true, completion: nil)
            break;
        default:
            return
        }
        // let target = self.storyboard?.instantiateViewController(withIdentifier: vcId) as!
    }
}
