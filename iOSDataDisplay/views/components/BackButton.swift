//
//  BackButton.swift
//  iOSDataDisplay
//
//  Created by Flora on 2020/4/12.
//  Copyright © 2020年 yinmeng. All rights reserved.
//

import UIKit

class BackButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if imageView == nil {
            return
        }
        // 通过高度控制图标大小
        imageView?.frame = CGRect(x: 0, y: (frame.height-imageView!.frame.height)*0.5, width: imageView!.frame.width, height: imageView!.frame.height)
        // 其余部分给text
        titleLabel?.frame = CGRect(x: imageView!.frame.width*0.75, y: (frame.height-imageView!.frame.height)*0.5, width: frame.width-(frame.height+imageView!.frame.height)*0.5, height: imageView!.frame.height)
    }

}

// 可以在这里设置一些需要的属性
extension BackButton{
    fileprivate func setupUI() {
        titleLabel?.font = UIFont.systemFont(ofSize: 18)
    }
}
