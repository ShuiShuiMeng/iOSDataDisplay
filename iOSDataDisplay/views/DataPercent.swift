//
//  DataPercent.swift
//  DataDisplay
//
//  Created by Flora on 2020/3/26.
//  Copyright © 2020年 yinmeng. All rights reserved.
//

import UIKit

class DataPercent: UIView {

    var contentView: UIView!
    
    @IBOutlet var title: UILabel!
    @IBOutlet var data: UILabel!
    @IBOutlet var imageBG: UIImageView!
    @IBOutlet var icon: UIImageView!
    
    @IBInspectable var titleStr: String = "标题" {
        didSet {
            title.text = titleStr
        }
    }
    
    @IBInspectable var dataFloat: Float = 0 {
        didSet {
            data.text = (dataFloat*100).cleanZero + "%"
        }
    }
    
    func initData() {
        title.text = titleStr
        data.text = String(dataFloat*100) + "%"
    }
    
    func setImage(img: UIImage) {
        imageBG.image = img
    }
    
    func setColorImage(color: UIColor) {
        imageBG.setBackgroundColor(color: color)
    }
    
    func setIcon(img: UIImage) {
        icon.image = img
    }
    
    func setTitle(t: String) {
        titleStr = t
    }
    
    func setData(d: Float) {
        dataFloat = d
    }
    
    //初始化时将xib中的view添加进来
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView = loadViewFromNib()
        addSubview(contentView)
        initData()
    }
    
    //初始化时将xib中的view添加进来
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        contentView = loadViewFromNib()
        addSubview(contentView)
        initData()
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
