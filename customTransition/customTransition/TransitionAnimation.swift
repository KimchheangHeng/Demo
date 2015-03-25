//
//  TransitionAnimation.swift
//  customTransition
//
//  Created by 星宇陈 on 15/3/25.
//  Copyright (c) 2015年 Emiaostein. All rights reserved.
//

import UIKit

class TransitionAnimation: NSObject, UIViewControllerAnimatedTransitioning {
  
  func transitionDuration(transitionContext: UIViewControllerContextTransitioning) -> NSTimeInterval {
    
    return 1
  }
  
  func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
    
    let fromViewController = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey)! as ViewController
    let toViewController = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey)! as SubViewController
    toViewController.imageVIew.image = fromViewController.imageVIew.image;
    
    let finalFrameForVC = transitionContext.finalFrameForViewController(toViewController)
    let containerView = transitionContext.containerView()
    let bounds = UIScreen.mainScreen().bounds
//    toViewController.view.frame = CGRectOffset(finalFrameForVC, 0, bounds.size.height)
    toViewController.view.frame = CGRectOffset(finalFrameForVC, 0, 0)
    toViewController.view.alpha = 0;
    containerView.addSubview(toViewController.view)
    
    UIView.animateWithDuration(transitionDuration(transitionContext), delay: 0.0, usingSpringWithDamping: 5, initialSpringVelocity: 0.0, options: .CurveEaseInOut, animations: {
      fromViewController.view.alpha = 0
//      toViewController.view.frame = finalFrameForVC
      toViewController.view.alpha = 1
      }, completion: {
        finished in
        transitionContext.completeTransition(true)
        fromViewController.view.alpha = 1.0
    })
  }
}
