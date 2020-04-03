//
//  DepViewController.swift
//  iOSDataDisplay
//
//  Created by Flora on 2020/4/1.
//  Copyright © 2020年 yinmeng. All rights reserved.
//

import UIKit

class DepViewController: UIViewController, UICollectionGridViewSortDelegate {
    
    var titleTxt: String = ""
    
    @IBOutlet var barTxt: UINavigationItem!
    @IBOutlet var back: UIBarButtonItem!
    @IBOutlet var scroll: UIScrollView!
    
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
        // 绑定返回键
        back.action = #selector(backToIndex)
        // barTxt
        barTxt.title = titleTxt
        drawNumbers()
        drawGrid()
    }
    
    func drawNumbers() {
        label1 = UILabel(frame: CGRect(x: (mainSize.width-375)/2+10, y: 25, width: 150, height: 20))
        label1.text = "部门总体数据"
        label1.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        scroll.addSubview(label1)
        
        numbers = DepNumber(frame: CGRect(x: (mainSize.width-375)/2, y: 50, width: 375, height: 80))
        numbers.setNumbers(num1: 123456789, num2: 123, num3: 100)
        numbers.setColors(color: Colors.blue)
        scroll.addSubview(numbers)
        
        label2 = UILabel(frame: CGRect(x: (mainSize.width-375)/2+10, y: 150, width: 150, height: 20))
        label2.text = "部门项目情况"
        label2.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        scroll.addSubview(label2)
    }
    
    func drawGrid() {
        gridView = UIView(frame: CGRect(x: (mainSize.width-375)/2, y: 175, width: 375, height: 400))
        gridViewController = UICollectionGridViewController()
        gridViewController.setColumns(columns: ["项目", "批准数", "资助金额"])
        gridViewController.addRow(row: ["hanggesfsfsffsfs", "100", "8000000000"])
        gridViewController.addRow(row: ["张三", "223", "16"])
        gridViewController.addRow(row: ["李四", "143", "25"])
        gridViewController.addRow(row: ["王五", "75", "2"])
        gridViewController.addRow(row: ["韩梅梅", "43", "12"])
        gridViewController.addRow(row: ["李雷", "33", "27"])
        gridViewController.sortDelegate = self
        gridView.addSubview(gridViewController.view)
        scroll.addSubview(gridView)
        scroll.contentSize = CGSize(width: 375, height: 180+gridViewController.view.frame.height)
    }
    
    @objc func backToIndex() {
        self.dismiss(animated: true, completion: nil)
    }
    
    //表格排序函数
    func sort(colIndex: Int, asc: Bool, rows: [[Any]]) -> [[Any]] {
        let sortedRows = rows.sorted { (firstRow: [Any], secondRow: [Any])
            -> Bool in
            let firstRowValue = firstRow[colIndex] as! String
            let secondRowValue = secondRow[colIndex] as! String
            if colIndex == 0 || colIndex == 1 {
                //首例、姓名使用字典排序法
                if asc {
                    return firstRowValue < secondRowValue
                }
                return firstRowValue > secondRowValue
            } else if colIndex == 2 || colIndex == 3 {
                //中间两列使用数字排序
                if asc {
                    return Int(firstRowValue)! < Int(secondRowValue)!
                }
                return Int(firstRowValue)! > Int(secondRowValue)!
            }
            //最后一列数据先去掉百分号，再转成数字比较
            let firstRowValuePercent = Int(String(firstRowValue[..<firstRowValue.index(before: firstRowValue.endIndex)]))!
            let secondRowValuePercent = Int(String(secondRowValue[..<secondRowValue.index(before: secondRowValue.endIndex)]))!
            if asc {
                return firstRowValuePercent < secondRowValuePercent
            }
            return firstRowValuePercent > secondRowValuePercent
        }
        return sortedRows
    }
}
