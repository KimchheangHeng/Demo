//
//  Models.swift
//  EditResponder
//
//  Created by 星宇陈 on 15/4/11.
//  Copyright (c) 2015年 BoTai Technology. All rights reserved.
//

import UIKit

class ComponentModel: NSObject {
    
    var frame = CGRectZero
    var color = UIColor.darkGrayColor()
    
    init(frame aframe: CGRect, color aColor: UIColor) {
        frame = aframe
        color = aColor
    }
}
