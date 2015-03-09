//
//  EMModel.swift
//  Mantle by Swift
//
//  Created by Emiaostein on 2/11/15.
//  Copyright (c) 2015 BoTai Technology. All rights reserved.
//

import UIKit

class EMModel: MTLModel {
  
  var name: String!
  var date: NSDate!
  var age: NSNumber!
  var subEntity: EMSubModel!
  var subEntites: [EMSubModel]!
  var url: NSURL!
}


extension EMModel: MTLJSONSerializing {
  
  class func JSONKeyPathsByPropertyKey() -> [NSObject : AnyObject]! {
    
    return [
      "date":"result.date",
      "age":"result.age",
      "url":"result.htmlurl"
    ]
  }
  
  class func dateFormatter() -> NSDateFormatter {
    
    let dateFormatter = NSDateFormatter()
    dateFormatter.locale = NSLocale(localeIdentifier: "en_US_POSIX")
    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
    return dateFormatter
  }
  
  class func urlJSONTransformer() -> NSValueTransformer {
    
    return NSValueTransformer(forName: MTLURLValueTransformerName)!
  }
  
  class func dateJSONTransformer() -> NSValueTransformer {
    
    let dateFormatter = NSDateFormatter()
    dateFormatter.dateFormat = "yyyy/MM/dd"
    return MTLValueTransformer.reversibleTransformerWithForwardBlock({(dateStr) -> AnyObject! in
      return dateFormatter.dateFromString(dateStr as String)
      }, reverseBlock: { (date) -> AnyObject! in
        
        return dateFormatter.stringFromDate(date as NSDate)
    })
  }
  
  class func subEntityJSONTransformer() -> NSValueTransformer {
    
    return MTLValueTransformer.reversibleTransformerWithForwardBlock({ (ModelStr) -> AnyObject! in
      
      return MTLJSONAdapter.modelOfClass(EMSubModel.self, fromJSONDictionary: ModelStr as NSDictionary, error: nil)
      
      }, reverseBlock: { (subEntity) -> AnyObject! in
        
        return MTLJSONAdapter.JSONDictionaryFromModel(subEntity as EMSubModel)
    })
  }
  
  class func subEntitiesJSONTransformer() -> NSValueTransformer {
    
    return MTLValueTransformer.reversibleTransformerWithForwardBlock({ (ModelStrs) -> AnyObject! in
      
      return MTLJSONAdapter.modelsOfClass(EMSubModel.self, fromJSONArray: ModelStrs as NSArray, error: nil)
      
      }, reverseBlock: { (subEntities) -> AnyObject! in
        
        return MTLJSONAdapter.JSONArrayFromModels(subEntities as NSArray)
    })
  }
}
