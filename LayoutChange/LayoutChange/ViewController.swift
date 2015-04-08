//
//  ViewController.swift
//  LayoutChange
//
//  Created by Emiaostein on 15/4/7.
//  Copyright (c) 2015年 BoTai Technology. All rights reserved.
//

import UIKit
import Snap

class ViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    let normalLayout = NormalLayout()
    let smallLayout = SmallLayout()

  override func viewDidLoad() {
    super.viewDidLoad()
  }
    
    @IBAction func PanAction(sender: UIPanGestureRecognizer) {
      
      let transition = sender.translationInView(view)
        switch sender.state {
        case .Began:
            collectionView.startInteractiveTransitionToCollectionViewLayout(smallLayout, completion: { (completed, finished) -> Void in
                
            })
            return
        case .Changed:
          
           let aprogress = transition.y / 300.0
           let transitionPorgress = PopTransition(aprogress, 0, 1)
          
            let transitionLayout = collectionView.collectionViewLayout as TransitionLayout
            let progress = transitionPorgress
            transitionLayout.transitionProgress = progress >= 1.0 ? 1.0 : progress + 0.05
            return
        case .Cancelled, .Ended:
            collectionView.finishInteractiveTransition()
            return
          
        default:
            return
        }
    }
}

extension ViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    // The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        return collectionView.dequeueReusableCellWithReuseIdentifier("Cell", forIndexPath: indexPath) as PageCell
    }
    
    func collectionView(collectionView: UICollectionView, transitionLayoutForOldLayout fromLayout: UICollectionViewLayout, newLayout toLayout: UICollectionViewLayout) -> UICollectionViewTransitionLayout! {
        
        return TransitionLayout(currentLayout: fromLayout, nextLayout:toLayout)
    }
}

