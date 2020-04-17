//
//  DepNumber.swift
//  iOSDataDisplay
//
//  Created by Flora on 2020/4/3.
//  Copyright © 2020年 yinmeng. All rights reserved.
//

import UIKit

class DepNumber: UIView {

    var contentView: UIView!
    
    @IBOutlet var view1: UIView!
    @IBOutlet var view2: UIView!
    @IBOutlet var view3: UIView!
    
    @IBOutlet var lable1: UILabel!
    @IBOutlet var lable2: UILabel!
    @IBOutlet var lable3: UILabel!
    
    func setColors(color: UIColor) {
        view1.backgroundColor = color
        view2.backgroundColor = color
        view3.backgroundColor = color
    }
    
    func setNumbers(num1: Float, num2: Int, num3: Float) {
        lable1.text = num1.cleanZero
        lable2.text = String(num2)
        lable3.text = num3.cleanZero
    }
    
    //初始化时将xib中的view添加进来
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView = loadViewFromNib()
        addSubview(contentView)
    }
    
    //初始化时将xib中的view添加进来
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        contentView = loadViewFromNib()
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
