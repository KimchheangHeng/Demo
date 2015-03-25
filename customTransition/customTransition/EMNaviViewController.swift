//
//  EMNaviViewController.swift
//  customTransition
//
//  Created by 星宇陈 on 15/3/25.
//  Copyright (c) 2015年 Emiaostein. All rights reserved.
//

import UIKit

class EMNaviViewController: UINavigationController, UINavigationControllerDelegate {
  
  let transitionAnimatoin = TransitionAnimation()

    override func viewDidLoad() {
        super.viewDidLoad()
      self.delegate = self

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
  func navigationController(navigationController: UINavigationController,
    animationControllerForOperation operation: UINavigationControllerOperation,
    fromViewController fromVC: UIViewController,
    toViewController toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
    
      switch operation {
        
      case .Push:
        return transitionAnimatoin
      case .Pop:
        return transitionAnimatoin
      case .None:
        return nil
        
      }
  }

}
