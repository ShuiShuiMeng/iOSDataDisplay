//
//  ExImageView.swift
//  iOSDataDisplay
//
//  Created by Flora on 2020/4/4.
//  Copyright © 2020年 yinmeng. All rights reserved.
//

import Foundation
import UIKit

extension UIImageView {
    func setBackgroundColor(color: UIColor) {
        UIGraphicsBeginImageContext(CGSize(width: 1, height: 1))
        UIGraphicsGetCurrentContext()!.setFillColor(color.cgColor)
        UIGraphicsGetCurrentContext()!.fill(CGRect(x: 0, y: 0, width: 1, height: 1))
        let colorImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        self.image = colorImage
    }
}
