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
    
    var header: UIView!
    var scrollView: UIScrollView!
    
    @IBOutlet var wapper: UIView!
    @IBOutlet var indexItem: UITabBarItem!
    
    
    var totalView: UIView!
    var topButton: UIButton!
    var barsView: UIView!
    
    var deptView: UIView!
    var chopView: CHOProgressView!
    
    var barDatas: Array<BarData> = []
    var depDatas: Array<DepData> = []
    
    var height: CGFloat = 0
    
    var refreshing: Bool = false {
        didSet {
            if (self.refreshing) {
                scrollView.refreshControl?.beginRefreshing()
            }
            else {
                scrollView.refreshControl?.endRefreshing()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 高度清空
        height = 0
        let user: String = getRoleFromCookie()!
        let headers: HTTPHeaders = [
            "Cookie": getSession()!
        ]
        // Supervisor权限
        if user == "Supervisor" {
            // Alamofire
            initialIndex()
        }
        // Normal权限
        else if user == "Normal" {
            Alamofire.request(getDeptInfoUrl, method: .post, headers: headers).responseJSON {
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
                            self.initialDept(res: result)
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
        loadIcons()
        initialViews()
        drawIndexHeader()
        drawTotal()
        httpGetNumbers()
        drawDepts()
        scrollView.refreshControl = UIRefreshControl()
        scrollView.refreshControl?.addTarget(self, action: #selector(onPullToFreshIndex), for: UIControl.Event.valueChanged)
    }
    
    func initialViews() {
        // 滚动视图
        scrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: wapper.frame.width, height: wapper.frame.height))
        
        scrollView.backgroundColor = Colors.graybackground
        wapper.addSubview(scrollView)
        
        // 头部
        header = UIView(frame: CGRect(x: 0, y: 0, width: wapper.frame.width, height: 50))
        header.backgroundColor = Colors.blueBackground
        scrollView.addSubview(header)
        height = header.frame.height
    }
    
    func loadIcons() {
        indexItem.selectedImage = Icons.indexIconB.iconFontImage(fontSize: 35, color: .gray)
    }
    
    func drawIndexHeader() {
        topButton = UIButton(frame: CGRect(x: 10, y: 5, width: mainSize.width-20, height: 40))
        topButton.titleLabel?.numberOfLines = 2
        topButton.titleLabel?.lineBreakMode = NSLineBreakMode.byCharWrapping
        topButton.titleLabel?.textAlignment = .center
        topButton.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        topButton.setTitle("2020年度科学基金资助计划\n（国科金发〔2020〕X号）", for: .normal)
        topButton.setTitleColor(UIColor(red: 158/255.0, green: 188/255.0, blue: 240/255.0, alpha: 1), for: .normal)
        topButton.addTarget(self, action: #selector(tapTop), for: .touchUpInside)
        header.addSubview(topButton)
    }
    
    func drawTotal() {
        totalView = UIView(frame: CGRect(x: 0, y: height, width: mainSize.width, height: 240))
        totalView.backgroundColor = Colors.blueBackground
        // 进度条
        chopView = CHOProgressView(frame: CGRect(x: mainSize.width*0.5-120, y: 15, width: 240, height: 160), lineWidth: 16, trackColor: Colors.trackblue, progressColor: Colors.lightblue, idotColor: Colors.idotblue)
        totalView.addSubview(chopView)
        scrollView.addSubview(totalView)
        height = totalView.frame.maxY
    }
    
    func drawDepts() {
        deptView = UIView(frame: CGRect(x: (mainSize.width-340)/2, y: height-50, width: 340, height: 150))
        deptView.backgroundColor = .white
        deptView.layer.cornerRadius = 5
        
        depDatas = [
            DepData(name: "数理", x: 34, y: 20),
            DepData(name: "化学", x: 108, y: 20),
            DepData(name: "生命", x: 182, y: 20),
            DepData(name: "地球", x: 256, y: 20),
            DepData(name: "工材", x: 34, y: 80),
            DepData(name: "信息", x: 108, y: 80),
            DepData(name: "管理", x: 182, y: 80),
            DepData(name: "医学", x: 256, y: 80)
        ]
        
        var tag = 10
        for item in depDatas {
            let tmpBtn = DepButton(frame: CGRect(x: item.x, y: item.y, width: 50, height: 50))
            tmpBtn.setTitle(item.name, for: .normal)
            tmpBtn.setTitleColor(.black, for: .normal)
            tmpBtn.setImage(UIImage(named: item.name+".jpg"), for: .normal)
            tmpBtn.setBackgroundColor(color: .white, forState: .normal)
            tmpBtn.addTarget(self, action: #selector(tapToDetails(sender:)), for: .touchUpInside)
            tmpBtn.backgroundColor = UIColor(red: 248/255, green: 247/255, blue: 247/255, alpha: 0.5)
            tmpBtn.tag = tag
            tag = tag + 1
            deptView.addSubview(tmpBtn)
        }
        scrollView.addSubview(deptView)
        height = deptView.frame.maxY
        
        let finLabel = UILabel(frame: CGRect(x:(mainSize.width-340)/2, y:height+20, width: 100, height: 20))
        finLabel.text = "项目完成度"
        finLabel.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        scrollView.addSubview(finLabel)
        height = finLabel.frame.maxY
        tableH = height
    }
    
    @objc func tapToDetails(sender: UIButton) {
        jumpToDetails(deptId: sender.tag)
    }
    
    func jumpToDetails(deptId: Int) {
        let deptVC = self.storyboard?.instantiateViewController(withIdentifier: "DeptViewController") as! DeptViewController
        deptVC.deptID = deptId
        deptVC.modalPresentationStyle = .fullScreen
        self.present(deptVC, animated: true, completion: nil)
    }
    
    func httpGetNumbers() {
        refreshing = true
        let header: HTTPHeaders = [
            "Cookie": UserDefaults.standard.string(forKey: "__session")!
        ]
        Alamofire.request(getNumbersUrl, method: .post, headers: header).responseJSON { response in
            // 未登录
            if (response.response?.statusCode != 200) {
                self.jumpLoginbox(_message: "登录状态失效，请重新登录")
                self.refreshing = false
            }
                // 已登录
            else {
                if response.result.isSuccess {
                    //把得到的JSON数据转为数组
                    if response.result.value! is NSNull {
                        self.showMsgbox(_message: "网络错误，只更新了部分数据")
                        self.refreshing = false
                    }
                    else if response.response?.statusCode != 200 {
                        self.showMsgbox(_message: "网络错误，只更新了部分数据")
                        self.refreshing = false
                    }
                    else {
                        let result = GetAllDecoder.decode(jsonData: response.data!)
                        self.chopView.setData(plan: result.ObjT.TotalOfPlan, fund: result.ObjT.ExeQuota, budget:result.ObjT.Budget, rate:result.ObjT.ExeRate, animated: true)
                        self.drawBars()
                    }
                }
                else {
                    self.showMsgbox(_message: "网络错误，只更新了部分数据")
                    self.refreshing = false
                }
            }
        }
    }
    
    func drawBars() {
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
                        self.barDatas.removeAll()
                        let result = GetProjectsInfoDecoder.decode(jsonData: response.data!)
                        // print(result.ObjT.ProjectInfoList)
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
            self.refreshing = false
        }
    }
    
    func refreshBars() {
        var totalPlan: Float = 0
        for item in barDatas {
            totalPlan = totalPlan + item.plan
        }
        if (barsView != nil) {
            barsView.removeFromSuperview()
        }
        // 总容器
        barsView = UIView(frame: CGRect(x: 0, y: tableH+10, width: mainSize.width, height: CGFloat(100*barDatas.count)))
        barsView.backgroundColor = Colors.graybackground
        
        // load bars
        var i: CGFloat = 0
        for item in barDatas {
            let bar = FinishedBar(frame: CGRect(x: 0, y: i*100, width: mainSize.width, height: 90))
            bar.setData(name: item.name, exeNum: item.exc, plan: item.plan, rate: item.plan/totalPlan)
            barsView.addSubview(bar)
            i = i + 1
        }
        scrollView.addSubview(barsView)
        height = barsView.frame.maxY
        
        scrollView.contentSize = CGSize(width: 0, height: height+50)
    }
    
    @objc func tapTop() {
        print("tap")
    }
    
    
    
    @objc func onPullToFreshIndex() {
        httpGetNumbers()
    }
    
    
    /*
     * normal
     * 渲染部门页面
     */
    var progressView: COProgressView!
    var projectsLabel: UILabel!
    var funddingLabel: UILabel!
    
    var deptLabel0: UILabel!
    var deptLabel1: UILabel!
    var deptLabel2: UILabel!
    var deptLabel3: UILabel!
    
    var pro: CGFloat = 0
    var tableH: CGFloat = 0
    
    var deptTable: DeptTableViewController!
    
    @IBInspectable var projects: Int = 100 {
        didSet {
            projectsLabel.text = String(projects)
        }
    }
    
    @IBInspectable var fundding: Float = 37000000 {
        didSet {
            funddingLabel.text = fundding.cleanZero
        }
    }
    

    
    func initialDept(res: GetDeptInfoModel) {
        loadIcons()
        initialViews()
        scrollView.backgroundColor = Colors.blueBackground
        drawDeptHeader()
        drawTotal(limit: res.getTotalLimit(), fundding: res.getTotalFundding(), projects: res.getTotalProjects())
        drawDeptProjects(ProjectsList: res.ObjT.DeptProjectInfoList)
        scrollView.refreshControl = UIRefreshControl()
        scrollView.refreshControl?.addTarget(self, action: #selector(onPullToFreshDept), for: UIControl.Event.valueChanged)
    }
    
    @objc func onPullToFresh() {
        refreshing = true
        sleep(1)
        refreshing = false
    }
    
    // 头部高度 50
    func drawDeptHeader() {
        // 部门标题
        let titleLabel = UILabel(frame: CGRect(x: mainSize.width*0.5-90, y: 10, width: 180, height: 30))
        titleLabel.textColor = .white
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        titleLabel.text = "首页"
        header.addSubview(titleLabel)
    }
    
    // 上半部
    func drawTotal(limit: Float, fundding: Float, projects pros: Int) {
        // 次级标题
        let titleLabel = UILabel(frame: CGRect(x: 25, y: height+10, width: 150, height:20))
        titleLabel.textColor = .white
        titleLabel.textAlignment = .left
        titleLabel.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        titleLabel.text = "部门总体数据"
        scrollView.addSubview(titleLabel)
        height = titleLabel.frame.maxY //更新高度
        
        // 进度环
        progressView = COProgressView(frame: CGRect(x: mainSize.width*0.5-100, y: height, width: 200, height: 200), lineWidth: 18, trackColor: Colors.trackblue, progressColor: Colors.lightblue, idotColor: Colors.idotblue)
        // progressView.setProgress(CGFloat(0), animated: true, withDuration: 1.0)
        scrollView.addSubview(progressView)
        progressView.setData(plan: limit, fund: fundding, animated: true, withDuration: 1.0)
        height = progressView.frame.maxY
        
        // 竖线
        let lineView = UIView(frame: CGRect(x: mainSize.width/2, y: height+18, width: 0.3, height: 34))
        lineView.backgroundColor = Colors.ligthgray
        scrollView.addSubview(lineView)
        
        // 当前项目数
        projectsLabel = UILabel(frame: CGRect(x: mainSize.width/2-150, y: height+10, width: 150, height: 25))
        projectsLabel.textColor = .white
        projectsLabel.textAlignment = .center
        projectsLabel.font = UIFont(descriptor: UIFontDescriptor(name: "DIN Alternate Bold", size: 17), size: 17)
        projectsLabel.text = String(pros)
        scrollView.addSubview(projectsLabel)
        // 说明
        let proLabel = UILabel(frame: CGRect(x: mainSize.width/2-150, y: height+35, width: 150, height: 25))
        proLabel.textColor = Colors.ligthgray
        proLabel.textAlignment = .center
        proLabel.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        proLabel.text = "当前项目数"
        scrollView.addSubview(proLabel)
        
        // 已资助金额
        funddingLabel = UILabel(frame: CGRect(x: mainSize.width/2+1, y: height+10, width: 150, height: 25))
        funddingLabel.textColor = .white
        funddingLabel.textAlignment = .center
        funddingLabel.font = UIFont(descriptor: UIFontDescriptor(name: "DIN Alternate Bold", size: 17), size: 17)
        funddingLabel.text = fundding.cleanZero
        scrollView.addSubview(funddingLabel)
        // 说明
        let fundLabel = UILabel(frame: CGRect(x: mainSize.width/2+1, y: height+35, width: 150, height: 25))
        fundLabel.textColor = Colors.ligthgray
        fundLabel.textAlignment = .center
        fundLabel.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        fundLabel.text = "已资助金额(万)"
        scrollView.addSubview(fundLabel)
        height = fundLabel.frame.maxY
        tableH = height
    }
    
    func drawDeptProjects(ProjectsList: [GetDeptInfoModel.resObj.Projects]) {
        // 白色view
        if (deptView != nil) {
            deptView.removeFromSuperview()
        }
        deptView = UIView(frame: CGRect(x: mainSize.width/2-170, y: tableH+10, width: 340, height: 580))
        deptView.backgroundColor = .white
        deptView.layer.cornerRadius = 5
        scrollView.addSubview(deptView)
        height = deptView.frame.maxY
        
        // 部门项目情况 label
        deptLabel0 = UILabel(frame: CGRect(x: 15, y: 15, width: 200, height: 20))
        deptLabel0.textColor = .black
        deptLabel0.textAlignment = .left
        deptLabel0.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        deptLabel0.text = "部门项目情况"
        deptView.addSubview(deptLabel0)
        
        // 三个表头
        // 项目类别
        deptLabel1 = UILabel(frame: CGRect(x: 30, y: 50, width: 130, height: 20))
        deptLabel1.textColor = Colors.ligthgray
        deptLabel1.textAlignment = .left
        deptLabel1.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        deptLabel1.text = "项目类别"
        deptView.addSubview(deptLabel1)
        // 批准数
        deptLabel2 = UILabel(frame: CGRect(x: 160, y: 50, width: 70, height: 20))
        deptLabel2.textColor = Colors.ligthgray
        deptLabel2.textAlignment = .right
        deptLabel2.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        deptLabel2.text = "批准数"
        deptView.addSubview(deptLabel2)
        // 已资助(万)
        deptLabel3 = UILabel(frame: CGRect(x: 240, y: 50, width: 70, height: 20))
        deptLabel3.textColor = Colors.ligthgray
        deptLabel3.textAlignment = .right
        deptLabel3.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        deptLabel3.text = "已资助(万)"
        deptView.addSubview(deptLabel3)
        
        // 初始化表格
        deptTable = DeptTableViewController()
        deptTable.view.frame = CGRect(x: 0, y: 70, width: 340, height: 500)
        for item in ProjectsList {
            deptTable.addRow(row: item)
        }
        deptView.addSubview(deptTable.view)
        
        // 为了美观, 添加一个底部
        let botView = UIView(frame: CGRect(x: 0, y: height+5, width: mainSize.width, height: mainSize.width/2-175))
        botView.backgroundColor = Colors.blueBackground
        scrollView.addSubview(botView)
        height = botView.frame.maxY
        scrollView.contentSize = CGSize(width: mainSize.width, height: height)
    }
    
    @objc func onPullToFreshDept() {
        refreshing = true
        let headers: HTTPHeaders = [
            "Cookie": getSession()!
        ]
        Alamofire.request(getDeptInfoUrl, method: .post, headers: headers).responseJSON {
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
                        self.refreshDeptData(res: result)
                    }
                    else {
                        self.jumpLoginbox(_message: "获取数据失败，点击返回重新登录")
                    }
                }
            }
            else {
                self.jumpLoginbox(_message: "网络出错，连接不到服务器")
            }
            self.refreshing = false
        }
    }
    
    func refreshDeptData(res: GetDeptInfoModel) {
        // 刷新圆环
        progressView.setData(plan: res.getTotalLimit(), fund: res.getTotalFundding(), animated: true)
        
        // 刷新左右数字
        projects = res.getTotalProjects()
        fundding = res.getTotalFundding()
        
        // 刷新表格
        drawDeptProjects(ProjectsList: res.ObjT.DeptProjectInfoList)
    }
}

