//
//  DataNumbers.swift
//  DataDisplay
//
//  Created by Flora on 2020/3/26.
//  Copyright © 2020年 yinmeng. All rights reserved.
//

import UIKit

class DataNumbers: UIView {
    
    var contentView: UIView!
    
    @IBOutlet var dnyss: DataNumber!
    @IBOutlet var zzjhzs: DataNumber!
    @IBOutlet var zxed: DataNumber!
    @IBOutlet var zxl: DataPercent!
    
    func initNumbers() {
        dnyss.setData(d: 0)
        zzjhzs.setData(d: 0)
        zxed.setData(d: 0)
        zxl.setData(d: 0)
    }
    
    func setNumbers(budget:Float, total:Float, exeQuota:Float, exeRate:Float) {
        dnyss.setData(d: budget)
        zzjhzs.setData(d: total)
        zxed.setData(d: exeQuota)
        zxl.setData(d: exeRate)
    }
    
    func setBackgrond(color: UIColor) {
        contentView.backgroundColor = color
    }
    
    func initBackgrounds() {
        dnyss.setColorImage(color: Colors.blue)
        zzjhzs.setColorImage(color: Colors.blue)
        zxed.setColorImage(color: Colors.blue)
        zxl.setColorImage(color: Colors.blue)
    }
    
    func initTitles() {
        dnyss.setIcon(img: Icons.ysIcon.iconFontImage(fontSize: 25, color: .white))
        dnyss.setTitle(t: "当年预算数")
        zzjhzs.setIcon(img: Icons.jhIcon.iconFontImage(fontSize: 25, color: .white))
        zzjhzs.setTitle(t: "资助计划总数")
        zxed.setIcon(img: Icons.zxIcon.iconFontImage(fontSize: 25, color: .white))
        zxed.setTitle(t: "执行额度")
        zxl.setIcon(img: Icons.blIcon.iconFontImage(fontSize: 25, color: .white))
        zxl.setTitle(t: "执行率")
    }
    
    func initial() {
        initBackgrounds()
        initTitles()
        setBackgrond(color: UIColor(red: 248/255, green: 247/255, blue: 247/255, alpha: 0.5))
    }
    
    //初始化时将xib中的view添加进来
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView = loadViewFromNib()
        addSubview(contentView)
        initial()
    }
    
    //初始化时将xib中的view添加进来
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        contentView = loadViewFromNib()
        addSubview(contentView)
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
