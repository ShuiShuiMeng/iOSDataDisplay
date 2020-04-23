//
//  HOProgressView.swift
//  iOSDataDisplay
//
//  Created by Flora on 2020/4/23.
//  Copyright © 2020年 yinmeng. All rights reserved.
//

import Foundation
import UIKit

class HOProgressView: UIView {
    // 进度槽宽度
    var lineWidth: CGFloat = 15
    // 进度槽颜色
    var trackColor = Colors.trackblue
    // 进度条颜色
    var progressColor = Colors.lightblue
    // 头点颜色
    var idotColor = Colors.idotblue
    
    // 进度槽
    let trackLayer = CAShapeLayer()
    // 进度条
    let progressLayer = CAShapeLayer()
    // 进度条路径
    let path = UIBezierPath()
    // 进度条头部圆点
    var sdot: UIView!
    // 进度条尾部圆点（尾部指出发点）
    var edot: UIView!
    // 进度槽头部圆点
    var tsdot: UIView!
    // 进度槽尾部圆点（尾部指出发点）
    var tedot: UIView!
    // 头部指示点
    var idot: UIView!
    // 进度条圆环中点
    var progressCenter: CGPoint {
        get {
            return CGPoint(x: bounds.midX, y: bounds.width/2)
        }
    }
    // 进度条圆环半径
    var radius: CGFloat {
        get {
            return bounds.size.width/2 - lineWidth
        }
    }
    
