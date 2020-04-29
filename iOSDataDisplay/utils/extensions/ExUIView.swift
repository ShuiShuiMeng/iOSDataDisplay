//
//  ExUIView.swift
//  iOSDataDisplay
//
//  Created by Flora on 2020/4/16.
//  Copyright © 2020年 yinmeng. All rights reserved.
//

import Foundation
import UIKit

extension UIView{
    func createBubbleView(radius:CGFloat,backGroundColor:UIColor =     UIColor.white,isShowRect:Bool = true){
        let pai: CGFloat = CGFloat(Double.pi)
        let width: CGFloat = self.frame.width
        let linePath = UIBezierPath(arcCenter: CGPoint(x: radius, y: 10+radius), radius: radius, startAngle: pai*1.5, endAngle: pai, clockwise: false)
        linePath.addArc(withCenter: CGPoint(x: radius, y: self.frame.height-radius), radius: radius, startAngle: pai, endAngle: pai*0.5, clockwise: false)
        linePath.addArc(withCenter: CGPoint(x: self.frame.width - radius, y: self.frame.height-radius), radius: radius, startAngle: pai*0.5, endAngle: 0, clockwise: false)
        linePath.addArc(withCenter: CGPoint(x: self.frame.width - radius, y: 10+radius), radius: radius, startAngle: 0, endAngle: pai*1.5, clockwise: false)
        if isShowRect{
            let right:CGFloat = radius > 10 ? radius+2 : 12
            linePath.addLine(to: CGPoint(x: width-right, y: 10))
            linePath.addLine(to: CGPoint(x: width-right-5, y: 0))
            linePath.addLine(to: CGPoint(x: width-right-10, y: 10))
        }
        linePath.close()
        //设施路径画布
        let lineShape = CAShapeLayer()
        lineShape.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height)
        //获取贝塞尔曲线的路径
        lineShape.path = linePath.cgPath
        //填充色
        lineShape.fillColor = backGroundColor.cgColor
        //把绘制的图放到layer上
        self.layer.addSublayer(lineShape)
    }
}
