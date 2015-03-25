//
//  SubViewController.swift
//  mutliViewGestureControll
//
//  Created by Emiaostein on 15/3/25.
//  Copyright (c) 2015年 BoTai Technology. All rights reserved.
//

import UIKit

class SubViewController: UIViewController {

  @IBOutlet weak var imageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()

      
        // Do any additional setup after loading the view.
      
    }

  func log() {
    
    println("subVC")
  }
  
  func shouldResponseToLocation(location: CGPoint) -> Bool {
    println("\(imageView.frame)")
    return CGRectContainsPoint(imageView.frame, location)
  }
  
  func getImageViewSnapShot() -> UIView {
    
    return imageView.snapshotViewAfterScreenUpdates(false)
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
