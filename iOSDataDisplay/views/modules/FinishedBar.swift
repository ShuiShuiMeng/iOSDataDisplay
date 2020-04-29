//
//  FinishedBar.swift
//  One progress bar with two labels
//  label1: title  lable2: percent
//
//  Created by Flora on 2020/3/23.
//  Copyright © 2020年 yinmeng. All rights reserved.
//

import UIKit

class FinishedBar: UIView {
    
    var nameLabel: UILabel!
    var planLabel: UILabel!
    var rateLabel: UILabel!
    var exeLabel: UILabel!
    var exeRateLabel: UILabel!
    var lpView: LProgressView!
    
    var nameStr: String = "" {
        didSet {
            nameLabel.text = nameStr
        }
    }
    
    var planNum: Float = 0 {
        didSet {
            planLabel.text = (planNum/10000).cleanZero4
        }
    }
    
    var exeNum: Float = 0 {
        didSet {
            exeLabel.text = (exeNum/10000).cleanZero4
        }
    }
    
    var exeRate: Float = 0 {
        didSet {
            lpView.setProgress(CGFloat(exeRate), animated: true)
            exeRateLabel.text = (exeRate*100).cleanZero + "%"
        }
    }
    
    var rate: Float = 0 {
        didSet {
            rateLabel.text = (rate*100).cleanZero + "%"
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initial()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initial()
    }
    
    // width * 80
    func initial() {
        backgroundColor = .white
        drawUp()
        drawLeft()
        drawRight()
    }
    
    func drawUp() {
        // xx项目
        nameLabel = UILabel(frame: CGRect(x: (mainSize.width-340)/2+5, y: 7.5, width: 155, height: 20))
        nameLabel.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        nameLabel.textAlignment = .left
        addSubview(nameLabel)
        addSubview(drawLineView(x: (mainSize.width-340)/2+5, y: 34.5, width: frame.width-mainSize.width+330, height: 0.5, color: Colors.minelinegray))
        
        // 计划额度(万)
        let jhed = UILabel(frame: CGRect(x: nameLabel.frame.maxX+20, y: 5, width: 70, height: 12))
        jhed.font = UIFont.systemFont(ofSize: 11, weight: .regular)
        jhed.textAlignment = .left
        jhed.textColor = Colors.minetextgray
        jhed.text = "计划额度(万)"
        addSubview(jhed)
        
        // 计划额度数字
        planLabel = UILabel(frame: CGRect(x: jhed.frame.maxX, y: 5, width: bounds.midX+160-jhed.frame.maxX, height: 12))
        planLabel.font = UIFont(descriptor: UIFontDescriptor(name: "DIN Alternate Bold", size: 12), size: 12)
        planLabel.textColor = Colors.indexlineblue
        planLabel.textAlignment = .right
        addSubview(planLabel)
        
        // 计划额度占比
        let jhedzb = UILabel(frame: CGRect(x: nameLabel.frame.maxX+20, y: 18, width: 70, height: 12))
        jhedzb.font = UIFont.systemFont(ofSize: 11, weight: .regular)
        jhedzb.textAlignment = .left
        jhedzb.textColor = Colors.minetextgray
        jhedzb.text = "计划额度占比"
        addSubview(jhedzb)
        
        // 计划额度百分比
        rateLabel = UILabel(frame: CGRect(x: jhed.frame.maxX, y: 18, width: bounds.midX+160-jhed.frame.maxX, height: 12))
        rateLabel.font = UIFont(descriptor: UIFontDescriptor(name: "DIN Alternate Bold", size: 12), size: 12)
        rateLabel.textColor = Colors.indexlineblue
        rateLabel.textAlignment = .right
        addSubview(rateLabel)
    }
    
    func drawLeft() {
        // 数字
        exeLabel = UILabel(frame: CGRect(x: (mainSize.width-340)/2+5, y:42.5, width: 120, height: 20))
        exeLabel.font = UIFont(descriptor: UIFontDescriptor(name: "DIN Alternate Bold", size: 16), size: 16)
        exeLabel.textAlignment = .left
        exeLabel.textColor = Colors.indexlineblue
        addSubview(exeLabel)
        addSubview(drawLineView(x: exeLabel.frame.maxX, y: 45, width: 0.5, height: 35, color: Colors.minelinegray))
        
        // 执行资金(万)
        let exeIntro = UILabel(frame: CGRect(x: (mainSize.width-340)/2+5, y: 62.5, width: 100, height: 20))
        exeIntro.font = UIFont.systemFont(ofSize: 11, weight: .regular)
        exeIntro.textAlignment = .left
        exeIntro.textColor = Colors.minetextgray
        exeIntro.text = "执行资金(万)"
        addSubview(exeIntro)
    }
    
    func drawRight() {
        // 进度条
        let beginX = nameLabel.frame.maxX+20
        let endX = mainSize.width*0.5+165
        lpView = LProgressView(frame: CGRect(x: beginX, y: 48, width: endX-beginX, height: 10), trackColor: Colors.indextrackgray, progressColor: Colors.indexlineblue)
        addSubview(lpView)
        
        // 已执行
        let rateIntro = UILabel(frame: CGRect(x: beginX, y: 62.5, width: 100, height: 20))
        rateIntro.font = UIFont.systemFont(ofSize: 11, weight: .regular)
        rateIntro.textAlignment = .left
        rateIntro.textColor = Colors.minetextgray
        rateIntro.text = "已执行"
        addSubview(rateIntro)
        
        // 执行率
        exeRateLabel = UILabel(frame: CGRect(x: rateIntro.frame.maxX, y: 62.5, width: endX-rateIntro.frame.maxX, height: 20))
        exeRateLabel.font = UIFont(descriptor: UIFontDescriptor(name: "DIN Alternate Bold", size: 14), size: 14)
        exeRateLabel.textAlignment = .right
        exeRateLabel.textColor = Colors.indexlineblue
        addSubview(exeRateLabel)
    }
    
    func setData(name: String, exeNum exe: Float, plan: Float, rate r: Float) {
        nameStr = name
        exeNum = exe
        exeRate = exe/plan
        planNum = plan
        rate = r
    }
}
