//
//  SubViewController.swift
//  customTransition
//
//  Created by 星宇陈 on 15/3/25.
//  Copyright (c) 2015年 Emiaostein. All rights reserved.
//

import UIKit
import Snap

class SubViewController: UIViewController {
  
  let onepadding = UIEdgeInsetsMake(10, 10, 10, 10)
  let twopadding = UIEdgeInsetsMake(200, 10, 200, 10)
  
  @IBOutlet weak var snapshotView: UIView!
   @IBOutlet weak var imageVIew: UIImageView!
  var subVie: UIView!
  
    override func viewDidLoad() {
        super.viewDidLoad()
      
      
      imageVIew.snp_remakeConstraints { (make) -> Void in
        make.edges.equalTo(self.view).with.insets(self.twopadding)
        return
      }

    }
  
  func performAction(finished:((Bool) -> Void)?) {
    imageVIew.snp_remakeConstraints { (make) -> Void in
      make.edges.equalTo(self.view).with.insets(self.onepadding)
      return
    }
    
    UIView.animateWithDuration(0.5, animations: { () -> Void in
      
      self.view.layoutIfNeeded()
    }) { (Bool) -> Void in
      
      if (finished != nil) {
        finished!(Bool)
      }
    }
  }
  
  func performBackAction(finished:((Bool) -> Void)?) {
    imageVIew.snp_remakeConstraints { (make) -> Void in
      make.edges.equalTo(self.view).with.insets(self.twopadding)
      return
    }
    
    UIView.animateWithDuration(0.5, animations: { () -> Void in
      
      self.view.layoutIfNeeded()
      }) { (Bool) -> Void in
        
        if (finished != nil) {
          finished!(Bool)
        }
    }
  }
  
  
  @IBAction func buttonAction(sender: UIButton) {
    
    self.navigationController?.popViewControllerAnimated(true)
  }
}
