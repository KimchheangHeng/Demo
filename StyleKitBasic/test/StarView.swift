//
//  StarView.swift
//  test
//
//  Created by 星宇陈 on 15/2/23.
//  Copyright (c) 2015年 Emiaostein. All rights reserved.
//

import UIKit

@IBDesignable
class StarView: UIView {
  
  @IBInspectable var color: UIColor? = UIColor.lightGrayColor(){
    didSet {
      setNeedsDisplay()
    }
  }
  
  override func drawRect(rect: CGRect) {
    // Drawing code
    EMUIKit.drawEM_Star(frame: rect, color: color!)
  }
}
