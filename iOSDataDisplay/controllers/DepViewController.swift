//
//  DepViewController.swift
//  iOSDataDisplay
//
//  Created by Flora on 2020/4/1.
//  Copyright © 2020年 yinmeng. All rights reserved.
//

import UIKit

class DepViewController: UIViewController {
    
    var titleTxt: String = ""
    
    @IBOutlet var barTxt: UINavigationItem!
    @IBOutlet var back: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 绑定返回键
        back.action = #selector(backToIndex)
        // barTxt
        barTxt.title = titleTxt
        
    }
    
    func draw() {
        
    }
    
    @objc func backToIndex() {
        self.dismiss(animated: true, completion: nil)
    }
}
