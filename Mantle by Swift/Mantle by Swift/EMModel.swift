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
    var age: String!
    var url: String?
}


extension EMModel: MTLJSONSerializing {
    
     class func JSONKeyPathsByPropertyKey() -> [NSObject : AnyObject]! {
        
        return [
            "date":"result.date",
            "age":"result.age",
            "url":"result.htmlurl"
        ]
    }
    
    class func urlJSONTransformer() -> NSValueTransformer {
        
        return NSValueTransformer(forName: MTLURLValueTransformerName)!
    }

}

/*
{
"name": "Emiaostein",
"result": {
"date": "2015/02/12",
"age": "25",
"htmlurl": "www.baidu.com"
},
"subEntity": {
"address": "beijing"
},
"subEntites": [
{
"address": "beijing111"
},
{
"address": "beijing222"
}
]
}
*/