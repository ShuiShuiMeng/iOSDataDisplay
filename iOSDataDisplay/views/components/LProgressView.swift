//
//  LProgressView.swift
//  iOSDataDisplay
//
//  Created by Flora on 2020/4/22.
//  Copyright © 2020年 yinmeng. All rights reserved.
//

import UIKit

class LProgressView: UIView {

    // 进度槽颜色
    var trackColor = Colors.trackgray
    // 进度条颜色
    var progressColor = Colors.lineblue
    
    // 进度槽
    let trackLayer = CAShapeLayer()
    // 进度条
    let progressLayer = CAShapeLayer()
    // 进度条路径
    let path = UIBezierPath()
    // 头部圆点
    var sdot: UIView!
    // 尾部圆点
    var edot: UIView!
    
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
        layer.cornerRadius = frame.height/2
        layer.masksToBounds = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    convenience init(frame: CGRect, trackColor: UIColor, progressColor: UIColor) {
        self.init(frame: frame)
        self.trackColor = trackColor
        self.progressColor = progressColor
    }
    
    override func draw(_ rect: CGRect) {
        // 起点 -> 终点
        path.move(to: CGPoint(x: 0, y: frame.height/2))
        path.addLine(to: CGPoint(x: frame.width, y: frame.height/2))
        // 绘制进度槽
        trackLayer.lineWidth = frame.height
        trackLayer.strokeColor = trackColor.cgColor
        trackLayer.strokeStart = 0
        trackLayer.strokeEnd = 1
        trackLayer.path = path.cgPath
        trackLayer.fillColor = UIColor.clear.cgColor
        layer.addSublayer(trackLayer)
        
        
        // let progressView = UIView(frame: CGRect(x: 0, y: 0, width: frame.width*progress, height: frame.height))
        // progressView.backgroundColor = .clear
        // 绘制进度条
        progressLayer.lineWidth = frame.height*0.8
        progressLayer.strokeColor = progressColor.cgColor
        progressLayer.strokeStart = 0
        progressLayer.strokeEnd = progress
        progressLayer.path = path.cgPath
        progressLayer.fillColor = UIColor.clear.cgColor
        layer.addSublayer(progressLayer)
        // progressView.layer.cornerRadius = frame.height*0.4
        // progressView.layer.masksToBounds = true
        // self.addSubview(progressView)
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
}
