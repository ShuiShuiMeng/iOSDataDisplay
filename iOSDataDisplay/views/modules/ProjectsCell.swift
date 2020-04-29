//
//  ProjectsCell.swift
//  iOSDataDisplay
//
//  Created by Flora on 2020/4/21.
//  Copyright © 2020年 yinmeng. All rights reserved.
//

import UIKit

class ProjectsCell: UITableViewCell {

    var pulldown: UIImageView!
    
    var category: UILabel!
    var approval: UILabel!
    var fundding: UILabel!
    
    var details: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init:(coder:) has not been implemented")
    }
    
    func initPulldown() {
        pulldown = UIImageView(frame: CGRect(x: 15, y: 17.5, width: 15, height: 15))
        setRight()
        self.contentView.addSubview(pulldown)
    }
    
    func setRight() {
        pulldown.image = Icons.right_solid.iconFontImage(fontSize: 15, color: .black)
    }
    
    func setDown() {
        pulldown.image = Icons.down_solid.iconFontImage(fontSize: 15, color: .black)
    }
    
    func initCategory(name str: String) {
        category = UILabel(frame: CGRect(x: 30, y: 15, width: 155, height: 20))
        category.text = str
        category.textAlignment = .left
        category.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        self.contentView.addSubview(category)
    }
    
    func initApproval(approval num: Int) {
        approval = UILabel(frame: CGRect(x: 185, y: 15, width: 40 , height: 20))
        approval.text = String(num)
        approval.textAlignment = .right
        approval.font = UIFont.init(descriptor: UIFontDescriptor(name: "DIN Alternate Bold", size: 15), size: 15)
        self.contentView.addSubview(approval)
    }
    
    func initFundding(fundding num: Float) {
        fundding = UILabel(frame: CGRect(x: 240, y: 15, width: 70 , height: 20))
        fundding.text = (num/10000).cleanZero4
        fundding.textAlignment = .right
        fundding.font = UIFont.init(descriptor: UIFontDescriptor(name: "DIN Alternate Bold", size: 15), size: 15)
        self.contentView.addSubview(fundding)
    }

    func initDetails(percent per: Float, limit: Float, finishedPercent fper: Float) {
        details = UIView(frame: CGRect(x: 0, y: 50, width: 340, height: 56))
        details.backgroundColor = Colors.pullblue
        // 计划额度
        let n0 = UILabel(frame: CGRect(x: 30, y: 11, width: 70, height: 15))
        n0.textColor = Colors.lineblue
        n0.textAlignment = .left
        n0.font = UIFont.init(descriptor: UIFontDescriptor(name: "DIN Alternate Bold", size: 14), size: 14)
        n0.text = (limit/10000).cleanZero4
        details.addSubview(n0)
        // label
        let l0 = UILabel(frame: CGRect(x: 30, y: 29, width: 70, height: 15))
        l0.textColor = Colors.textgray
        l0.textAlignment = .left
        l0.font = UIFont.systemFont(ofSize: 10, weight: .regular)
        l0.text = "计划额度(万)"
        details.addSubview(l0)
        
        // 计划额度占比 op = oprogress
        let op1 = OProgressView(frame: CGRect(x: 105, y: 10, width: 36, height: 36), lineWidth: 8, trackColor: Colors.trackgray, progressColor: Colors.lineblue, idotColor: Colors.lineblue)
        op1.setProgress(CGFloat(per), animated: true)
        details.addSubview(op1)
        // number
        let n1 = UILabel(frame: CGRect(x: 145, y: 11, width: 75, height: 15))
        n1.textColor = Colors.lineblue
        n1.textAlignment = .left
        n1.font = UIFont.init(descriptor: UIFontDescriptor(name: "DIN Alternate Bold", size: 14), size: 14)
        n1.text = (per*100).cleanZero + "%"
        details.addSubview(n1)
        // label
        let l1 = UILabel(frame: CGRect(x: 145, y: 29, width: 75, height: 15))
        l1.textColor = Colors.textgray
        l1.textAlignment = .left
        l1.font = UIFont.systemFont(ofSize: 10, weight: .regular)
        l1.text = "计划额度占比"
        details.addSubview(l1)
        
        /*
        // 申请项目数
        let op2 = OProgressView(frame: CGRect(x: 120, y: 10, width: 36, height: 36), lineWidth: 8, trackColor: Colors.trackgray, progressColor: Colors.lineblue, idotColor: Colors.lineblue)
        op2.setProgress(CGFloat(approval)/CGFloat(apply), animated: true)
        details.addSubview(op2)
        // number
        let n2 = UILabel(frame: CGRect(x: 160, y: 11, width: 80, height: 15))
        // n2.textColor = Colors.lineblue
        n2.textAlignment = .left
        n2.font = UIFont.init(descriptor: UIFontDescriptor(name: "DIN Alternate Bold", size: 14), size: 14)
        let approvalStr = String(approval)
        let totalStr = approvalStr + " / " + String(apply)
        // 可变字符串
        let attrText = NSMutableAttributedString(string: totalStr)
        attrText.addAttribute(.foregroundColor, value: Colors.lineblue, range: NSRange(location: 0, length: approvalStr.count))
        attrText.addAttribute(.foregroundColor, value: Colors.textgray, range: NSRange(location: approvalStr.count, length: totalStr.count-approvalStr.count))
        n2.attributedText = attrText
        details.addSubview(n2)
        // label
        let l2 = UILabel(frame: CGRect(x: 160, y: 29, width: 80, height: 15))
        l2.textColor = Colors.textgray
        l2.textAlignment = .left
        l2.font = UIFont.systemFont(ofSize: 10, weight: .regular)
        l2.text = "申请项目数"
        details.addSubview(l2)
        */
        
        // 已执行
        let lp = LProgressView(frame: CGRect(x: 235, y: 15, width: 70, height: 8), trackColor: Colors.trackgray, progressColor: Colors.lineblue)
        lp.setProgress(CGFloat(fper), animated: true)
        details.addSubview(lp)
        self.contentView.addSubview(details)
        // number
        let n3 = UILabel(frame: CGRect(x: 235, y: 29, width: 35, height: 15))
        n3.textColor = Colors.lineblue
        n3.textAlignment = .left
        n3.font = UIFont.init(descriptor: UIFontDescriptor(name: "DIN Alternate Bold", size: 11), size: 11)
        n3.text = (fper*100).cleanZero + "%"
        details.addSubview(n3)
        // label
        let l3 = UILabel(frame: CGRect(x: 270, y:29, width: 35, height:15))
        l3.textColor = Colors.textgray
        l3.textAlignment = .right
        l3.font = UIFont.systemFont(ofSize: 10, weight: .regular)
        l3.text = "已执行"
        details.addSubview(l3)
    }

}
