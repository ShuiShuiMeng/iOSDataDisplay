//
//  CHOProgressView.swift
//  iOSDataDisplay
//
//  Created by Flora on 2020/4/24.
//  Copyright © 2020年 yinmeng. All rights reserved.
//

import Foundation
import UIKit

class CHOProgressView2: HOProgressView {
    var label1: UILabel!
    var label2: UILabel!
    // var label3: UILabel!
    var label4: UILabel!
    var label5: UILabel!
    
    var itemsNum: Int = 1000
    
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
    
    func initial() {
        // print((frame.height/2-lineWidth)) 240x160 width 16
        label1 = UILabel(frame: CGRect(x: bounds.midX-30, y: 40, width: 60, height: 15))
        label1.textColor = .white
        label1.textAlignment = .center
        label1.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        label1.text = "执行率"
        self.addSubview(label1)
        
        // 中间数字
        label2 = UILabel(frame: CGRect(x: bounds.midX-95, y: 55, width: 200, height: 50))
        // print(progress)
        label2.textColor = .white
        label2.textAlignment = .center
        let progressStr = Float(progress*100).cleanZero
        let attrText = NSMutableAttributedString(string: progressStr+"%")
        attrText.addAttribute(.font, value: UIFont(descriptor: UIFontDescriptor(name: "DIN Alternate Bold", size: 40), size: 40), range: NSRange(location: 0, length: progressStr.count))
        attrText.addAttribute(.font, value: UIFont(descriptor: UIFontDescriptor(name: "DIN Alternate Bold", size: 20), size: 20), range: NSRange(location: progressStr.count, length: 1))
        label2.attributedText = attrText
        self.addSubview(label2)
        
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
        label4.text = "资助计划总数(项)"
        self.addSubview(label4)
        
        label5 = UILabel(frame: CGRect(x:bounds.midX-50, y: 125, width: 100, height: 20))
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
    
    func setData(percent: Float, items: Int, animated anim: Bool) {
        setData(percent: percent, items: items, animated: anim, withDuration: 0.55)
    }
    
    func setData(percent: Float, items: Int, animated anim: Bool, withDuration duration: Double) {
        itemsNum = items
        setProgress(CGFloat(percent), animated: anim, withDuration: duration)
        label5.text = String(items)
    }
}
