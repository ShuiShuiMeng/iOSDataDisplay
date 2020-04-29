//
//  OProgressView.swift
//  iOSDataDisplay
//
//  Created by Flora on 2020/4/20.
//  Copyright © 2020年 yinmeng. All rights reserved.
//

import UIKit

class OProgressView: UIView {

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
    
    // 头部圆点
    var sdot: UIView!
    // 尾部圆点（尾部指出发点）
    var edot: UIView!
    // 头部指示点
    var idot: UIView!
    // 进度条圆环中点
    var progressCenter: CGPoint {
        get {
            return CGPoint(x: bounds.midX, y: bounds.midY)
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
                // progress = 1
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
        // 进度条路径
        let path = UIBezierPath()
        // 获取整个进度条圆圈路径
        path.addArc(withCenter: progressCenter, radius: radius, startAngle: angleToRadian(-90), endAngle: angleToRadian(270), clockwise: true)
        
        // 绘制进度槽
        trackLayer.frame = bounds
        trackLayer.fillColor = UIColor.clear.cgColor
        trackLayer.strokeColor = trackColor.cgColor
        // 阴影
        // trackLayer.shadowColor = trackColor.cgColor
        // trackLayer.shadowRadius = bounds.size.width/2 + 5
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
        edot.layer.position = CGPoint(x: bounds.midX, y: lineWidth)
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
        sdot.layer.position = calcCircleCoordinateWithCenter(progressCenter, radius: radius, angle: CGFloat(-progress)*360+90)
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
        idot = UIView(frame: CGRect(x: 0, y: 0, width: lineWidth*0.4, height: lineWidth*0.4))
        let idotPath = UIBezierPath(ovalIn: CGRect(x: 0, y: 0, width: lineWidth*0.4, height: lineWidth*0.4)).cgPath
        let iarc = CAShapeLayer()
        iarc.lineWidth = 0
        iarc.path = idotPath
        iarc.strokeStart = 0
        iarc.strokeEnd = 1
        iarc.strokeColor = idotColor.cgColor
        iarc.fillColor = idotColor.cgColor
        idot.layer.addSublayer(iarc)
        idot.layer.position = calcCircleCoordinateWithCenter(progressCenter, radius: radius, angle: CGFloat(-progress)*360+90)
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
