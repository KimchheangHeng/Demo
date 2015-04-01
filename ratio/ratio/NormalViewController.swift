//
//  NormalViewController.swift
//  ratio
//
//  Created by Emiaostein on 15/4/1.
//  Copyright (c) 2015年 BoTai Technology. All rights reserved.
//

import UIKit

class NormalViewController: UIViewController {

  @IBOutlet weak var containerVIew: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()

      LayoutSpec.shareSpec.layout(LayoutSpec.shareSpec.item, containerView: containerVIew);
    }

  @IBAction func backAction(sender: UIButton) {
    
    self.presentingViewController?.dismissViewControllerAnimated(true, completion: nil);
  }
}
