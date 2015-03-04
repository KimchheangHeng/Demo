//
//  DetailViewController.swift
//  screenShotDemo
//
//  Created by 星宇陈 on 15/3/4.
//  Copyright (c) 2015年 Emiaostein. All rights reserved.
//

import UIKit

@objc protocol SnapshotDelegate {
  
  func snapshotForSpecialView() -> UIView;
}

class DetailViewController: UIViewController {
  
  var detailID: String!
  var childContentViewController: UIViewController!

  @IBOutlet weak var detailDescriptionLabel: UILabel!


  var detailItem: AnyObject? {
    didSet {
        // Update the view.
        self.configureView()
    }
  }

  func configureView() {
    // Update the user interface for the detail item.
    if let detail: AnyObject = self.detailItem {
        if let label = self.detailDescriptionLabel {
            label.text = detail.description
        }
    }
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    self.configureView()
    self.edgesForExtendedLayout = .None
    
    let normalScreenShotVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier(detailID) as UIViewController
    
    childContentViewController = normalScreenShotVC
    
    self.addChildViewController(normalScreenShotVC)
    self.view.addSubview(normalScreenShotVC.view)
    
  }
  
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    
    if let vc = childContentViewController as? SnapshotDelegate {
      
      let snapshot = vc.snapshotForSpecialView()
      let targetVC = segue.destinationViewController as UIViewController
      targetVC.edgesForExtendedLayout = UIRectEdge.None
//      targetVC.view.bounds.origin.y -= 64
      
      targetVC.view .addSubview(snapshot)
      
    }
  }
}

