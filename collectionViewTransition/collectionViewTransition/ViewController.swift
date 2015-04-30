//
//  ViewController.swift
//  collectionViewTransition
//
//  Created by 星宇陈 on 4/30/15.
//  Copyright (c) 2015 botai. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    let otherLayout = UICollectionViewFlowLayout()
    var transitionLayout: UICollectionViewTransitionLayout!
    var transitioning = false
    override func viewDidLoad() {
        super.viewDidLoad()
        
        otherLayout.itemSize = CGSizeMake(200, 200)
    }
    
    @IBAction func PanAction(sender: UIPanGestureRecognizer) {
        
        switch sender.state {
        case .Began:
            if transitioning {
                return
            }
            transitioning = true
          transitionLayout =  collectionView.startInteractiveTransitionToCollectionViewLayout(otherLayout, completion: { (compeleted, finished) -> Void in
            
            if compeleted {
                self.transitioning = false
            }
            
            if finished {
                self.transitioning = false
            }
            })
            return
            
        case .Changed:
            
            if let tran = transitionLayout {
                tran.transitionProgress += 0.01
                collectionView.transform = CGAffineTransformTranslate(collectionView.transform, 0, 3 )
            }
        
        case .Ended:

            if transitioning {
                collectionView.finishInteractiveTransition()
            }
            
            
        default:
            return
        }
    }
}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return 20
    }
    
    // The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("Cell", forIndexPath: indexPath) as! UICollectionViewCell
        
        cell.backgroundColor = UIColor.darkGrayColor()
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, transitionLayoutForOldLayout fromLayout: UICollectionViewLayout, newLayout toLayout: UICollectionViewLayout) -> UICollectionViewTransitionLayout! {
        
        return UICollectionViewTransitionLayout(currentLayout: fromLayout, nextLayout: toLayout)
    }
}

