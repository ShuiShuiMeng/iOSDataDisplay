//
//  FirstViewController.swift
//  iOSDataDisplay
//
//  Created by Flora on 2020/4/1.
//  Copyright © 2020年 yinmeng. All rights reserved.
//

import UIKit
import Alamofire

class IndexViewController: UIViewController {
    
    @IBOutlet var topView: UIView!
    @IBOutlet var refresh: UIButton!
    @IBOutlet var topButton: UIButton!
    @IBOutlet var scrollView: UIScrollView!
    @IBOutlet var indexItem: UITabBarItem!
    
    var barDatas: Array<BarData> = []
    var depDatas: Array<DepData> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initial()
    }
    
    func getLoginStatus() -> LoginStatus {
        return LoginStatus.LOGIN
    }
    
    func initial() {
        scrollView.backgroundColor = Colors.background
        loadIcons()
        drawTopView()
        loadIndex()
        drawDeps()
        drawBars()
    }
    
    func loadIcons() {
        indexItem.selectedImage = Icons.indexIconB.iconFontImage(fontSize: 35, color: .gray)
    }
    
    func loadIndex() {
        let content = Index(frame: CGRect(x:(mainSize.width-375)/2, y:0, width:375, height:300))
        scrollView.addSubview(content)
    }
    
    func drawTopView() {
        topButton.titleLabel?.numberOfLines = 2
        topButton.titleLabel?.lineBreakMode = NSLineBreakMode.byCharWrapping
        topButton.setTitle("2020年度科学基金资助计划\n（国科金发〔2020〕X号）", for: .normal)
        topButton.addTarget(self, action: #selector(tapTop), for: .touchUpInside)
        refresh.setImage(Icons.refreshIcon.iconFontImage(fontSize: 20, color: .black), for: .normal)
        refresh.addTarget(self, action: #selector(refreshNumbers(sender:)), for: .touchUpInside)
        topView.addSubview(drawGrayLineView(x: 0, y: 49, height: 1))
    }
    
    func drawDeps() {
        depDatas = [
            DepData(name: "数理", x: 0, y: 0, icon: Icons.slIcon),
            DepData(name: "化学", x: 75.25, y: 0, icon: Icons.hxIcon),
            DepData(name: "生命", x: 150.5, y: 0, icon: Icons.smIcon),
            DepData(name: "地球", x: 225.75, y: 0, icon: Icons.dqIcon),
            DepData(name: "工材", x: 301, y: 0, icon: Icons.gcIcon),
            DepData(name: "信息", x: 0, y: 75.5, icon: Icons.xxIcon),
            DepData(name: "管理", x: 75.25, y: 75.5, icon: Icons.glIcon),
            DepData(name: "医学", x: 150.5, y: 75.5, icon: Icons.yxIcon),
            DepData(name: "合作局", x: 225.75, y: 75.5, icon: Icons.hzIcon),
            DepData(name: "更多", x: 301, y: 75.5, icon: Icons.gdIcon)
        ]
        
        for item in depDatas {
            let tmpBtn = DepButton(frame: CGRect(x: (mainSize.width-375)/2+item.x, y: 255+item.y, width: 74, height: 74.5))
            tmpBtn.setTitle(item.name, for: .normal)
            tmpBtn.setTitleColor(.black, for: .normal)
            tmpBtn.setImage(item.icon.iconFontImage(fontSize: 30, color: .orange), for: .normal)
            tmpBtn.setImage(item.icon.iconFontImage(fontSize: 30, color: .blue), for: .highlighted)
            tmpBtn.addTarget(self, action: #selector(tapToDetails), for: .touchUpInside)
            tmpBtn.backgroundColor = UIColor(red: 248/255, green: 247/255, blue: 247/255, alpha: 0.5)
            scrollView.addSubview(tmpBtn)
        }
        
        let finLabel = UILabel(frame: CGRect(x:(mainSize.width-375)/2+10, y:430, width: 100, height: 20))
        finLabel.text = "项目完成度"
        finLabel.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        scrollView.addSubview(finLabel)
    }
    
    @objc func tapToDetails(sender: UIButton) {
        
        switch sender.titleLabel?.text {
            
        case "数理":
            jumpToDetails(dep: "数理")
            break
            
        case "化学":
            jumpToDetails(dep: "化学")
            break
            
        case "生命":
            break
            
        case "地球":
            break
            
        case "工材":
            break
            
        case "信息":
            break
            
        case "管理":
            break
            
        case "医学":
            break
            
        case "合作局":
            break
            
        default:
            break
        }
    }
    
    func jumpToDetails(dep: String) {
        let depVC = self.storyboard?.instantiateViewController(withIdentifier: "DepViewController") as! DepViewController
        depVC.titleTxt = dep
        self.present(depVC, animated: true, completion: nil)
    }
    
    
    func drawBars() {
        // get datas
        barDatas = [
            BarData(name: "面上项目", percent: 0.25),
            BarData(name: "重点项目", percent: 0.75),
            BarData(name: "重大项目", percent: 0.6),
            BarData(name: "重大研究计划项目", percent: 0.5),
            BarData(name: "国际(地区)合作研究项目", percent: 0.8),
            BarData(name: "青年科学基金项目", percent: 1.0),
            BarData(name: "优秀青年科学基金项目", percent: 0.75),
            BarData(name: "国家杰出青年科学项目基金", percent: 0.66),
            BarData(name: "创新研究群体项目", percent: 0.1),
            BarData(name: "地区科学基金项目", percent: 0.5),
            BarData(name: "联合基金项目(委内出资额)", percent: 0.2),
            BarData(name: "国家重大科研仪器研制项目", percent: 0.3),
            BarData(name: "基础科学中心项目", percent: 0.44),
            BarData(name: "专项项目", percent: 0.55),
            BarData(name: "数学田园基金项目", percent: 0.66),
            BarData(name: "外国青年学者研究基金项目", percent: 0.77),
            BarData(name: "国际(地区)合作交流项目", percent: 0.88)
        ]
        
        var i:Int = 0
        for item in barDatas {
            let finishedBar = FinishedBar(frame: CGRect(x:Int((mainSize.width-375)/2), y:450+i*60, width:375, height:60))
            finishedBar.setData(title: item.name, percent: item.percent)
            scrollView.addSubview(finishedBar)
            i += 1
        }
        
        scrollView.contentSize = CGSize(width: 375, height: 500+60*barDatas.count)
    }
    
    @objc func tapTop() {
        
    }
    
    func httpGetNumbers() {
        let header: HTTPHeaders = [
            "Cookie": UserDefaults.standard.string(forKey: "__session")!
        ]
        Alamofire.request(getNumbersUrl, method: .post, headers: header).responseJSON { response in
            // 未登录
            if (response.response?.statusCode != 200) {
                self.jumpToLogin()
            }
            // 已登录
            else {
                if response.result.isSuccess {
                    //把得到的JSON数据转为数组
                    // print(response.result.value)
                    let items = response.result.value as? Dictionary<String, Any>
                    // Dictionary
                }
            }
        }
    }
    
    @objc func refreshNumbers(sender: UIButton) {
        httpGetNumbers()
    }
    
    func jumpToLogin() {
        let loginVC = self.storyboard?.instantiateViewController(withIdentifier: "LoginController") as! LoginController
        self.present(loginVC, animated: true, completion: nil)
    }
}

