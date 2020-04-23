//
//  DepButton.swift
//  DataDisplay
//
//  Created by Flora on 2020/3/26.
//  Copyright © 2020年 yinmeng. All rights reserved.
//

import UIKit

class DepButton: UIButton {
    
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
        imageView?.frame = CGRect(x: frame.width*0.5 - imageView!.frame.width*0.5, y: imageView!.frame.height*0.15, width: imageView!.frame.width, height: imageView!.frame.height)
        titleLabel?.frame = CGRect(x: 0, y: imageView!.frame.size.height, width: frame.width, height: frame.height - imageView!.frame.height)
    }
    
}

// 可以在这里设置一些需要的属性
extension DepButton {
    fileprivate func setupUI() {
        titleLabel?.textAlignment = .center
        titleLabel?.font = UIFont.systemFont(ofSize: 13)
    }
}

