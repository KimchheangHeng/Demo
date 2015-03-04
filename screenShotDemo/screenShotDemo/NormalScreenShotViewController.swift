//
//  NormalScreenShotViewController.swift
//  screenShotDemo
//
//  Created by 星宇陈 on 15/3/4.
//  Copyright (c) 2015年 Emiaostein. All rights reserved.
//

import UIKit

class NormalScreenShotViewController: UIViewController, SnapshotDelegate {
  @IBOutlet weak var view1: UIView!

  @IBOutlet weak var view2: UIView!
    override func viewDidLoad() {
      super.viewDidLoad()
  }


  func snapshotForSpecialView() -> UIView {
    
//    let subviews = view.subviews
    let subviews = [view1, view2]
    
//
    return snapshotFunc(subviews as [UIView])
  }
  
  deinit {
    
    println("NormalScreenShotViewController deinit")
  }

    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
  
  let snapshotFunc = {(views: [UIView]) -> UIView in
    
    let maxSize = maxSizeFunc(views)
    let containerView = UIView(frame: CGRectMake(0, 0, maxSize.width, maxSize.height))
    containerView.backgroundColor = UIColor.darkGrayColor()
    //         UIGraphicsBeginImageContextWithOptions(maxSize, false, 1)
    var y: CGFloat = 0.0
    for aView in views {
      
      //          aView.drawViewHierarchyInRect(CGRectMake(0, 0, aView.bounds.width, aView.bounds.height), afterScreenUpdates: true)
      let snapshot = aView.snapshotViewAfterScreenUpdates(true)
      snapshot.frame.origin.y = y
      y = CGRectGetMaxY(snapshot.frame)
      containerView.addSubview(snapshot)
    }
    return containerView
  }

let maxSizeFunc = {(views: [UIView]) -> CGSize in
  
  var size = (width: 0.0, height: 0.0)
  
  for aView in views {
    
    let width = Double(aView.bounds.width)
    let height = Double(aView.bounds.height)
    
    if size.width < width {
      size.width = width
    }
    
    size.height += height
  }
  
  return CGSizeMake(CGFloat(size.0), CGFloat(size.1))
}



