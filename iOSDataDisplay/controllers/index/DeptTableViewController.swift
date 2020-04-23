//
//  DeptTableView.swift
//  iOSDataDisplay
//
//  Created by Flora on 2020/4/21.
//  Copyright © 2020年 yinmeng. All rights reserved.
//

import UIKit

class DeptTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var tableView: UITableView!
    let cellIDstr: String = "cell"
    var Arr: [GetDeptInfoModel.resObj.Projects]! = [] // 存储显示数据
    var selectedCellIndexPaths: [IndexPath] = []
    // 模块高度
    static var cellH: CGFloat = 50
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        // print(view.frame)
        tableView = UITableView(frame: CGRect(x: 0, y: 0, width: 340, height: 500), style: .plain)
        tableView.register(ProjectsCell.self, forCellReuseIdentifier: cellIDstr)
        tableView.delegate = self
        tableView.dataSource = self
        setExtraCellLineHidden(tableview: tableView)
        
        // 底部分割线左对齐
        tableView.separatorInset = UIEdgeInsets.zero
        tableView.layoutMargins = UIEdgeInsets.zero
        tableView.cellLayoutMarginsFollowReadableWidth = false
        
        // tableView.reloadData()
        
        self.view.addSubview(tableView)
    }
    
    func setExtraCellLineHidden(tableview: UITableView) {
        let view = UIView()
        view.backgroundColor = .clear
        tableview.tableFooterView = view
    }
    
    func addRow(row: GetDeptInfoModel.resObj.Projects) {
        Arr.append(row)
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Arr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: cellIDstr) as? ProjectsCell
        if cell == nil {
            cell = ProjectsCell(style: .default, reuseIdentifier: cellIDstr)
        }
        else {
            // 删除旧视图
            for view in cell!.contentView.subviews {
                view.removeFromSuperview()
            }
        }
        cell!.selectionStyle = UITableViewCell.SelectionStyle.none
        
        cell?.initCategory(name: Arr[indexPath.row].Name)
        cell?.initApproval(approval: Arr[indexPath.row].ApprovedItems)
        cell?.initFundding(fundding: Arr[indexPath.row].Fundding)
        cell?.initPulldown()
        cell?.initDetails(percent: Arr[indexPath.row].Limit/Arr[indexPath.row].TotalLimit, limit: Arr[indexPath.row].Limit, finishedPercent: Arr[indexPath.row].Fundding/Arr[indexPath.row].Limit)
        
        // 点击展开
        if selectedCellIndexPaths.contains(indexPath) {
            cell?.setDown()
        }
        else {
            cell?.setRight()
        }
        
        cell!.layer.masksToBounds = true
        return cell!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        var height = CGFloat()
        if (selectedCellIndexPaths.contains(indexPath)) {
            height = 106
        }
        else {
            height = 50
        }
        return height
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // 点击展开
        if let index = selectedCellIndexPaths.firstIndex(of: indexPath) {
            selectedCellIndexPaths.remove(at: index)
        } else {
            selectedCellIndexPaths.append(indexPath)
        }
        // print("click me")
        
        // 刷新cell
        tableView.reloadRows(at: [indexPath], with: .automatic)
    }

}
