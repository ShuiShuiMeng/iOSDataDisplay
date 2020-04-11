//
//  PwdViewController.swift
//  iOSDataDisplay
//
//  Created by Flora on 2020/4/12.
//  Copyright © 2020年 yinmeng. All rights reserved.
//

import UIKit

class PwdViewController: UIViewController {

    @IBOutlet var wapper: UIView!
    
    var header: UIView!
    var backButton: BackButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initial()
    }
    
    func initial() {
        wapper.backgroundColor = Colors.background
        drawHeader()
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
        title.text = "修改密码"
        title.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        title.textAlignment = .center
        header.addSubview(title)
        wapper.addSubview(header)
    }
    
    @objc func back(sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }

}
