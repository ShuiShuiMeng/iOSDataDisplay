//
//  DeptViewController.swift
//  iOSDataDisplay
//
//  Created by Flora on 2020/4/20.
//  Copyright © 2020年 yinmeng. All rights reserved.
//

import UIKit
import Alamofire

class DeptViewController: UIViewController {

    var deptID: Int = 0
    var height: CGFloat = 0
    var tableH: CGFloat = 0
    
    @IBOutlet var header: UIView!
    var backButton: BackButton!
    
    @IBOutlet var wapper: UIScrollView!
    var progressView: COProgressView!
    var projectsLabel: UILabel!
    var funddingLabel: UILabel!
    
    var deptView: UIView!
    var deptLabel0: UILabel!
    var deptLabel1: UILabel!
    var deptLabel2: UILabel!
    var deptLabel3: UILabel!
    
    var deptTable: DeptTableViewController!
    
    
    var projects: Int = 100 {
        didSet {
            projectsLabel.text = String(projects)
        }
    }
    
    var fundding: Float = 3700 {
        didSet {
            funddingLabel.text = fundding.cleanZero
        }
    }
    
    var refreshing: Bool = false {
        didSet {
            if (self.refreshing) {
                wapper.refreshControl?.beginRefreshing()
                print("Loading")
            }
            else {
                wapper.refreshControl?.endRefreshing()
                print("Loaded")
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let headers: HTTPHeaders = [
            "Cookie": getSession()!,
            "Content-Type": "application/x-www-form-urlencoded"
        ]
        let parameters = [
            "deptId": deptID
        ]
        Alamofire.request(getDeptInfoUrl, method: .post, parameters: parameters, headers: headers).responseJSON {
            response in
            if response.result.isSuccess {
                if (response.result.value! is NSNull) {
                    self.jumpLoginbox(_message: "您的账号权限类型为 Normal，且所属部门没有权限访问 APP 数据。请联系管理员升级为 Supervisor 权限或更换绑定部门后访问。")
                }
                else if (response.response?.statusCode != 200) {
                    self.jumpLoginbox(_message: "登录过期，请重新登录。")
                }
                else {
                    let result = GetDeptInfoDecoder.decode(jsonData: response.data!)
                    // 判断返回结果
                    if (result.Code == 0) {
                        self.initialDept(res: result)
                    }
                    else {
                        self.jumpLoginbox(_message: "获取数据失败，请重新登录。")
                    }
                }
            }
            else {
                self.jumpLoginbox(_message: "网络出错，连接不到服务器。")
            }
            
        }
    }
    
    func initialDept(res: GetDeptInfoModel) {
        setBackgroundColor(color: Colors.blueBackground)
        drawDeptHeader()
        drawTotal(limit: res.getTotalLimit(), fundding: res.getTotalFundding(), projects: res.getTotalProjects())
        drawDeptProjects(ProjectsList: res.ObjT.DeptProjectInfoList)
        // 初始化wapper
        wapper.refreshControl = UIRefreshControl()
        wapper.refreshControl?.addTarget(self, action: #selector(onPullToFresh), for: UIControl.Event.valueChanged)
        //wapper.refreshControl = UIRefreshControl()
        //wapper.refreshControl?.addTarget(self, action: #selector(onPullToFresh), for: UIControl.Event.valueChanged)
    }
    
    @objc func onPullToFresh() {
        refreshing = true
        let headers: HTTPHeaders = [
            "Cookie": getSession()!,
            "Content-Type": "application/x-www-form-urlencoded"
        ]
        let parameters = [
            "deptId": deptID
        ]
        Alamofire.request(getDeptInfoUrl, method: .post, parameters: parameters, headers: headers).responseJSON {
            response in
            if response.result.isSuccess {
                if (response.result.value! is NSNull) {
                    self.jumpLoginbox(_message: "您的账号权限类型为 Normal，且所属部门没有权限访问 APP 数据。请联系管理员升级为 Supervisor 权限或更换绑定部门后访问。")
                }
                else if (response.response?.statusCode != 200) {
                    self.jumpLoginbox(_message: "登录过期，请重新登录。")
                }
                else {
                    let result = GetDeptInfoDecoder.decode(jsonData: response.data!)
                    // 判断返回结果
                    if (result.Code == 0) {
                        self.refreshData(res: result)
                    }
                    else {
                        self.jumpLoginbox(_message: "获取数据失败，请重新登录。")
                    }
                }
            }
            else {
                self.jumpLoginbox(_message: "网络出错，连接不到服务器。")
            }
            self.refreshing = false
        }
    }

    // 设置背景颜色
    func setBackgroundColor(color: UIColor) {
        self.view.backgroundColor = color
        header.backgroundColor = color
        wapper.backgroundColor = color
    }
    
    // 头部高度 50
    func drawDeptHeader() {
        // 返回按钮
        backButton = BackButton(frame: CGRect(x: 0, y: 0, width: 80, height: 50))
        backButton.setImage(Icons.left.iconFontImage(fontSize: 33, color: .white), for: .normal)
        backButton.setTitle("返回", for: .normal)
        backButton.titleLabel?.textColor = .white
        backButton.titleLabel?.textAlignment = .left
        backButton.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        backButton.addTarget(self, action: #selector(back), for: .touchUpInside)
        header.addSubview(backButton)
        // 部门标题
        let titleLabel = UILabel(frame: CGRect(x: mainSize.width*0.5-90, y: 10, width: 180, height: 30))
        titleLabel.textColor = .white
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        titleLabel.text = DeptID[deptID]
        header.addSubview(titleLabel)
    }
    
    // 上半部
    func drawTotal(limit: Float, fundding: Float, projects pros: Int) {
        // 次级标题
        let titleLabel = UILabel(frame: CGRect(x: 25, y: 10, width: 150, height:20))
        titleLabel.textColor = .white
        titleLabel.textAlignment = .left
        titleLabel.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        titleLabel.text = "部门总体数据"
        wapper.addSubview(titleLabel)
        height = titleLabel.frame.maxY //更新高度
        
        // 进度环
        progressView = COProgressView(frame: CGRect(x: mainSize.width*0.5-100, y: height, width: 200, height: 200), lineWidth: 18, trackColor: Colors.trackblue, progressColor: Colors.lightblue, idotColor: Colors.idotblue)
        // progressView.setProgress(0.667, animated: true, withDuration: 1.0)
        progressView.setData(plan: limit, fund: fundding, animated: true, withDuration: 1.0)
        wapper.addSubview(progressView)
        height = progressView.frame.maxY
        
        // 竖线
        let lineView = UIView(frame: CGRect(x: mainSize.width/2, y: height+18, width: 0.3, height: 34))
        lineView.backgroundColor = Colors.ligthgray
        wapper.addSubview(lineView)
        
        // 当前项目数
        projectsLabel = UILabel(frame: CGRect(x: mainSize.width/2-150, y: height+10, width: 150, height: 25))
        projectsLabel.textColor = .white
        projectsLabel.textAlignment = .center
        projectsLabel.font = UIFont(descriptor: UIFontDescriptor(name: "DIN Alternate Bold", size: 17), size: 17)
        projectsLabel.text = String(pros)
        wapper.addSubview(projectsLabel)
        
        // 说明
        let proLabel = UILabel(frame: CGRect(x: mainSize.width/2-150, y: height+35, width: 150, height: 25))
        proLabel.textColor = Colors.ligthgray
        proLabel.textAlignment = .center
        proLabel.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        proLabel.text = "当前项目数"
        wapper.addSubview(proLabel)
        
        // 已资助金额
        funddingLabel = UILabel(frame: CGRect(x: mainSize.width/2+1, y: height+10, width: 150, height: 25))
        funddingLabel.textColor = .white
        funddingLabel.textAlignment = .center
        funddingLabel.font = UIFont(descriptor: UIFontDescriptor(name: "DIN Alternate Bold", size: 17), size: 17)
        funddingLabel.text = fundding.cleanZero
        wapper.addSubview(funddingLabel)
        // 说明
        let fundLabel = UILabel(frame: CGRect(x: mainSize.width/2+1, y: height+35, width: 150, height: 25))
        fundLabel.textColor = Colors.ligthgray
        fundLabel.textAlignment = .center
        fundLabel.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        fundLabel.text = "已资助金额(万)"
        wapper.addSubview(fundLabel)
        height = fundLabel.frame.maxY
        tableH = height
    }
    
    func drawDeptProjects(ProjectsList: [GetDeptInfoModel.resObj.Projects]) {
        // 白色view
        if (deptView != nil) {
            deptView.removeFromSuperview()
        }
        // 使用tableH记录起始点
        deptView = UIView(frame: CGRect(x: mainSize.width/2-170, y: tableH+10, width: 340, height: 580))
        deptView.backgroundColor = .white
        deptView.layer.cornerRadius = 5
        wapper.addSubview(deptView)
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
        deptLabel1 = UILabel(frame: CGRect(x: 25, y: 50, width: 155, height: 20))
        deptLabel1.textColor = Colors.ligthgray
        deptLabel1.textAlignment = .left
        deptLabel1.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        deptLabel1.text = "项目类别"
        deptView.addSubview(deptLabel1)
        // 批准数
        deptLabel2 = UILabel(frame: CGRect(x: 160, y: 50, width: 60, height: 20))
        deptLabel2.textColor = Colors.ligthgray
        deptLabel2.textAlignment = .right
        deptLabel2.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        deptLabel2.text = "批准数"
        deptView.addSubview(deptLabel2)
        // 已资助(万)
        deptLabel3 = UILabel(frame: CGRect(x: 240, y: 50, width: 83, height: 20))
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
        // let botHeight = min(mainSize.width/2-175, mainSize.height-height-5)
        let botView = UIView(frame: CGRect(x: 0, y: height+5, width: mainSize.width, height: mainSize.width/2-175))
        botView.backgroundColor = Colors.blueBackground
        wapper.addSubview(botView)
        
        wapper.contentSize = CGSize(width: mainSize.width, height: botView.frame.maxY)
    }
    
    @objc func back(sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func refreshData(res: GetDeptInfoModel) {
        // 刷新圆环
        progressView.setData(plan: res.getTotalLimit(), fund: res.getTotalFundding(), animated: true)
        
        // 刷新左右数字
        projectsLabel.text = String(res.getTotalProjects())
        funddingLabel.text = res.getTotalFundding().cleanZero
        
        // 刷新表格
        drawDeptProjects(ProjectsList: res.ObjT.DeptProjectInfoList)
    }
}
