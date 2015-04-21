//
//  EMSubModel.swift
//  Mantle by Swift
//
//  Created by 星宇陈 on 15/3/9.
//  Copyright (c) 2015年 BoTai Technology. All rights reserved.
//

import UIKit

class EMSubModel: MTLModel {
  
     enum types: String {
        case Text = "Text", Image = "Image", None = "None"
    }
    
    var type = "None"
    var value = ""
}

extension EMSubModel: MTLJSONSerializing {
  
  class func JSONKeyPathsByPropertyKey() -> [NSObject : AnyObject]! {
    
    return [String: AnyObject]()
  }
    
    class func classForParsingJSONDictionary(JSONDictionary: [NSObject : AnyObject]!) -> AnyClass! {
        
        if let type = JSONDictionary["type"] as? NSString {
            
            switch type {
            case types.Text.rawValue:
                
                return EMTextSubModel.self
                
            case types.Image.rawValue:
                
                return EMImageSubModel.self
            default:
                
                return EMNoneSubModel.self
                
            }
        } else {
            return EMNoneSubModel.self
        }
    }
}

class EMImageSubModel: EMSubModel {
    
    
}

class EMTextSubModel: EMSubModel {
    
    
}

class EMNoneSubModel: EMSubModel {
    
    
}
