//
//  PageCell.swift
//  LayoutChange
//
//  Created by 星宇陈 on 15/4/8.
//  Copyright (c) 2015年 BoTai Technology. All rights reserved.
//

import UIKit

class PageCell: UICollectionViewCell {
  
  var aContainerView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        let size = LayoutSpec.layoutConstants.normalLayout.itemSize
        let containerView = UIView(frame: CGRectMake(0, 0, size.width, size.height))
        containerView.backgroundColor = UIColor.lightGrayColor()
        self.contentView.addSubview(containerView)
        aContainerView = containerView
      
      
    }
  
  override func prepareForReuse() {
    
    for subView in aContainerView.subviews {
      if let vi = subView as? UIView {
        vi.removeFromSuperview()
      }
    }
    let x = arc4random() % 200
    let y = arc4random() % 200
    let width = arc4random() % 200
    let height = arc4random() % 200
    let aview = UIView(frame: CGRectMake(CGFloat(x), CGFloat(y), CGFloat(width), CGFloat(height)))
    aview.backgroundColor = UIColor(red: 0.2, green: 0.4, blue: 0.9, alpha: 1)
    aContainerView.addSubview(aview)
  }
}
