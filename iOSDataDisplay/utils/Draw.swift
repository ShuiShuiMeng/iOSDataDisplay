//
//  Draw.swift
//  iOSDataDisplay
//
//  Created by Flora on 2020/4/1.
//  Copyright © 2020年 yinmeng. All rights reserved.
//

import Foundation
import UIKit

public func drawGrayLineView(x: CGFloat, y: CGFloat, height: CGFloat) -> UIView {
    return drawLine(x: x, y: y, width:mainSize.width, height: height, color: Colors.lineGray)
}

public func drawLine(x: CGFloat, y: CGFloat, width: CGFloat, height: CGFloat, color: UIColor) -> UIView {
    let view = UIView(frame: CGRect(x: x, y: y, width: width, height: height))
    view.backgroundColor = color
    return view
}
