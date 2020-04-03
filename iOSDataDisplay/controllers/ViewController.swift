//
//  ViewController.swift
//  iOSDataDisplay
//
//  Created by Flora on 2020/4/1.
//  Copyright © 2020年 yinmeng. All rights reserved.
//

import UIKit

class ViewController: UITabBarController {
    
    @IBOutlet var bottomBar: UITabBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initIcons()
    }
    
    func initIcons() {
        bottomBar.items![0].image = Icons.indexIconA.iconFontImage(fontSize: 35, color: .gray)
        bottomBar.items![1].image = Icons.historyIconA.iconFontImage(fontSize: 35, color: .gray)
        bottomBar.items![2].image = Icons.mineIconA.iconFontImage(fontSize: 35, color: .gray)
    }
}

// 登录状态枚举
enum LoginStatus {
    case UNLOG
    case LOGIN
}

