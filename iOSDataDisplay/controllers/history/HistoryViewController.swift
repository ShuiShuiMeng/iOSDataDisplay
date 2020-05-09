//
//  SecondViewController.swift
//  iOSDataDisplay
//
//  Created by Flora on 2020/4/1.
//  Copyright © 2020年 yinmeng. All rights reserved.
//

import UIKit

class HistoryViewController: UIViewController {

    @IBOutlet var historyItem: UITabBarItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        historyItem.selectedImage = Icons.historyIconB.iconFontImage(fontSize: 35, color: .gray)
        
        showMsgbox(_message: "历史数据功能暂未开放！")
        
        let label = UILabel(frame: CGRect(x: view.bounds.midX-100, y: view.bounds.midY-20, width: 200, height: 40))
        label.text = "功能暂未开放！"
        label.textAlignment = .center
        view.addSubview(label)
    }


}

