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
        let number: Int = Int(arc4random() % 6 + 1)
        
        for i in 0...number {
            
            let x = arc4random() % 200
            let y = arc4random() % 400 + 50
            let width = arc4random() % 200 + 100
            let height = arc4random() % 200 + 100
            let frame = CGRectMake(CGFloat(x),CGFloat(y),CGFloat(width),CGFloat(height))
            let color = UIColor(red: CGFloat((x % 255)) / 255.0, green: CGFloat((x % 255)) / 255.0, blue: CGFloat((x % 255))/255.0, alpha: 1.0)
            let model = ComponentModel(frame: frame, color: color)
            array.append(model)
        }
        return array
    }
}
