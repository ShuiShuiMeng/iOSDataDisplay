//
//  CHOProgressView1.swift
//  iOSDataDisplay
//
//  Created by Flora on 2020/4/24.
//  Copyright © 2020年 yinmeng. All rights reserved.
//

import Foundation
import UIKit

class CHOProgressView: HOProgressView {
    
    var content: UIScrollView!
    var contentIndex : Int = 0
    var view1: UIView!
    var view2: UIView!
    
    var label1: UILabel!
    var label2: UILabel!
    // var label3: UILabel!
    var label4: UILabel!
    var label5: UILabel!
    
    var label11: UILabel!
    var label22: UILabel!
    // var label33: UILabel!
    var label44: UILabel!
    var label55: UILabel!
    
    var rate: Float = 0
    var planNum: Float = 100000
    var funddingNum: Float = 100000
    var budgetNum: Float = 100000
    
    var botRollView: ScrollBottomView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initial()
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
        // backgroundColor = .black
    }
    
    func initial() {
        // 240x160 width 16
        content = UIScrollView(frame: CGRect(x:0, y:0, width: bounds.width, height: bounds.height-20))
        view1 = UIView(frame: CGRect(x:0, y:0, width: bounds.width, height: bounds.height-20))
        view1.backgroundColor = Colors.blueBackground
        view2 = UIView(frame: CGRect(x: bounds.width, y:0, width: bounds.width, height: bounds.height-20))
        content.contentSize = CGSize(width: bounds.width*2, height: 0)
        content.isPagingEnabled = true
        content.showsHorizontalScrollIndicator = false
        content.showsVerticalScrollIndicator = false
        content.scrollsToTop = false
        content.delegate = self
        content.addSubview(view1)
        content.addSubview(view2)
        self.addSubview(content)
        
        label1 = UILabel(frame: CGRect(x: bounds.midX-30, y: 40, width: 60, height: 15))
        label1.textColor = .white
        label1.textAlignment = .center
        label1.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        label1.text = "执行额度"
        view1.addSubview(label1)
        
        // 中间数字
        label2 = UILabel(frame: CGRect(x: bounds.midX-95, y: 55, width: 200, height: 50))
        label2.textColor = .white
        label2.textAlignment = .center
        let funddingStr = "7000"
        let attrText = NSMutableAttributedString(string: funddingStr+"万")
        attrText.addAttribute(.font, value: UIFont(descriptor: UIFontDescriptor(name: "DIN Alternate Bold", size: 40), size: 40), range: NSRange(location: 0, length: funddingStr.count))
        attrText.addAttribute(.font, value: UIFont.systemFont(ofSize: 16, weight: .regular), range: NSRange(location: funddingStr.count, length: 1))
        label2.attributedText = attrText
        view1.addSubview(label2)
        
        /*
         label3 = UILabel(frame: CGRect(x: 115, y: 95, width: 25, height: 25))
         // label3.adjustsFontSizeToFitWidth = true
         label3.textColor = .white
         label3.textAlignment = .center
         label3.font = UIFont(descriptor: UIFontDescriptor(name: "DIN Alternate Bold", size: 20), size: 20)
         label3.text = "%"
         self.addSubview(label3)*/
        
        label4 = UILabel(frame: CGRect(x: bounds.midX-50, y: 105, width: 100, height: 20))
        label4.textColor = Colors.ligthgray
        label4.textAlignment = .center
        label4.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        label4.text = "当年计划额度(万)"
        view1.addSubview(label4)
        
        label5 = UILabel(frame: CGRect(x:bounds.midX-50, y: 125, width: 100, height: 20))
        label5.textColor = Colors.lightblue
        label5.textAlignment = .center
        label5.font = UIFont(descriptor: UIFontDescriptor(name: "DIN Alternate Bold", size: 15), size: 15)
        label5.text = "10000"
        view1.addSubview(label5)
        
        
        // print((frame.height/2-lineWidth)) 240x160 width 16
        label11 = UILabel(frame: CGRect(x: bounds.midX-30, y: 40, width: 60, height: 15))
        label11.textColor = .white
        label11.textAlignment = .center
        label11.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        label11.text = "执行率"
        view2.addSubview(label11)
        
        // 中间数字
        label22 = UILabel(frame: CGRect(x: bounds.midX-95, y: 55, width: 200, height: 50))
        label22.textColor = .white
        label22.textAlignment = .center
        let progressStr = Float(progress*100).cleanZero
        let attrText1 = NSMutableAttributedString(string: progressStr+"%")
        attrText1.addAttribute(.font, value: UIFont(descriptor: UIFontDescriptor(name: "DIN Alternate Bold", size: 40), size: 40), range: NSRange(location: 0, length: progressStr.count))
        attrText1.addAttribute(.font, value: UIFont(descriptor: UIFontDescriptor(name: "DIN Alternate Bold", size: 20), size: 20), range: NSRange(location: progressStr.count, length: 1))
        label22.attributedText = attrText1
        view2.addSubview(label22)
        
        /*
         label33 = UILabel(frame: CGRect(x: 115, y: 95, width: 25, height: 25))
         // label33.adjustsFontSizeToFitWidth = true
         label33.textColor = .white
         label33.textAlignment = .center
         label33.font = UIFont(descriptor: UIFontDescriptor(name: "DIN Alternate Bold", size: 20), size: 20)
         label33.text = "%"
         self.addSubview(label33)*/
        
        label44 = UILabel(frame: CGRect(x: bounds.midX-50, y: 105, width: 100, height: 20))
        label44.textColor = Colors.ligthgray
        label44.textAlignment = .center
        label44.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        label44.text = "当年预算总数(万)"
        view2.addSubview(label44)
        
        label55 = UILabel(frame: CGRect(x:bounds.midX-50, y: 125, width: 100, height: 20))
        label55.textColor = Colors.lightblue
        label55.textAlignment = .center
        label55.font = UIFont(descriptor: UIFontDescriptor(name: "DIN Alternate Bold", size: 15), size: 15)
        label55.text = "10000"
        view2.addSubview(label55)
        
        botRollView = ScrollBottomView(frame: CGRect(x: bounds.midX-15, y: bounds.height-8, width: 30, height: 8))
        self.addSubview(botRollView)
    }
    
    override func setProgress(_ pro: CGFloat, animated anim: Bool) {
        self.setProgress(pro, animated: anim, withDuration: 0.55)
    }
    
    override func setProgress(_ pro: CGFloat, animated anim: Bool, withDuration duration: Double) {
        super.setProgress(pro, animated: anim, withDuration: duration)
        // 更新view1
        let funddingStr = (funddingNum/10000).cleanZero
        let attrText = NSMutableAttributedString(string: funddingStr+"万")
        attrText.addAttribute(.font, value: UIFont(descriptor: UIFontDescriptor(name: "DIN Alternate Bold", size: 40), size: 40), range: NSRange(location: 0, length: funddingStr.count))
        attrText.addAttribute(.font, value: UIFont.systemFont(ofSize: 16, weight: .regular), range: NSRange(location: funddingStr.count, length: 1))
        label2.attributedText = attrText
        // 更新view2
        let progressStr = Float(progress*100).cleanZero
        let attrText1 = NSMutableAttributedString(string: progressStr+"%")
        attrText1.addAttribute(.font, value: UIFont(descriptor: UIFontDescriptor(name: "DIN Alternate Bold", size: 40), size: 40), range: NSRange(location: 0, length: progressStr.count))
        attrText1.addAttribute(.font, value: UIFont(descriptor: UIFontDescriptor(name: "DIN Alternate Bold", size: 20), size: 20), range: NSRange(location: progressStr.count, length: 1))
        label22.attributedText = attrText1

    }
    
    func setData(plan: Float, fund: Float, budget: Float, rate: Float, animated anim: Bool) {
        setData(plan: plan, fund: fund, budget: budget, rate: rate, animated: anim, withDuration: 0.55)
    }
    
    func setData(plan: Float, fund: Float, budget: Float, rate r: Float, animated anim: Bool, withDuration duration: Double) {
        planNum = plan
        funddingNum = fund
        budgetNum = budget
        rate = r
        
        let funddingStr = (fund/10000).cleanZero
        let attrText = NSMutableAttributedString(string: funddingStr+"万")
        attrText.addAttribute(.font, value: UIFont(descriptor: UIFontDescriptor(name: "DIN Alternate Bold", size: 40), size: 40), range: NSRange(location: 0, length: funddingStr.count))
        attrText.addAttribute(.font, value: UIFont.systemFont(ofSize: 16, weight: .regular), range: NSRange(location: funddingStr.count, length: 1))
        label2.attributedText = attrText
        setProgress(CGFloat(r), animated: anim, withDuration: duration)
        label5.text = (planNum/10000).cleanZero4
        label55.text = (budgetNum/10000).cleanZero4
    }
}

extension CHOProgressView: UIScrollViewDelegate {
    //1.当scrollView滚动的时候，这个方法会持续触发
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if (scrollView.contentOffset.x < 120) {
            botRollView.setIndex(0)
        }
        else {
            botRollView.setIndex(1)
        }
    }
}
