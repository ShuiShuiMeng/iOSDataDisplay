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
    @IBOutlet var header: UIView!
    
    var photo: UIImageView!
    var nameLabel: UILabel!
    var depLabel: UILabel!
    
    var msgButton: UIButton!
    var phoneButton: UIButton!
    var mailButton: UIButton!
    var pwdButton: UIButton!
    var settingButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initial()
    }

    func initial() {
        mineItem.selectedImage = Icons.mineIconB.iconFontImage(fontSize: 35, color: .gray)
        self.view?.backgroundColor = Colors.graybackground
        drawHeader(name: getNameFromCookie()!, dep: getDepartmentFromCookie()!)
        drawBoxes()
    }
    
    func drawHeader(name: String, dep: String) {
        header.backgroundColor = Colors.blue
        photo = UIImageView(frame: CGRect(x: 10, y: 20, width: 80, height: 80))
        photo.image = Icons.userIcon.iconFontImage(fontSize: 75, color: .gray)
        header.addSubview(photo)
        nameLabel = UILabel(frame: CGRect(x:110, y: 30, width: 200, height: 30))
        depLabel = UILabel(frame: CGRect(x:110, y: 60, width: 200, height: 30))
        nameLabel.textColor = .white
        depLabel.textColor = .white
        nameLabel.text = name
        depLabel.text = dep
        nameLabel.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        depLabel.font = UIFont.systemFont(ofSize: 15)
        header.addSubview(nameLabel)
        header.addSubview(depLabel)
        wapper.addSubview(header)
    }
    
    func drawBoxes() {
        // 个人详细信息
        msgButton = UIButton(frame: CGRect(x: 0, y: 120, width: mainSize.width, height: 50))
        addElem(button: msgButton, titleStr: "查看个人信息", lficon: Icons.userIcon2, tag: 0)
        wapper.addSubview(msgButton)
        
        // 绑定手机号
        phoneButton = UIButton(frame: CGRect(x: 0, y: 170, width: mainSize.width, height: 50))
        addElem(button: phoneButton, titleStr: "修改绑定手机", lficon: Icons.phone, tag: 1)
        wapper.addSubview(phoneButton)
        
        // 绑定邮箱
        mailButton = UIButton(frame: CGRect(x: 0, y: 220, width: mainSize.width, height: 50))
        addElem(button: mailButton, titleStr: "修改绑定邮箱", lficon: Icons.email, tag: 2)
        wapper.addSubview(mailButton)
        
        // 修改密码
        pwdButton = UIButton(frame: CGRect(x: 0, y: 270, width: mainSize.width, height: 50))
        addElem(button: pwdButton, titleStr: "修改密码", lficon: Icons.pwdIcon2, tag: 3)
        wapper.addSubview(pwdButton)
        
        // 设置
        settingButton = UIButton(frame: CGRect(x: 0, y: 320, width: mainSize.width, height: 50))
        addElem(button: settingButton, titleStr: "设置", lficon: Icons.settingIcon2, tag: 4)
        // 暂无设置
        // wapper.addSubview(settingButton)
    }
    
    func addElem(button: UIButton, titleStr:String, lficon: LFIconFont, tag: Int) {
        // 背景
        button.setBackgroundColor(color: .white, forState: .normal)
        // 图标
        let icon = UIImageView(frame: CGRect(x: 10, y: 10, width: 30, height: 30))
        icon.image = lficon.iconFontImage(fontSize: 25, color: Colors.deepGray)
        button.addSubview(icon)
        // 标题
        let title = UILabel(frame: CGRect(x: 40, y: 10, width: 100, height: 30))
        title.text = titleStr
        title.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        title.textColor = Colors.deepGray
        button.addSubview(title)
        // 右侧箭头
        let right = UIImageView(frame: CGRect(x:mainSize.width-40, y:10, width:30, height:30))
        right.image = Icons.right.iconFontImage(fontSize: 25, color: Colors.deepGray)
        button.addSubview(right)
        button.addSubview(drawGrayLineView(x: 0, y: 49.5, height: 0.5))
        // 跳转传参
        button.tag = tag
        button.addTarget(self, action: #selector(jump(sender:)), for: .touchUpInside)
    }
    
    @objc func jump(sender: UIButton) {
        switch sender.tag {
        case 0:
            let VC = self.storyboard?.instantiateViewController(withIdentifier: "MsgViewController") as! MsgViewController
            self.present(VC, animated: true, completion: nil)
            break
        case 1:
            let VC = self.storyboard?.instantiateViewController(withIdentifier: "PhoneViewController") as! PhoneViewController
            self.present(VC, animated: true, completion: nil)
            break;
        case 2:
            let VC = self.storyboard?.instantiateViewController(withIdentifier: "EmailViewController") as! EmailViewController
            self.present(VC, animated: true, completion: nil)
            break;
        case 3:
            let VC = self.storyboard?.instantiateViewController(withIdentifier: "PwdViewController") as! PwdViewController
            self.present(VC, animated: true, completion: nil)
            break;
        case 4:
            let VC = self.storyboard?.instantiateViewController(withIdentifier: "SettingViewController") as! SettingViewController
            self.present(VC, animated: true, completion: nil)
            break;
        default:
            return
        }
        // let target = self.storyboard?.instantiateViewController(withIdentifier: vcId) as!
    }
}
