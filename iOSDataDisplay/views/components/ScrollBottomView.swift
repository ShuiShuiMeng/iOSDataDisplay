//
//  ScrollBottomView.swift
//  iOSDataDisplay
//
//  Created by Flora on 2020/4/25.
//  Copyright © 2020年 yinmeng. All rights reserved.
//

import Foundation
import UIKit

class ScrollBottomView: UIView {
    
    let scrollColor = UIColor(red: 166/255.0, green: 194/255.0, blue: 242/255.0, alpha: 1)
    
    let arc1 = CAShapeLayer()
    let earc1 = CAShapeLayer()
    let sarc1 = CAShapeLayer()
    
    let arc2 = CAShapeLayer()
    let earc2 = CAShapeLayer()
    let sarc2 = CAShapeLayer()
    
    let pathLayer1 = CAShapeLayer()
    let pathLayer2 = CAShapeLayer()
    
    var edot1: UIView!
    var sdot1: UIView!
    var edot2: UIView!
    var sdot2: UIView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initial()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initial()
    }
    
    func initial() {
        edot1 = UIView(frame: CGRect(x: 0, y: 0, width: bounds.height, height: bounds.height))
        sdot1 = UIView(frame: CGRect(x: 0, y: 0, width: bounds.height, height: bounds.height))
        edot2 = UIView(frame: CGRect(x: 0, y: 0, width: bounds.height, height: bounds.height))
        sdot2 = UIView(frame: CGRect(x: 0, y: 0, width: bounds.height, height: bounds.height))
        // backgroundColor = .black
        
    }
    
    override func draw(_ rect: CGRect) {
        // ---- index 0 ----
        let edot1Path = UIBezierPath(ovalIn: CGRect(x: 0, y: 0, width: bounds.height, height: bounds.height)).cgPath
        earc1.lineWidth = 0
        earc1.path = edot1Path
        earc1.strokeStart = 0
        earc1.strokeEnd = 1
        edot1.layer.addSublayer(earc1)
        edot1.layer.position = CGPoint(x: 0, y: bounds.height/2)
        self.addSubview(edot1)
        let sdot1Path = UIBezierPath(ovalIn: CGRect(x: 0, y: 0, width: bounds.height, height: bounds.height)).cgPath
        sarc1.lineWidth = 0
        sarc1.path = sdot1Path
        sarc1.strokeStart = 0
        sarc1.strokeEnd = 1
        sdot1.layer.addSublayer(sarc1)
        sdot1.layer.position = CGPoint(x: bounds.midX, y: bounds.height/2)
        self.addSubview(sdot1)
        let path1 = UIBezierPath()
        path1.move(to: CGPoint(x: 0, y: bounds.height/2))
        path1.addLine(to: CGPoint(x: bounds.midX, y: bounds.height/2))
        pathLayer1.lineWidth = frame.height
        pathLayer1.strokeStart = 0
        pathLayer1.strokeEnd = 1
        pathLayer1.path = path1.cgPath
        pathLayer1.fillColor = UIColor.clear.cgColor
        setColor1(color: scrollColor)
        layer.addSublayer(pathLayer1)
        
        // ---- Index 1 ----
        let edot2Path = UIBezierPath(ovalIn: CGRect(x: 0, y: 0, width: bounds.height, height: bounds.height)).cgPath
        earc2.lineWidth = 0
        earc2.path = edot2Path
        earc2.strokeStart = 0
        earc2.strokeEnd = 1
        edot2.layer.addSublayer(earc2)
        edot2.layer.position = CGPoint(x: bounds.width, y: bounds.height/2)
        // edot2.backgroundColor = .black
        self.addSubview(edot2)
        let sdot2Path = UIBezierPath(ovalIn: CGRect(x: 0, y: 0, width: bounds.height, height: bounds.height)).cgPath
        sarc2.lineWidth = 0
        sarc2.path = sdot2Path
        sarc2.strokeStart = 0
        sarc2.strokeEnd = 1
        sdot2.layer.addSublayer(sarc2)
        sdot2.layer.position = CGPoint(x: bounds.midX, y: bounds.height/2)
        sdot2.isHidden = true
        self.addSubview(sdot2)
        let path2 = UIBezierPath()
        path2.move(to: CGPoint(x: bounds.width, y: bounds.height/2))
        path2.addLine(to: CGPoint(x: bounds.midX, y: bounds.height/2))
        pathLayer2.lineWidth = frame.height
        pathLayer2.strokeStart = 0
        pathLayer2.strokeEnd = 0
        pathLayer2.path = path2.cgPath
        pathLayer2.fillColor = UIColor.clear.cgColor
        setColor2(color: Colors.trackblue)
        layer.addSublayer(pathLayer2)
    }
    
    func setIndex(_ index: Int) {
        if (index == 0) {
            CATransaction.begin()
            CATransaction.setDisableActions(false)
            CATransaction.setAnimationTimingFunction(CAMediaTimingFunction(name: .easeInEaseOut))
            CATransaction.setAnimationDuration(0.1)
            pathLayer1.strokeEnd = 1
            pathLayer2.strokeEnd = 0
            setColor1(color: scrollColor)
            setColor2(color: Colors.trackblue)
            CATransaction.commit()
            sdot1.isHidden = false
            sdot2.isHidden = true
        }
        else if (index == 1) {
            CATransaction.begin()
            CATransaction.setDisableActions(false)
            CATransaction.setAnimationTimingFunction(CAMediaTimingFunction(name: .easeInEaseOut))
            CATransaction.setAnimationDuration(0.1)
            pathLayer1.strokeEnd = 0
            pathLayer2.strokeEnd = 1
            setColor1(color: Colors.trackblue)
            setColor2(color: scrollColor)
            CATransaction.commit()
            sdot1.isHidden = true
            sdot2.isHidden = false
        }
    }
    
    func setColor1(color: UIColor) {
        sarc1.strokeColor = color.cgColor
        sarc1.fillColor = color.cgColor
        earc1.strokeColor = color.cgColor
        earc1.fillColor = color.cgColor
        pathLayer1.strokeColor = color.cgColor
    }
    
    func setColor2(color: UIColor) {
        sarc2.strokeColor = color.cgColor
        sarc2.fillColor = color.cgColor
        earc2.strokeColor = color.cgColor
        earc2.fillColor = color.cgColor
        pathLayer2.strokeColor = color.cgColor
    }
}
