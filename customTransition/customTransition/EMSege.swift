//
//  EMSege.swift
//  customTransition
//
//  Created by 星宇陈 on 15/3/25.
//  Copyright (c) 2015年 Emiaostein. All rights reserved.
//

import UIKit

class EMSege: UIStoryboardSegue {
  
  override func perform() {
    
    (sourceViewController as UIViewController).navigationController?.popViewControllerAnimated(true);
  }
}
