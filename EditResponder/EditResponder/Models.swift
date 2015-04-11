//
//  Models.swift
//  EditResponder
//
//  Created by 星宇陈 on 15/4/11.
//  Copyright (c) 2015年 BoTai Technology. All rights reserved.
//

import UIKit

class ComponentModel: NSObject {
    
    var center = CGPointZero
    var size = CGSizeZero
    var rotation: CGFloat = 0.0
    var color = UIColor.darkGrayColor()
    
    init(center aCenter: CGPoint, size aSize: CGSize, color aColor: UIColor, rotation aRotation: CGFloat) {
        center = aCenter
        size = aSize
        rotation = aRotation
        color = aColor
    }
}
