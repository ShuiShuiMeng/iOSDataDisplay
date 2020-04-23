//
//  FinishedBar.swift
//  One progress bar with two labels
//  label1: title  lable2: percent
//
//  Created by Flora on 2020/3/23.
//  Copyright © 2020年 yinmeng. All rights reserved.
//

import UIKit

@IBDesignable class FinishedBar: UIView {

    // 项目分类
    @IBOutlet var titleLabel: UILabel!
    // 百分比数字
    @IBOutlet var percentLabel: UILabel!
    // 项目三数据
    @IBOutlet var planLabel: UILabel!
    @IBOutlet var excLabel: UILabel!
    @IBOutlet var numsLabel: UILabel!
    // 进度条
    @IBOutlet var progressView: UIProgressView!
    // 项目分类字符串
    @IBInspectable var titleStr:String = "项目名称" {
        didSet {
            titleLabel.text = titleStr
        }
    }
    // 百分比数字
    @IBInspectable var percentNum:Float = 0 {
        didSet {
            percentLabel.text = "执行率：" + (percentNum*100).cleanZero + "%"
            progressView.progress = percentNum
        }
    }
    // 项目总数
    @IBInspectable var proNum: Int = 0 {
        didSet {
            numsLabel.text = "项目数：" + String(proNum)
        }
    }
    // 计划总数
    @IBInspectable var planNum: Float = 0 {
        didSet {
            planLabel.text = "计划额度：" + planNum.cleanZero
        }
    }
    // 执行总数
    @IBInspectable var excNum: Float = 0 {
        didSet {
            excLabel.text = "执行资金：" + excNum.cleanZero
        }
    }
    
    
    func initial() {
        titleStr = "项目"
        percentNum = 0.5
        progressView.transform = CGAffineTransform(scaleX: 1.0, y: 2.0)
        setBackgrond(color: .white)
    }
    
    func setData(title:String, percent:Float, total: Int, plan: Float, exc: Float) {
        titleStr = title
        percentNum = percent
        proNum = total
        planNum = plan
        excNum = exc
    }
    
    func setBackgrond(color: UIColor) {
        contentView.backgroundColor = color
    }
    
    var contentView:UIView!
    
    //初始化时将xib中的view添加进来
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView = loadViewFromNib()
        initial()
        addSubview(contentView)
    }
    
    //初始化时将xib中的view添加进来
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        contentView = loadViewFromNib()
        initial()
        addSubview(contentView)
    }
    //加载xib
    func loadViewFromNib() -> UIView {
        let className = type(of: self)
        let bundle = Bundle(for: className)
        let name = NSStringFromClass(className).components(separatedBy: ".").last
        let nib = UINib(nibName: name!, bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil).first as! UIView
        return view
    }
}
