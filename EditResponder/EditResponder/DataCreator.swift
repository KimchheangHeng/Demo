//
//  DataCreator.swift
//  EditResponder
//
//  Created by 星宇陈 on 15/4/11.
//  Copyright (c) 2015年 BoTai Technology. All rights reserved.
//

import UIKit

class DataCreator: NSObject {
    
    class func componentModels() -> [ComponentModel] {
        
        var array: [ComponentModel] = []
        let number: Int = Int(arc4random() % 1 + 1)
        
        for i in 0...number {
            
            let x = CGFloat(arc4random() % 200)
            let y = CGFloat(arc4random() % 400 + 50)
            let width = CGFloat(arc4random() % 200 + 100)
            let height = CGFloat(arc4random() % 200 + 100)
            let center = CGPointMake(x, y)
            let size = CGSizeMake(width, height)
            let scale: CGFloat = 1
            let rotation: CGFloat = 0.0
            let color = UIColor(red: CGFloat((x % 255)) / 255.0, green: CGFloat((x % 255)) / 255.0, blue: CGFloat((x % 255))/255.0, alpha: 1.0)
            let model = ComponentModel(center: center, size: size, sclae: scale, color: color, rotation: rotation)
            array.append(model)
        }
        return array
    }
}
