//
//  ViewController.swift
//  CuriosSwift
//
//  Created by Emiaostein on 15/4/17.
//  Copyright (c) 2015年 BoTai Technology. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let dic = ["frame":NSValue(CGRect: CGRectMake(100, 100, 100, 100))]
        let item = Item.modelWithDictionary(dic, error: nil)
        
        println(item)
    }
}

