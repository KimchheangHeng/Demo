//
//  ViewController.swift
//  customTransition
//
//  Created by 星宇陈 on 15/3/25.
//  Copyright (c) 2015年 Emiaostein. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

  let twopadding = UIEdgeInsetsMake(200, 10, 200, 10)
  
  @IBOutlet weak var imageVIew: UIImageView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    imageVIew.snp_makeConstraints { (make) -> Void in
      make.edges.equalTo(self.view).with.insets(self.twopadding)
      return
    }
  }

}

