//
//  DepViewController.swift
//  iOSDataDisplay
//
//  Created by Flora on 2020/4/1.
//  Copyright © 2020年 yinmeng. All rights reserved.
//

import UIKit
import Alamofire

class DepViewController: UIViewController {
    
    var depId: Int = 0
    
    @IBOutlet var header: UIView!
    @IBOutlet var scroll: UIScrollView!
    var back: BackButton!
    var refresh: UIButton!
    
    var numbers: DepNumber!
    var label1: UILabel!
    var label2: UILabel!
    var gridView: UIView!
    var gridViewController: UICollectionGridViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initial()
    }
    
    func initial() {
        drawTopBar()
        drawNumbers()
        getNumbers(flag: false)
    }
    
    func getNumbers(flag: Bool) {
        let header: HTTPHeaders = [
            "Cookie": getSession()!,
            "Content-Type": "application/x-www-form-urlencoded"
        ]
        let parameters = [
            "deptId": depId
        ]
        Alamofire.request(getDeptInfoUrl, method: .post, parameters: parameters, headers: header).responseJSON {
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
    
    func drawNumbers() {
        label1 = UILabel(frame: CGRect(x: (mainSize.width-375)/2+10, y: 25, width: 150, height: 20))
        label1.text = "部门总体数据"
        label1.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        scroll.addSubview(label1)
        
        numbers = DepNumber(frame: CGRect(x: (mainSize.width-375)/2+5, y: 50, width: 365, height: 80))
        numbers.setNumbers(num1: 123456789, num2: 123, num3: 100)
        numbers.setColors(color: UIColor.orange)
        scroll.addSubview(numbers)
        
        label2 = UILabel(frame: CGRect(x: (mainSize.width-375)/2+10, y: 150, width: 150, height: 20))
        label2.text = "部门项目情况"
        label2.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        scroll.addSubview(label2)
    }
    
    func drawGrid(rows: Int) {
        print("draw grid")
        gridView = UIView(frame: CGRect(x: 0, y: 175, width: 375, height: CGFloat(rows+1) * 40))
        gridViewController = UICollectionGridViewController()
        gridViewController.view.frame = CGRect(x: 5, y: 0, width: 365, height: CGFloat(rows+1) * 38)
        gridViewController.setColumns(columns: ["项目", "批准数", "资助金额", "资助上限"])
        gridView.addSubview(gridViewController.view)
        scroll.addSubview(gridView)
        // print(gridViewController.collectionView!.frame.height)
        scroll.contentSize = CGSize(width: 375, height: CGFloat(180) + CGFloat(rows+1) * 37.9)
    }
    
    func addRow(name: String, item: Int, fund:Float, limit:Float) {
        gridViewController.addRow(row: [name, item, fund.cleanZero, limit.cleanZero])
    }
    
    func clearRows() {
        gridViewController.clearRows()
    }
    
    func drawTopBar() {
        // 导航条颜色
        // bar.backgroundColor = UIColor.blue
        // barTxt
        header.backgroundColor = Colors.blue
        let titleLabel = UILabel(frame: CGRect(x: mainSize.width*0.5-100, y: 5, width: 200, height: 40))
        titleLabel.text = DeptID[depId]!
        titleLabel.textAlignment = .center
        titleLabel.textColor = .white
        titleLabel.font = UIFont.systemFont(ofSize: 18)
        header.addSubview(titleLabel)
        
        back = BackButton(frame: CGRect(x: 0, y: 0, width: 100, height: 50))
        back.setImage(Icons.left.iconFontImage(fontSize: 30, color: .white), for: .normal)
        back.addTarget(self, action: #selector(backToIndex), for: .touchUpInside)
        header.addSubview(back)
        
        refresh = UIButton(frame: CGRect(x: mainSize.width-40, y: 0, width: 40, height: 50))
        refresh.setImage(Icons.refreshIcon.iconFontImage(fontSize: 22, color: .white), for: .normal)
        refresh.addTarget(self, action: #selector(refreshData(sender:)), for: .touchUpInside)
        header.addSubview(refresh)
    }
    
    @objc func backToIndex() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func refreshData(sender: UIButton) {
        getNumbers(flag: true)
        //var popTip = PopTip()
        //popTip.show(text: "Hey! Listen!", direction: .up, maxWidth: 200, in: view, from: someView.frame)
    }
}
