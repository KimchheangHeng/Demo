//
//  DismissSegue.swift
//  storyboardDemo
//
//  Created by 星宇陈 on 15/3/10.
//  Copyright (c) 2015年 Emiaostein. All rights reserved.
//

import UIKit

class DismissSegue: UIStoryboardSegue {
  
  override func perform() {
    
    (sourceViewController as UIViewController).presentingViewController?.dismissViewControllerAnimated(true, completion: nil)
  }
}
