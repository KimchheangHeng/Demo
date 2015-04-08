//
//  LayoutSpec.swift
//  LayoutChange
//
//  Created by Emiaostein on 15/4/7.
//  Copyright (c) 2015年 BoTai Technology. All rights reserved.
//

import UIKit

class LayoutSpec: NSObject {
  struct layoutAttributeStyle {
    let itemSize: CGSize
    let sectionInsets: UIEdgeInsets
    let shrinkScale: CGFloat
  }
  
  struct layoutConstants {
    static let goldRatio: CGFloat = 0.618
    static let aspectRatio: CGFloat = 320.0 / 504.0
    static let normalLayoutInsetLeft: CGFloat = 30.0
    static let smallLayoutInsetTop: CGFloat = 20.0
    static var screenSize:CGSize = UIScreen.mainScreen().bounds.size
    
    static var normalLayout: layoutAttributeStyle {
      println("normalLayout")
      let width = floorf(Float(screenSize.width - normalLayoutInsetLeft * 2.0))
      let height = CGFloat(width) / aspectRatio
      let itemSize = CGSizeMake(CGFloat(width), CGFloat(height))
      
      let top = floorf(Float(screenSize.height - itemSize.height) / 2.0)
      let bottom = top
      let left = normalLayoutInsetLeft
      let right = normalLayoutInsetLeft
      let sectionInset = UIEdgeInsetsMake(CGFloat(top), left, CGFloat(bottom), right)
      
      return layoutAttributeStyle(itemSize: itemSize, sectionInsets: sectionInset, shrinkScale: 1.0)
    }
    
    static var smallLayout: layoutAttributeStyle {
        println("smallLayout")
        let height = floorf(Float(screenSize.height * (1 - goldRatio) - smallLayoutInsetTop * 2.0))
        let width = floorf(height * Float(aspectRatio))
        let itemSize = CGSize(width: CGFloat(width), height: CGFloat(height))
        
        let top = smallLayoutInsetTop
        let bottom = screenSize.height - CGFloat(top) - CGFloat(height)
        let left = (screenSize.width - CGFloat(width)) / 2.0
        let right = left
        let sectionInset = UIEdgeInsetsMake(bottom, left, top, right)
        let scale = CGFloat(height) / normalLayout.itemSize.height
      
      return layoutAttributeStyle(itemSize: itemSize, sectionInsets: sectionInset, shrinkScale: scale)
    }
  }
}
