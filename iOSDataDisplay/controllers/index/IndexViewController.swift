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
    
    var content: Index!
    var barsView: UIView!
    
    var barDatas: Array<BarData> = []
    var depDatas: Array<DepData> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let user: String = getRoleFromCookie()!
        if user == "Supervisor" {
            initialIndex()
        }
        else if user == "Normal" {
            let header: HTTPHeaders = [
                "Cookie": getSession()!
            ]
            Alamofire.request(getDeptInfoUrl, method: .post, headers: header).responseJSON {
                response in
                if response.result.isSuccess {
                    if (response.result.value! is NSNull) {
                        self.jumpLoginbox(_message: "您的账号权限类型为normal，且所属部门没有权限访问App数据。请联系管理员升级为supervisor权限或更换绑定部门后访问App。")
                    }
                    else if (response.response?.statusCode != 200) {
                        self.jumpLoginbox(_message: "登录权限过期，请重新登录")
                    }
                    else {
                        let result = GetDeptInfoDecoder.decode(jsonData: response.data!)
                        // 判断返回结果
                        if (result.Code == 0) {
                            self.initialDep(res: result)
                        }
                        else {
                            self.jumpLoginbox(_message: "获取数据失败，点击返回重新登录")
                        }
                    }
                }
                else {
                    self.jumpLoginbox(_message: "网络出错，连接不到服务器")
                }
                
            }
        }
    }
    
    func getLoginStatus() -> LoginStatus {
        return LoginStatus.LOGIN
    }
    
    func initialIndex() {
        scrollView.backgroundColor = Colors.background
        loadIcons()
        drawTopView()
        loadIndex()
        httpGetNumbers(flag: false)
        drawDeps()
        
    }
    
    func loadIcons() {
        indexItem.selectedImage = Icons.indexIconB.iconFontImage(fontSize: 35, color: .gray)
    }
    
    func loadIndex() {
        content = Index(frame: CGRect(x:(mainSize.width-375)/2, y:0, width:375, height:300))
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
            DepData(name: "数理科学部", x: 0, y: 0, icon: Icons.slIcon),
            DepData(name: "化学科学部", x: 95, y: 0, icon: Icons.hxIcon),
            DepData(name: "生命科学部", x: 190, y: 0, icon: Icons.smIcon),
            DepData(name: "地球科学部", x: 285, y: 0, icon: Icons.dqIcon),
            DepData(name: "工材科学部", x: 0, y: 95, icon: Icons.gcIcon),
            DepData(name: "信息科学部", x: 95, y: 95, icon: Icons.xxIcon),
            DepData(name: "管理科学部", x: 190, y: 95, icon: Icons.glIcon),
            DepData(name: "医学科学部", x: 285, y: 95, icon: Icons.yxIcon)
        ]
        
        var tag = 10
        for item in depDatas {
            let tmpBtn = DepButton(frame: CGRect(x: (mainSize.width-375)/2+item.x, y: 255+item.y, width: 90, height: 90))
            tmpBtn.setTitle(item.name, for: .normal)
            tmpBtn.setTitleColor(.black, for: .normal)
            tmpBtn.setImage(item.icon.iconFontImage(fontSize: 30, color: .orange), for: .normal)
            tmpBtn.setBackgroundColor(color: Colors.background, forState: .normal)
            tmpBtn.addTarget(self, action: #selector(tapToDetails(sender:)), for: .touchUpInside)
            tmpBtn.backgroundColor = UIColor(red: 248/255, green: 247/255, blue: 247/255, alpha: 0.5)
            tmpBtn.tag = tag
            tag = tag + 1
            scrollView.addSubview(tmpBtn)
        }
        
        let finLabel = UILabel(frame: CGRect(x:(mainSize.width-375)/2+10, y:465, width: 100, height: 20))
        finLabel.text = "项目完成度"
        finLabel.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        scrollView.addSubview(finLabel)
        scrollView.addSubview(drawLine(x: 0, y: 494, width: mainSize.width, height: 1, color: Colors.deepGray))
    }
    
    @objc func tapToDetails(sender: UIButton) {
        jumpToDetails(depId: sender.tag)
    }
    
    func jumpToDetails(depId: Int) {
        let depVC = self.storyboard?.instantiateViewController(withIdentifier: "DepViewController") as! DepViewController
        depVC.depId = depId
        self.present(depVC, animated: true, completion: nil)
    }
    
    // flag=true表示是点击了刷新按钮，而非首次加载
    func drawBars(flag: Bool) {
        // get datas
        let header: HTTPHeaders = [
            "Cookie": UserDefaults.standard.string(forKey: "__session")!
        ]
        Alamofire.request(getProjectsUrl, method: .post, headers: header).responseJSON { response in
            // 未登录
            if (response.response?.statusCode != 200) {
                self.jumpLoginbox(_message: "登录状态失效，请重新登录")
            }
                // 已登录
            else {
                if response.result.isSuccess {
                    //把得到的JSON数据转为数组
                    if response.result.value! is NSNull {
                        self.showMsgbox(_message: "网络错误，没有数据被更新")
                    }
                    else if response.response?.statusCode != 200 {
                        self.showMsgbox(_message: "网络错误，没有数据被更新")
                    }
                    else {
                        // print(response)
                        if (flag) {
                            self.barDatas.removeAll()
                            // 去除旧view
                            self.barsView.removeFromSuperview()
                        }
                        let result = GetProjectsInfoDecoder.decode(jsonData: response.data!)
                        for item in result.ObjT.ProjectInfoList {
                            self.barDatas.append(BarData(name: item.Name, percent: item.ExeRate, total: item.Items, plan: item.TotalOfPlan, exc: item.ExeQuota))
                        }
                        
                        self.refreshBars()
                    }
                }
                else {
                    self.showMsgbox(_message: "网络错误，没有数据被更新")
                }
            }
        }
        
        
    }
    
    func refreshBars() {
        barsView = UIView(frame: CGRect(x: (mainSize.width-375)/2, y: 495, width: 375, height: CGFloat(70*barDatas.count)))
        var i:Int = 0
        for item in barDatas {
            let finishedBar = FinishedBar(frame: CGRect(x:0, y:i*70, width:375, height:70))
            finishedBar.setData(title: item.name, percent: item.percent, total: item.total, plan: item.plan, exc: item.exc)
            finishedBar.addSubview(drawLine(x: 10, y: 69.3, width: mainSize.width-20, height: 0.7, color: Colors.lineGray))
            barsView.addSubview(finishedBar)
            i += 1
        }
        scrollView.addSubview(barsView)
        scrollView.contentSize = CGSize(width: 375, height: 495 + barsView.frame.height)
    }
    
    @objc func tapTop() {
        
    }
    
    func httpGetNumbers(flag: Bool) {
        let header: HTTPHeaders = [
            "Cookie": UserDefaults.standard.string(forKey: "__session")!
        ]
        Alamofire.request(getNumbersUrl, method: .post, headers: header).responseJSON { response in
            // 未登录
            if (response.response?.statusCode != 200) {
                self.jumpLoginbox(_message: "登录状态失效，请重新登录")
            }
            // 已登录
            else {
                if response.result.isSuccess {
                    //把得到的JSON数据转为数组
                    if response.result.value! is NSNull {
                        self.showMsgbox(_message: "网络错误，只更新了“数据显示”部分")
                    }
                    else if response.response?.statusCode != 200 {
                        self.showMsgbox(_message: "网络错误，只更新了“数据显示”部分")
                    }
                    else {
                        let result = GetAllDecoder.decode(jsonData: response.data!)
                        self.content.setNumbers(budget: result.ObjT.Budget, total: result.ObjT.TotalOfPlan, exeQuota: result.ObjT.ExeQuota, exeRate: result.ObjT.ExeRate)
                        self.drawBars(flag: flag)
                        if (flag) {
                            self.showMsgbox(_message: "已更新至所有最新数据")
                        }
                    }
                }
                else {
                    self.showMsgbox(_message: "网络错误，只更新了“数据显示”部分")
                }
            }
        }
    }
    
    @objc func refreshNumbers(sender: UIButton) {
        httpGetNumbers(flag: true)
    }
    
    /*
     * normal
     * 渲染部门页面
     */
    var numbers: DepNumber!
    var label1: UILabel!
    var label2: UILabel!
    var gridView: UIView!
    var gridViewController: UICollectionGridViewController!

    func initialDep(res: GetDeptInfoModel) {
        scrollView.backgroundColor = Colors.background
        loadIcons()
        drawTopBar(titleTxt: "首页")
        drawNumbers()
        getNumbers(flag: false)
    }
    
    func drawNumbers() {
        label1 = UILabel(frame: CGRect(x: (mainSize.width-375)/2+10, y: 25, width: 150, height: 20))
        label1.text = "部门总体数据"
        label1.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        scrollView.addSubview(label1)
        
        numbers = DepNumber(frame: CGRect(x: (mainSize.width-375)/2+5, y: 50, width: 365, height: 80))
        numbers.setNumbers(num1: 123456789, num2: 123, num3: 100)
        numbers.setColors(color: UIColor.orange)
        scrollView.addSubview(numbers)
        
        label2 = UILabel(frame: CGRect(x: (mainSize.width-375)/2+10, y: 150, width: 150, height: 20))
        label2.text = "部门项目情况"
        label2.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        scrollView.addSubview(label2)
    }
    
    func drawGrid(rows: Int) {
        gridView = UIView(frame: CGRect(x: (mainSize.width-375)*0.5, y: 175, width: 375, height: CGFloat(rows+1) * 40))
        gridViewController = UICollectionGridViewController()
        gridViewController.view.frame = CGRect(x:  (mainSize.width-375)*0.5+5, y: 0, width: 365, height: CGFloat(rows+1) * 38)
        gridViewController.setColumns(columns: ["项目", "批准数", "资助金额", "资助上限"])
        gridView.addSubview(gridViewController.view)
        scrollView.addSubview(gridView)
        scrollView.contentSize = CGSize(width: 375, height: 180+gridViewController.view.frame.height)
    }
    
    func addRow(name: String, item: Int, fund:Float, limit:Float) {
        gridViewController.addRow(row: [name, item, fund.cleanZero, limit.cleanZero])
    }
    
    func drawTopBar(titleTxt: String) {
        // 导航条颜色
        // bar.backgroundColor = UIColor.blue
        // barTxt
        topView.backgroundColor = Colors.blue
        let titleLabel = UILabel(frame: CGRect(x: mainSize.width*0.5-100, y: 5, width: 200, height: 40))
        titleLabel.text = titleTxt
        titleLabel.textAlignment = .center
        titleLabel.textColor = .white
        titleLabel.font = UIFont.systemFont(ofSize: 18)
        topView.addSubview(titleLabel)
        
        refresh = UIButton(frame: CGRect(x: mainSize.width-50, y: 0, width: 50, height: 50))
        refresh.setImage(Icons.refreshIcon.iconFontImage(fontSize: 22, color: .white), for: .normal)
        refresh.addTarget(self, action: #selector(refreshData), for: .touchUpInside)
        topView.addSubview(refresh)
    }
    
    func getNumbers(flag: Bool) {
        let header: HTTPHeaders = [
            "Cookie": getSession()!
        ]
        Alamofire.request(getDeptInfoUrl, method: .post, headers: header).responseJSON {
            response in
            if (response.response?.statusCode != 200) {
                self.jumpLoginbox(_message: "登录权限过期，请重新登录")
            }
                
            else if response.result.isSuccess {
                if (response.result.value! is NSNull) {
                    self.jumpIndexbox(_message: "网络错误")
                }
                else if response.response?.statusCode == 200 {
                    let result = GetDeptInfoDecoder.decode(jsonData: response.data!)
                    // 判断返回结果
                    if (result.Code == 0) {
                        if (flag) {
                            self.clearRows()
                        }
                        else {
                            self.drawGrid(rows: result.ObjT.TotalProjects)
                        }
                        var planNum: Float = 0
                        var proNum: Int = 0
                        var excuted: Float = 0
                        for info in result.ObjT.DeptProjectInfoList {
                            self.addRow(name: info.Name, item: info.ApprovedItems, fund: info.Fundding, limit: info.Limit)
                            planNum = planNum + Float(info.Limit)
                            proNum = proNum + info.ApprovedItems
                            excuted = excuted + info.Fundding
                        }
                        self.numbers.setNumbers(num1: planNum, num2: proNum, num3: excuted)
                        if (flag) {
                            self.showMsgbox(_message: "数据已更新至最新")
                        }
                    }
                    else {
                        self.jumpIndexbox(_message: "获取数据失败")
                    }
                }
                else {
                    self.jumpLoginbox(_message: "未知错误")
                }
            }
            else {
                self.jumpIndexbox(_message: "网络出错，连接不到服务器")
            }
            
        }
    }
    
    @objc func refreshData() {
        getNumbers(flag: true)
    }
    
    func clearRows() {
        gridViewController.clearRows()
    }
    
    @objc func backToIndex() {
        self.dismiss(animated: true, completion: nil)
    }
    
}