    // 当前进度
    @IBInspectable var progress: CGFloat = 0 {
        didSet {
            if progress > 1 {
                progress = 1
            }
            else if progress < 0 {
                progress = 0
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    convenience init(frame: CGRect, lineWidth: CGFloat, trackColor: UIColor, progressColor: UIColor, idotColor: UIColor) {
        self.init(frame: frame)
        self.lineWidth = lineWidth
        self.trackColor = trackColor
        self.progressColor = progressColor
        self.idotColor = idotColor
    }
    
    override func draw(_ rect: CGRect) {
        // 获取整个进度条圆圈路径
        path.addArc(withCenter: progressCenter, radius: radius, startAngle: angleToRadian(-180), endAngle: angleToRadian(0), clockwise: true)
        
        // 绘制进度槽端点
        tedot = UIView(frame: CGRect(x: 0, y: 0, width: lineWidth, height: lineWidth))
        let tedotPath = UIBezierPath(ovalIn: CGRect(x: 0, y: 0, width: lineWidth, height: lineWidth)).cgPath
        let tearc = CAShapeLayer()
        tearc.lineWidth = 0
        tearc.path = tedotPath
        tearc.strokeStart = 0
        tearc.strokeEnd = 1
        tearc.strokeColor = trackColor.cgColor
        tearc.fillColor = trackColor.cgColor
        tedot.layer.addSublayer(tearc)
        tedot.layer.position = CGPoint(x: lineWidth, y: bounds.width/2)
        self.addSubview(tedot)
        
        // 绘制进度槽端点
        tsdot = UIView(frame: CGRect(x: 0, y: 0, width: lineWidth, height: lineWidth))
        let tsdotPath = UIBezierPath(ovalIn: CGRect(x: 0, y: 0, width: lineWidth, height: lineWidth)).cgPath
        let tsarc = CAShapeLayer()
        tsarc.lineWidth = 0
        tsarc.path = tsdotPath
        tsarc.strokeStart = 0
        tsarc.strokeEnd = 1
        tsarc.strokeColor = trackColor.cgColor
        tsarc.fillColor = trackColor.cgColor
        tsdot.layer.addSublayer(tsarc)
        tsdot.layer.position = CGPoint(x: lineWidth+2*radius, y: bounds.width/2)
        self.addSubview(tsdot)
        
        // 绘制进度槽
        trackLayer.frame = bounds
        trackLayer.fillColor = UIColor.clear.cgColor
        trackLayer.strokeColor = trackColor.cgColor
        // 阴影
        trackLayer.lineWidth = lineWidth
        trackLayer.path = path.cgPath
        layer.addSublayer(trackLayer)
        
        // 绘制进度条尾部端点
        edot = UIView(frame: CGRect(x: 0, y: 0, width: lineWidth*0.7, height: lineWidth*0.7))
        let edotPath = UIBezierPath(ovalIn: CGRect(x: 0, y: 0, width: lineWidth*0.7, height: lineWidth*0.7)).cgPath
        let earc = CAShapeLayer()
        earc.lineWidth = 0
        earc.path = edotPath
        earc.strokeStart = 0
        earc.strokeEnd = 1
        earc.strokeColor = progressColor.cgColor
        earc.fillColor = progressColor.cgColor
        edot.layer.addSublayer(earc)
        edot.layer.position = CGPoint(x: lineWidth, y: bounds.width/2)
        self.addSubview(edot)
        
        // 绘制进度条头部原点
        sdot = UIView(frame: CGRect(x: 0, y: 0, width: lineWidth*0.7, height: lineWidth*0.7))
        let sdotPath = UIBezierPath(ovalIn: CGRect(x: 0, y: 0, width: lineWidth*0.7, height: lineWidth*0.7)).cgPath
        let sarc = CAShapeLayer()
        sarc.lineWidth = 0
        sarc.path = sdotPath
        sarc.strokeStart = 0
        sarc.strokeEnd = 1
        sarc.strokeColor = progressColor.cgColor
        sarc.fillColor = progressColor.cgColor
        sdot.layer.addSublayer(sarc)
        sdot.layer.position = calcCircleCoordinateWithCenter(progressCenter, radius: radius, angle: CGFloat(-progress)*180+180)
        self.addSubview(sdot)
        
        // 绘制进度条
        progressLayer.frame = bounds
        progressLayer.fillColor = UIColor.clear.cgColor
        progressLayer.strokeColor = progressColor.cgColor
        progressLayer.lineWidth = lineWidth*0.7
        progressLayer.path = path.cgPath
        progressLayer.strokeStart = 0
        progressLayer.strokeEnd = progress
        layer.addSublayer(progressLayer)
        
        // 绘制头部指示点
        idot = UIView(frame: CGRect(x: 0, y: 0, width: lineWidth*0.35, height: lineWidth*0.35))
        let idotPath = UIBezierPath(ovalIn: CGRect(x: 0, y: 0, width: lineWidth*0.35, height: lineWidth*0.35)).cgPath
        let iarc = CAShapeLayer()
        iarc.lineWidth = 0
        iarc.path = idotPath
        iarc.strokeStart = 0
        iarc.strokeEnd = 1
        iarc.strokeColor = idotColor.cgColor
        iarc.fillColor = idotColor.cgColor
        idot.layer.addSublayer(iarc)
        idot.layer.position = calcCircleCoordinateWithCenter(progressCenter, radius: radius, angle: CGFloat(-progress)*180+180)
        self.addSubview(idot)
        
    }
    
    // 设置进度，anim表示是否播放动画
    func setProgress(_ pro: CGFloat, animated anim: Bool) {
        setProgress(pro, animated: anim, withDuration: 0.55)
    }
    
    // duration 进度条动画播放时间，默认0.55s
    func setProgress(_ pro: CGFloat, animated anim: Bool, withDuration duration: Double) {
        progress = pro
        // 进度条动画
        CATransaction.begin()
        CATransaction.setDisableActions(!anim)
        CATransaction.setAnimationTimingFunction(CAMediaTimingFunction(name: .easeInEaseOut))
        CATransaction.setAnimationDuration(duration)
        progressLayer.strokeEnd = progress
        CATransaction.commit()
    }
    
    // 角度转弧度
    fileprivate func angleToRadian(_ angle: Double) -> CGFloat {
        return CGFloat(angle/Double(180.0) * .pi)
    }
    
    // 计算圆弧上点的坐标
    func calcCircleCoordinateWithCenter(_ center: CGPoint, radius: CGFloat, angle: CGFloat) -> CGPoint {
        let x2 = radius*CGFloat(cosf(Float(angle)*Float(Double.pi)/Float(180)))
        let y2 = radius*CGFloat(sinf(Float(angle)*Float(Double.pi)/Float(180)))
        return CGPoint(x: center.x+x2, y: center.y-y2)
    }
}
