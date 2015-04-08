//
//  TransitionLayout.swift
//  LayoutChange
//
//  Created by 星宇陈 on 15/4/7.
//  Copyright (c) 2015年 BoTai Technology. All rights reserved.
//

import UIKit

class TransitionLayout: UICollectionViewTransitionLayout {
  let scale = LayoutSpec.layoutConstants.smallLayout.shrinkScale
   
    override func shouldInvalidateLayoutForBoundsChange(newBounds: CGRect) -> Bool {
        return true
    }
  
  override func layoutAttributesForElementsInRect(rect: CGRect) -> [AnyObject]? {
    
    let layoutAttributes = super.layoutAttributesForElementsInRect(rect) as [UICollectionViewLayoutAttributes]
    if let visualCells = collectionView?.visibleCells() as? [PageCell] {
      
      for pagecell in visualCells {
        if let containerView = pagecell.contentView.subviews[0] as? UIView {
          
          if let from = currentLayout as? UICollectionViewFlowLayout {
            let itemSize = from.itemSize
            
            let ascale = PopTransition(transitionProgress, 1, CGFloat(scale))
            containerView.transform = CGAffineTransformMakeScale(ascale, ascale)
            containerView.center = containerView.superview!.center
          }
          
        }
      }
      
      
    }

    
    return layoutAttributes
  }
}
