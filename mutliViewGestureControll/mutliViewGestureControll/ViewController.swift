//
//  ViewController.swift
//  mutliViewGestureControll
//
//  Created by Emiaostein on 15/3/25.
//  Copyright (c) 2015年 BoTai Technology. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  
  
  @IBOutlet weak var boxView: UIView!
  var childVC: SubViewController!
  var fakeView: UIView?
  @IBOutlet weak var containerView: UIView!
  override func viewDidLoad() {
    super.viewDidLoad()
    
    for subvc in self.childViewControllers {
      if let child = subvc as? SubViewController {
        childVC = child;
        break
      }
    }
  }
  
  @IBAction func longPressAction(sender: UILongPressGestureRecognizer) {
    
    let loction = sender.locationInView(childVC.view);
    let theLoction = sender.locationInView(self.view);
    switch sender.state {
    case .Began:
      if childVC!.shouldResponseToLocation(loction){

        fakeView = childVC.getImageViewSnapShot()
        
        if let imageFakeView = fakeView {
          imageFakeView.center = theLoction
          self.view.addSubview(imageFakeView)
        }
      }
      
    case .Changed:
      if let imageFakeView = fakeView {
        
        imageFakeView.center = theLoction
      }
      
      UIView.animateWithDuration(0.4, animations: { () -> Void in
        self.boxView.backgroundColor = CGRectContainsPoint(self.boxView.frame, theLoction) ? UIColor.blueColor() : UIColor.orangeColor()
      })
      
      
      
    case .Cancelled:
      fallthrough
    case .Ended:
      if let imageFakeView = fakeView {
        
        if CGRectContainsPoint(boxView.frame, theLoction) {
          
          let center = sender.locationInView(boxView);
          boxView .addSubview(imageFakeView);
          imageFakeView.center = center;
        } else {
          imageFakeView.removeFromSuperview()
        }
        UIView.animateWithDuration(0.4, animations: { () -> Void in
          self.boxView.backgroundColor = UIColor.orangeColor()
        })
        
      }
      
    default: return
      
    }
  }
}

