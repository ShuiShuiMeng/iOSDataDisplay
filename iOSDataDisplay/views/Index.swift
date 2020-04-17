//
//  Index.swift
//  iOSDataDisplay
//
//  Created by Flora on 2020/3/27.
//  Copyright © 2020年 yinmeng. All rights reserved.
//

import UIKit

class Index: UIView {
    
    var contentView: UIView!
    @IBOutlet var numbers: DataNumbers!
    
    func setBackgrond(color: UIColor) {
        contentView.backgroundColor = color
        numbers.setBackgrond(color: color)
    }
    
    func initial() {
        setBackgrond(color: Colors.background)
    }
    
    func setNumbers(budget: Float, total: Float, exeQuota: Float, exeRate: Float) {
        numbers.setNumbers(budget: budget, total: total, exeQuota: exeQuota, exeRate: exeRate)
    }
    
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
