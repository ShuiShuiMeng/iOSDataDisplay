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
        dnyss.setTitle(t: "当年预算数")
        dnyss.setData(d: 951109)
        zzjhzs.setTitle(t: "资助计划总数")
        zzjhzs.setData(d: 961026)
        zxed.setTitle(t: "执行额度")
        zxed.setData(d: 777777)
        zxl.setTitle(t: "执行率")
        zxl.setData(d: 0.8093)
    }
    
    func setBackgrond(color: UIColor) {
        contentView.backgroundColor = color
    }
    
    func initBackgrounds() {
        dnyss.setImage(img: UIImage(named: "bg7.jpg")!)
        zzjhzs.setImage(img: UIImage(named: "bg7.jpg")!)
        zxed.setImage(img: UIImage(named: "bg7.jpg")!)
        zxl.setImage(img: UIImage(named: "bg7.jpg")!)
    }
    
    func initIcons() {
        dnyss.setIcon(img: Icons.ysIcon.iconFontImage(fontSize: 25, color: .white))
        zzjhzs.setIcon(img: Icons.jhIcon.iconFontImage(fontSize: 25, color: .white))
        zxed.setIcon(img: Icons.zxIcon.iconFontImage(fontSize: 25, color: .white))
        zxl.setIcon(img: Icons.blIcon.iconFontImage(fontSize: 25, color: .white))
    }
    
    func initial() {
        initNumbers()
        initBackgrounds()
        initIcons()
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
