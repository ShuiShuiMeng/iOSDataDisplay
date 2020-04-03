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
    // 进度条
    @IBOutlet var processView: UIProgressView!
    // 项目分类字符串
    @IBInspectable var titleStr:String = "项目分类" {
        didSet {
            titleLabel.text = titleStr
        }
    }
    // 百分比数字
    @IBInspectable var percentNum:Float = 0 {
        didSet {
            percentLabel.text = String(format: "%.2f", percentNum*100) + "%"
            processView.progress = percentNum
        }
    }
    
    func initial() {
        titleStr = "项目"
        percentNum = 0.5
        setBackgrond(color: UIColor(red: 248/255, green: 247/255, blue: 247/255, alpha: 0.5))
    }
    
    func setData(title:String, percent:Float) {
        titleStr = title
        percentNum = percent
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
