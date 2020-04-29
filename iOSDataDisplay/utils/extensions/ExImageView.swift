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
    
    
    /**
     
     * param: radius            圆角半径
     
     * 注意：只有当imageView.image不为nil时，调用此方法才有效果
     
     */
    func cornerRadius(radius:CGFloat){
        
        //开始图形上下文
        UIGraphicsBeginImageContextWithOptions(self.bounds.size, false, UIScreen.main.scale)
        
        //获取图形上下文
        let ctx = UIGraphicsGetCurrentContext()
        
        //根据一个rect创建一个椭圆
        ctx!.addEllipse(in: self.bounds)
        
        
        //裁剪
        ctx!.clip()
        
        //将原照片画到图形上下文
        self.image!.draw(in: self.bounds)
        
        //从上下文上获取剪裁后的照片
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        
        //关闭上下文
        UIGraphicsEndImageContext()
        
        self.image = newImage
    }
}
