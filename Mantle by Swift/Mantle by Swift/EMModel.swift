//
//  EMModel.swift
//  Mantle by Swift
//
//  Created by Emiaostein on 2/11/15.
//  Copyright (c) 2015 BoTai Technology. All rights reserved.
//

import UIKit

class EMModel: MTLModel {
    
   @objc enum animaitons: Int {
        case None = 0, FadeIn, FadeOut
    
    
    }
    
    var name = ""
    var date: NSDate!
    var age = 0
    var x = 0
    var y = 0
    var width = 0
    var height = 0
    var bool = false
    var animaiton: animaitons = .None
    var subEntity: EMSubModel!
    var subEntites: [EMSubModel]! = []
    var url: NSURL!
}


extension EMModel: MTLJSONSerializing {
    
    class func JSONKeyPathsByPropertyKey() -> [NSObject : AnyObject]! {
        let center = "center" + "."
        let size = "size" + "."
        return [
            "date":"result.date",
            "age":"result.age",
            "url":"result.htmlurl",
            "x":center + "x",
            "y":center + "y",
            "width":size + "width",
            "height":size + "height"
        ]
    }
    
    class func dateFormatter() -> NSDateFormatter {
        
        let dateFormatter = NSDateFormatter()
        dateFormatter.locale = NSLocale(localeIdentifier: "en_US_POSIX")
//        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter
    }
    
    class func animaitonJSONTransformer() -> NSValueTransformer {
        
        return NSValueTransformer.mtl_valueMappingTransformerWithDictionary([
            "None":animaitons.None.rawValue,
            "FadeIn":animaitons.FadeIn.rawValue,
            "FadeOut":animaitons.FadeOut.rawValue
            ])
    }
    
    
    class func urlJSONTransformer() -> NSValueTransformer {
        
        return NSValueTransformer(forName: MTLURLValueTransformerName)!
    }
    
    class func dateJSONTransformer() -> NSValueTransformer {
        
        let dateFormatter = self.dateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return MTLValueTransformer.reversibleTransformerWithForwardBlock({(dateStr) -> AnyObject! in
            return dateFormatter.dateFromString(dateStr as! String)
            }, reverseBlock: { (date) -> AnyObject! in
                
                return dateFormatter.stringFromDate(date as! NSDate)
        })
    }
    
//    class func subEntityJSONTransformer() -> NSValueTransformer {
//        
//        return MTLValueTransformer.reversibleTransformerWithForwardBlock({ (ModelStr) -> AnyObject! in
//            
//            return MTLJSONAdapter.modelOfClass(EMSubModel.self, fromJSONDictionary: ModelStr as! NSDictionary as [NSObject : AnyObject], error: nil)
//            
//            }, reverseBlock: { (subEntity) -> AnyObject! in
//                
//                return MTLJSONAdapter.JSONDictionaryFromModel(subEntity as! EMSubModel)
//        })
//    }
    
    class func subEntitesJSONTransformer() -> NSValueTransformer {
        
        return MTLValueTransformer.reversibleTransformerWithForwardBlock({ (ModelStrs) -> AnyObject! in
            
            return MTLJSONAdapter.modelsOfClass(EMSubModel.self, fromJSONArray: ModelStrs as! [EMSubModel], error: nil)
            
            }, reverseBlock: { (subEntities) -> AnyObject! in
                
                return MTLJSONAdapter.JSONArrayFromModels(subEntities as! [EMSubModel])
        })
    }
}
