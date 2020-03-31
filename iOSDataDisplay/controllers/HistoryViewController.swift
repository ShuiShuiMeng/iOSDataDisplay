//
//  HistoryViewController.swift
//  iOSDataDisplay
//
//  Created by Flora on 2020/3/26.
//  Copyright © 2020年 yinmeng. All rights reserved.
//

import UIKit

class HistoryViewController: UIViewController {
    
    @IBOutlet var historyItem: UITabBarItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        historyItem.selectedImage = Icons.historyIconB.iconFontImage(fontSize: 35, color: .gray)
        print("history load")
    }
    
}

