//
//  ScrollBars.swift
//  View of sevral progress bars
//
//  Created by Flora on 2020/3/24.
//  Copyright © 2020年 yinmeng. All rights reserved.
//

import UIKit

@IBDesignable class ScrollBars: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    @IBOutlet var msxm: FinishedBar!
    @IBOutlet var zdxm: FinishedBar!
    @IBOutlet var zdaxm: FinishedBar!
    @IBOutlet var zdyj: FinishedBar!
    @IBOutlet var gjyj: FinishedBar!
    @IBOutlet var qnkx: FinishedBar!
    @IBOutlet var yxqn: FinishedBar!
    @IBOutlet var gjjc: FinishedBar!
    @IBOutlet var cxyj: FinishedBar!
    @IBOutlet var dqkx: FinishedBar!
    @IBOutlet var lhjj: FinishedBar!
    @IBOutlet var gjyq: FinishedBar!
    @IBOutlet var jckx: FinishedBar!
    @IBOutlet var zxxm: FinishedBar!
    @IBOutlet var sxty: FinishedBar!
    @IBOutlet var wgqn: FinishedBar!
    @IBOutlet var gjjl: FinishedBar!
    
    
    func initial() {
        // get Data -> then
        let TestData = [
            (msxm, "面上项目", 0.25),
            (zdxm, "重点项目", 0.75),
            (zdaxm, "重大项目", 0.6),
            (zdyj, "重大研究计划项目", 0.5),
            (gjyj, "国际(地区)合作研究项目", 0.8),
            (qnkx, "青年科学基金项目", 1.0),
            (yxqn, "优秀青年科学基金项目", 0.75),
            (gjjc, "国家杰出青年科学项目基金", 0.66),
            (cxyj, "创新研究群体项目", 0.1),
            (dqkx, "地区科学基金项目", 0.5),
            (lhjj, "联合基金项目(委内出资额)", 0.2),
            (gjyq, "国家重大科研仪器研制项目", 0.3),
            (jckx, "基础科学中心项目", 0.44),
            (zxxm, "专项项目", 0.55),
            (sxty, "数学田园基金项目", 0.66),
            (wgqn, "外国青年学者研究基金项目", 0.77),
            (gjjl, "国际(地区)合作交流项目", 0.88)
        ]
        for (bar, titleStr, percent) in TestData {
            bar?.setData(title: titleStr, percent: Float(percent))
        }
    }
    
    var contentView: UIView!
    //初始化时将xib中的view添加进来
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView = loadViewFromNib()
        addSubview(contentView)
        //初始化属性配置
        initial()
    }
    //初始化时将xib中的view添加进来
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        contentView = loadViewFromNib()
        addSubview(contentView)
        //初始化属性配置
        initial()
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
