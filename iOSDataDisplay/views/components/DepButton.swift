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
        // 60 x 60
        imageView?.frame = CGRect(x: 10, y: 0, width: 30, height: 30)
        titleLabel?.frame = CGRect(x: 0, y: 30, width: 50, height: 20)
    }
    
}

// 可以在这里设置一些需要的属性
extension DepButton {
    fileprivate func setupUI() {
        titleLabel?.textAlignment = .center
        titleLabel?.font = UIFont.systemFont(ofSize: 12)
    }
}

