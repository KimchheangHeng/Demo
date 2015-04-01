//
//  HeightViewController.swift
//  ratio
//
//  Created by Emiaostein on 15/4/1.
//  Copyright (c) 2015年 BoTai Technology. All rights reserved.
//

import UIKit

class HeightViewController: UIViewController {

  @IBOutlet weak var containerView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()

      LayoutSpec.shareSpec.layout(LayoutSpec.shareSpec.item, containerView: containerView);
    }

  @IBAction func backAction(sender: UIButton) {
    
    self.presentingViewController?.dismissViewControllerAnimated(true, completion: nil);
  }
}
