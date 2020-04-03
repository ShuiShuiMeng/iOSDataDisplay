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
    
    func setBackgrond(color: UIColor) {
        contentView.backgroundColor = color
    }
    
    func initial() {
        setBackgrond(color: UIColor(red: 248/255, green: 247/255, blue: 247/255, alpha: 0.5))
    }
    
    @objc func tapped(sender: UIButton) {
        print(sender.titleLabel?.text ?? "top")
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