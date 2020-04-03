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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mineItem.selectedImage = Icons.mineIconB.iconFontImage(fontSize: 35, color: .gray)
    }

}
