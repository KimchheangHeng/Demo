//
//  ViewController.swift
//  scale
//
//  Created by Emiaostein on 15/3/30.
//  Copyright (c) 2015年 BoTai Technology. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

  @IBOutlet weak var containerView: UIView!
  @IBOutlet weak var subView: UIView!
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    
    let component = UIView(frame: CGRectMake(100, 100, 100, 100));
    component.backgroundColor = UIColor.redColor();
    subView.addSubview(component);
  }

  @IBOutlet var Slider: [UISlider]!
  
  var boundsWidth: Float {
    get {
      return Float(subView.bounds.width);
    }
  }
  var boundsHeight: Float {
    get {
      return Float(subView.bounds.height);
    }
  }

  @IBAction func SliderAction(sender: UISlider) {
    
    let progress = sender.value;
    let scale = PopTransition(progress, start: 1, end: 0.5);
//    println("\(scale)")

    let XTransition = CGFloat(PopTransition(progress, start: 0, end: -boundsWidth * (1 - scale)))
    let YTransition = CGFloat(PopTransition(progress, start: 0, end: -boundsHeight * (1 - scale)))
    
    println("x = \(boundsWidth), y = \(boundsHeight)")
    subView.transform = CGAffineTransformMakeScale(CGFloat(scale), CGFloat(scale))
    subView.transform = CGAffineTransformTranslate(subView.transform, CGFloat(XTransition), CGFloat(YTransition))
    
    containerView.transform = CGAffineTransformMakeTranslation(-XTransition, -YTransition)
//    subView.center = CGPoint(x: XTransition, y: YTransition));
  }
  
}

func PopTransition(progress: Float, start startValue:Float, end endValue: Float) -> Float {
  return startValue + (progress * (endValue - startValue))
}

