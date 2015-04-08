//
//  MathSpec.swift
//  LayoutChange
//
//  Created by 星宇陈 on 15/4/8.
//  Copyright (c) 2015年 BoTai Technology. All rights reserved.
//

import UIKit

func PopTransition(progress: Float, startValue: Float, endValue: Float) -> Float {
    return startValue + (progress * (endValue - startValue))
}

class MathSpec: NSObject {
   
}
