//
//  PopTransitionAnimation.swift
//  customTransition
//
//  Created by Emiaostein on 15/3/25.
//  Copyright (c) 2015年 Emiaostein. All rights reserved.
//

import UIKit

class PopTransitionAnimation: NSObject,UIViewControllerAnimatedTransitioning {
  
  func transitionDuration(transitionContext: UIViewControllerContextTransitioning) -> NSTimeInterval {
    
    return 0.2
  }
  
  func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
    
    let fromViewController = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey)! as SubViewController
    let toViewController = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey)! as ViewController
    
    let finalFrameForVC = transitionContext.finalFrameForViewController(toViewController)
    let containerView = transitionContext.containerView()
    let bounds = UIScreen.mainScreen().bounds
    //    toViewController.view.frame = CGRectOffset(finalFrameForVC, 0, bounds.size.height)
    toViewController.view.frame = CGRectOffset(finalFrameForVC, 0, 0)
//    toViewController.view.alpha = 0;
    fromViewController.performBackAction { (Bool) -> Void in
      containerView.addSubview(toViewController.view)
      
      transitionContext.completeTransition(true)
      
    }
  }
}
