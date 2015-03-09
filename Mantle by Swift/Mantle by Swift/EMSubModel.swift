//
//  EMSubModel.swift
//  Mantle by Swift
//
//  Created by 星宇陈 on 15/3/9.
//  Copyright (c) 2015年 BoTai Technology. All rights reserved.
//

import UIKit

class EMSubModel: MTLModel {
  
  var address: String!
}

extension EMSubModel: MTLJSONSerializing {
  
  class func JSONKeyPathsByPropertyKey() -> [NSObject : AnyObject]! {
    
    return [String: AnyObject]()
  }
}
