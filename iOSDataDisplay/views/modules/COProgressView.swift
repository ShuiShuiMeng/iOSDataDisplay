//
//  COProgressView.swift
//  iOSDataDisplay
//
//  Created by Flora on 2020/4/20.
//  Copyright © 2020年 yinmeng. All rights reserved.
//

import UIKit

class COProgressView: OProgressView {
    
    var label1: UILabel!
    var label2: UILabel!
    var label4: UILabel!
    var label5: UILabel!
    
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
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
    }
    
    func initial() {
        label1 = UILabel(frame: CGRect(x: bounds.midX-20, y: 45, width: 40, height: 15))
        label1.textColor = .white
        label1.textAlignment = .center
        label1.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        label1.text = "已执行"
        self.addSubview(label1)
        
        // 百分比
        label2 = UILabel(frame: CGRect(x: bounds.midX-70, y: 65, width: 140, height: 60))
        label2.textColor = .white
        label2.textAlignment = .center
        let progressStr = Float(progress*100).cleanZero
        let attrText = NSMutableAttributedString(string: progressStr+"%")
        attrText.addAttribute(.font, value: UIFont(descriptor: UIFontDescriptor(name: "DIN Alternate Bold", size: 55), size: 55), range: NSRange(location: 0, length: progressStr.count))
        attrText.addAttribute(.font, value: UIFont(descriptor: UIFontDescriptor(name: "DIN Alternate Bold", size: 20), size: 20), range: NSRange(location: progressStr.count, length: 1))
        label2.attributedText = attrText
        self.addSubview(label2)
        
        label4 = UILabel(frame: CGRect(x: bounds.midX-45, y: 125, width: 90, height: 20))
        label4.textColor = Colors.ligthgray
        label4.textAlignment = .center
        label4.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        label4.text = "计划额度(万)"
        self.addSubview(label4)
        
        label5 = UILabel(frame: CGRect(x:bounds.midX-40, y: 145, width: 80, height: 20))
        label5.textColor = Colors.lightblue
        label5.textAlignment = .center
        label5.font = UIFont(descriptor: UIFontDescriptor(name: "DIN Alternate Bold", size: 15), size: 15)
        label5.text = "10000"
        self.addSubview(label5)
    }
    
    override func setProgress(_ pro: CGFloat, animated anim: Bool) {
        self.setProgress(pro, animated: anim, withDuration: 0.55)
    }
    
    override func setProgress(_ pro: CGFloat, animated anim: Bool, withDuration duration: Double) {
        super.setProgress(pro, animated: anim, withDuration: duration)
        let progressStr = Float(pro*100).cleanZero
        let attrText = NSMutableAttributedString(string: progressStr+"%")
        attrText.addAttribute(.font, value: UIFont(descriptor: UIFontDescriptor(name: "DIN Alternate Bold", size: 40), size: 40), range: NSRange(location: 0, length: progressStr.count))
        attrText.addAttribute(.font, value: UIFont(descriptor: UIFontDescriptor(name: "DIN Alternate Bold", size: 20), size: 20), range: NSRange(location: progressStr.count, length: 1))
        label2.attributedText = attrText
    }
    
    func setData(plan: Float, fund: Float, animated anim: Bool) {
        setData(plan: plan, fund: fund, animated: anim, withDuration: 0.55)
    }
    
    func setData(plan: Float, fund: Float, animated anim: Bool, withDuration duration: Double) {
        setProgress(CGFloat(fund/plan), animated: anim, withDuration: duration)
        if fund >= 100000 {
            label4.text = "计划额度(亿)"
            label5.text = (plan/10000).cleanZero
        }
        else {
            label4.text = "计划额度(万)"
            label5.text = plan.cleanZero
        }
    }
}
