//
//  Departments.swift
//  DataDisplay
//
//  Created by Flora on 2020/3/25.
//  Copyright © 2020年 yinmeng. All rights reserved.
//

import UIKit

@IBDesignable class Departments: UIView {
    
    let slDep = DepButton()
    let hxDep = DepButton()
    let smDep = DepButton()
    let dqDep = DepButton()
    let gcDep = DepButton()
    let xxDep = DepButton()
    let glDep = DepButton()
    let yxDep = DepButton()
    let hzDep = DepButton()
    let gdDep = DepButton()
    
    func initButtons(view: UIView) {
        let buttonList = [
            (slDep, "数理",  0,       0,      Icons.slIcon),
            (hxDep, "化学",  75.25,   0,      Icons.hxIcon),
            (smDep, "生命",  150.5,   0,      Icons.smIcon),
            (dqDep, "地球",  225.75,  0,      Icons.dqIcon),
            (gcDep, "工材",  301,     0,      Icons.gcIcon),
            (xxDep, "信息",  0,       75.5,   Icons.xxIcon),
            (glDep, "管理",  75.25,   75.5,   Icons.glIcon),
            (yxDep, "医学",  150.5,   75.5,   Icons.yxIcon),
            (hzDep, "合作局", 225.75,  75.5,   Icons.hzIcon),
            (gdDep, "更多",  301,     75.5,   Icons.gdIcon)
        ]
        
        for (button, btnStr, btnX, btnY, image) in buttonList {
            button.setTitle(btnStr, for: UIControl.State.normal)
            button.setTitleColor(UIColor.black, for: UIControl.State.normal)
            button.setImage(image.iconFontImage(fontSize: 30, color: .black), for: .normal)
            button.setImage(image.iconFontImage(fontSize: 30, color: .blue), for: .highlighted)
            button.frame = CGRect(x: btnX, y:btnY, width: 74, height: 74.5);
            button.addTarget(self, action: #selector(tapped), for: .touchUpInside)
            button.backgroundColor = UIColor(red: 248/255, green: 247/255, blue: 247/255, alpha: 0.5)
            view.addSubview(button)
        }
    }
    
    func setBackgrond(color: UIColor) {
        contentView.backgroundColor = color
    }
    
    @objc func tapped(sender: UIButton) {
        print(sender.titleLabel?.text ?? "tap")
    }
    
    func initial() {
        initButtons(view: contentView)
        setBackgrond(color: UIColor(red: 248/255, green: 247/255, blue: 247/255, alpha: 0.5))
    }
    
    var contentView: UIView!
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
