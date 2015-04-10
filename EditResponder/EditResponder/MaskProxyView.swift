//
//  MaskProxyView.swift
//  EditResponder
//
//  Created by Emiaostein on 15/4/10.
//  Copyright (c) 2015年 BoTai Technology. All rights reserved.
//

import UIKit

protocol ArticleViewViewModel {
  var theframe: Dynamic<CGRect> { get }
}

class viewModela: ArticleViewViewModel {
  
  let theframe: Dynamic<CGRect>
  
  init(aframe: CGRect) {
    
    self.theframe = Dynamic(aframe)
  }
}

class MaskProxyView: UIView {
  
  var aviewModel: ArticleViewViewModel! {
    
    didSet {
      aviewModel.theframe.bindAndFire {
        [unowned self] in
        self.frame = $0
      }
    }
  }
  
  var activeRegion: [CGRect] {

    let rect = CGRectOffset(bounds, 0, 0)
    return [rect]
  }
  
  var scaleRegion: CGRect {
    
    return CGRectOffset(bounds, CGRectGetWidth(bounds) - 50, CGRectGetHeight(bounds) - 50)
  }

  override init(frame: CGRect) {
//    aviewModel = viewModela(aframe: frame)
    super.init(frame: frame)
    setupViewModel()
    setupGesture()
  }

  required init(coder aDecoder: NSCoder) {
//    aviewModel = viewModela(aframe: CGRectMake(100, 100, 100, 100))
    super.init(coder: aDecoder)
    setupViewModel()
    setupGesture()
  }
  
  func setupGesture() {
    self.backgroundColor = UIColor.clearColor()
    let pan = UIPanGestureRecognizer(target: self, action: "PanAction:")
    self.addGestureRecognizer(pan)
    pan.delegate = self;
  }
  
  func setupViewModel() {
    
    aviewModel = viewModela(aframe: frame)
    
    setNeedsDisplay()
  }
  
  func PanAction(sender: UIPanGestureRecognizer) {
    
    let transition = sender.translationInView(self)
    let location = sender.locationInView(self)
    
    if CGRectContainsPoint(scaleRegion, location) {
      
      aviewModel.theframe.value.size.width += transition.x
      aviewModel.theframe.value.size.height += transition.y
      setNeedsDisplay()
    } else {
      frame.origin.x += transition.x
      frame.origin.y += transition.y
    }
    
    
    sender.setTranslation(CGPointZero, inView: self)
  }
  
  override func drawRect(rect: CGRect) {
    
    super.drawRect(rect)
    drawCanvas1(frame: activeRegion[0] as CGRect)
  }
  
  func drawCanvas1(#frame: CGRect) {
    //// General Declarations
    let context = UIGraphicsGetCurrentContext()
    
    
    //// Subframes
    let frame2 = CGRectMake(frame.minX + floor((frame.width - 15) * 0.00000 + 0.5), frame.minY + floor((frame.height - 15) * 0.00000 + 0.5), frame.width - 15 - floor((frame.width - 15) * 0.00000 + 0.5), frame.height - 15 - floor((frame.height - 15) * 0.00000 + 0.5))
    
    
    //// Rectangle Drawing
    let rectanglePath = UIBezierPath(rect: CGRectMake(frame2.minX + 1, frame2.minY + 1, floor((frame2.width - 1) * 1.00000 + 0.5), floor((frame2.height - 1) * 1.00000 + 0.5)))
    UIColor.redColor().setStroke()
    rectanglePath.lineWidth = 1
    CGContextSaveGState(context)
    CGContextSetLineDash(context, 0, [2, 2], 2)
    rectanglePath.stroke()
    CGContextRestoreGState(context)
    
    //// Oval Drawing
    var ovalPath = UIBezierPath(ovalInRect: CGRectMake(frame2.minX + frame2.width - 16, frame2.minY + frame2.height - 16, 30, 30))
    UIColor.whiteColor().setFill()
    ovalPath.fill()
    UIColor.redColor().setStroke()
    ovalPath.lineWidth = 0.5
    ovalPath.stroke()
  }

}

extension MaskProxyView: UIGestureRecognizerDelegate {
  
  override func pointInside(point: CGPoint, withEvent event: UIEvent?) -> Bool {
    
    for rect in activeRegion {
      if CGRectContainsPoint(rect, point) {
        return true
      }
    }
    return false
  }
  
  override func gestureRecognizerShouldBegin(gestureRecognizer: UIGestureRecognizer) -> Bool {
    
    return true
  }
}
