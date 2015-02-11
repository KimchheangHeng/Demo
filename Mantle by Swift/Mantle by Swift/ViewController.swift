//
//  ViewController.swift
//  Mantle by Swift
//
//  Created by Emiaostein on 2/11/15.
//  Copyright (c) 2015 BoTai Technology. All rights reserved.
//

import UIKit


class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let json: String! = NSBundle.mainBundle().pathForResource("json", ofType: "")
        let inputData: NSData = NSData.dataWithContentsOfMappedFile(json) as NSData
        let stri = NSString(data: inputData, encoding: NSUTF8StringEncoding)
        var error: NSError?
        var boardsDictionary: NSDictionary = NSJSONSerialization.JSONObjectWithData(inputData, options: NSJSONReadingOptions.MutableContainers, error: &error) as NSDictionary
        
        let model: EMModel = MTLJSONAdapter.modelOfClass(EMModel.self, fromJSONDictionary: boardsDictionary, error: nil) as EMModel
        
        println(boardsDictionary)
    }



}

