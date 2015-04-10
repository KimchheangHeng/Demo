//
//  ViewController.swift
//  EditResponder
//
//  Created by Emiaostein on 15/4/10.
//  Copyright (c) 2015年 BoTai Technology. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  
  var mask: MaskProxyView!
  override func viewDidLoad() {
    super.viewDidLoad()
    
    mask = MaskProxyView(frame: CGRectMake(100, 100, 100, 100))
    view.addSubview(mask)
  }

  
  
  @IBAction func gobalPanAction(sender: UIPanGestureRecognizer) {
    
    switch sender.state {
    case .Began:
      println("gobalPan");
    default:
      return
    }
  }

}


