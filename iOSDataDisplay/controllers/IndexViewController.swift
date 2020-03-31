//
//  IndexViewController.swift
//  iOSDataDisplay
//
//  Created by Flora on 2020/3/26.
//  Copyright © 2020年 yinmeng. All rights reserved.
//

import UIKit

class IndexViewController: UIViewController {
    
    @IBOutlet var indexView: UIScrollView!
    // @IBOutlet var topButton: UIButton!
    @IBOutlet var indexItem: UITabBarItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
            initial()
            print("index load")
    }
    
    func getLoginStatus() -> LoginStatus {
        return LoginStatus.LOGIN
    }
    
    func initial() {
        loadIcons()
        loadIndex()
        loadBars()
        setBackground()
        indexView.contentSize = CGSize(width: 375, height: 750)
    }
    
    func loadIcons() {
        indexItem.selectedImage = Icons.indexIconB.iconFontImage(fontSize: 35, color: .gray)
    }
    
    func loadIndex() {
        let content = Index(frame: CGRect(x:0, y:0, width:375, height:470))
        indexView.addSubview(content)
    }
    
    func loadBars() {
        // get datas
        let Datas = [
            ("面上项目", 0.25),
            ("重点项目", 0.75),
            ("重大项目", 0.6),
            ("重大研究计划项目", 0.5),
            ("国际(地区)合作研究项目", 0.8),
            ("青年科学基金项目", 1.0),
            ("优秀青年科学基金项目", 0.75),
            ("国家杰出青年科学项目基金", 0.66),
            ("创新研究群体项目", 0.1),
            ("地区科学基金项目", 0.5),
            ("联合基金项目(委内出资额)", 0.2),
            ("国家重大科研仪器研制项目", 0.3),
            ("基础科学中心项目", 0.44),
            ("专项项目", 0.55),
            ("数学田园基金项目", 0.66),
            ("外国青年学者研究基金项目", 0.77),
            ("国际(地区)合作交流项目", 0.88)
        ]
        var i = 0;
        for (title, percent) in Datas {
            let finishedBar = FinishedBar(frame: CGRect(x:0, y:500+i*60, width:375, height:60))
            finishedBar.setData(title: title, percent: Float(percent))
            indexView.addSubview(finishedBar)
            i = i + 1
        }
    }
    
    func setBackground() {
        indexView.backgroundColor = UIColor(red: 248/255, green: 247/255, blue: 247/255, alpha: 0.5)
    }
}

