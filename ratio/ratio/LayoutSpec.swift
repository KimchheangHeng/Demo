//
//  LayoutSpec.swift
//  ratio
//
//  Created by Emiaostein on 15/4/1.
//  Copyright (c) 2015年 BoTai Technology. All rights reserved.
//

import UIKit

private let shareInstance = LayoutSpec()

class LayoutSpec: NSObject {
  class var shareSpec: LayoutSpec {
    return shareInstance
  }
  
  struct itemViewModel {
    let frame: CGRect
    let backgroundColor: UIColor
    
    init(aframe: CGRect, abackgroundColor: UIColor) {
      frame = aframe
      backgroundColor = abackgroundColor
    }
  }
  
  let size = CGSizeMake(320, 568)
  let item = itemViewModel(aframe: CGRectMake(100, 100, 200, 100), abackgroundColor: UIColor.darkGrayColor())
  
  func layout(item: itemViewModel, containerView: UIView) {
    
    let frame = containerView.frame;
    let ratio = size.width / size.height;
    let ratioZ = frame.width / frame.height;
    var scale:CGFloat = 0.0
    
    scale = ratioZ >= ratio ? (frame.height / size.height) : (frame.width / size.width)
    
    let subHeight = size.height * scale
    let subWidth = size.width * scale
    let subContainerView = UIView(frame: CGRectMake(0, 0, subWidth, subHeight))
    subContainerView.center = CGPoint(x: frame.width / 2.0, y: frame.height / 2.0)
    subContainerView.backgroundColor = UIColor.redColor()
    containerView.addSubview(subContainerView)
    
    let component = UIView(frame: CGRectMake(item.frame.origin.x * scale, item.frame.origin.y * scale, item.frame.size.width * scale, item.frame.size.height * scale))
    component.backgroundColor = item.backgroundColor
    
    subContainerView.addSubview(component)
    
  }
}
