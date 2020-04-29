//
//  ExButton.swift
//  iOSDataDisplay
//
//  Created by Flora on 2020/3/31.
//  Copyright © 2020年 yinmeng. All rights reserved.
//

import UIKit
import Foundation

extension UIButton {
    
    func setBackgroundColor(color: UIColor, forState: UIControl.State) {
        UIGraphicsBeginImageContext(CGSize(width: 1, height: 1))
        UIGraphicsGetCurrentContext()!.setFillColor(color.cgColor)
        UIGraphicsGetCurrentContext()!.fill(CGRect(x: 0, y: 0, width: 1, height: 1))
        let colorImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        self.setBackgroundImage(colorImage, for: forState)
    }
    
    func setTitleFontSize(size: CGFloat) {
        self.titleLabel?.font = UIFont.systemFont(ofSize: size)
    }
}
