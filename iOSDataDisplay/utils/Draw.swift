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
    let view = UIView(frame: CGRect(x: x, y: y, width: mainSize.width, height: height))
    view.backgroundColor = UIColor(red: 222/255, green: 221/255, blue: 221/255, alpha: 0.81)
    return view
}
