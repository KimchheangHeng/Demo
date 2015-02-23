//
//  EMImageView.swift
//  test
//
//  Created by 星宇陈 on 15/2/23.
//  Copyright (c) 2015年 Emiaostein. All rights reserved.
//

import UIKit

@IBDesignable
class EMImageView: UIImageView {

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
  
  override func prepareForInterfaceBuilder() {
    
    self.image = EMUIKit.imageOfCanvas2
  }

}
