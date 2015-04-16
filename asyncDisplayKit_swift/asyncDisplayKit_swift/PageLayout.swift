//
//  PageLayout.swift
//  asyncDisplayKit_swift
//
//  Created by 星宇陈 on 4/16/15.
//  Copyright (c) 2015 Emiaostein. All rights reserved.
//

import UIKit

class PageLayout: UICollectionViewFlowLayout {
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.itemSize = CGSizeMake(250, 400)
        self.scrollDirection = UICollectionViewScrollDirection.Horizontal
    }
   
    override func targetContentOffsetForProposedContentOffset(proposedContentOffset: CGPoint, withScrollingVelocity velocity: CGPoint) -> CGPoint {
        
        var offsetAdjustment: CGFloat = CGFloat(MAXFLOAT)
        let horizontalCenter = proposedContentOffset.x + (CGRectGetWidth(collectionView!.bounds) / 2.0);
        let targetRect = CGRectMake(proposedContentOffset.x, 0.0, collectionView!.bounds.size.width, collectionView!.bounds.size.height);
        let array = super.layoutAttributesForElementsInRect(targetRect)
        for layoutattributes in array as! [UICollectionViewLayoutAttributes] {
            let itemHorizontalCenter = layoutattributes.center.x
            if abs(itemHorizontalCenter - horizontalCenter) < abs(offsetAdjustment) {
                offsetAdjustment = itemHorizontalCenter - horizontalCenter
            }
        }
        return CGPointMake(proposedContentOffset.x + offsetAdjustment, proposedContentOffset.y)
    }
}

/*

CGFloat offsetAdjustment = MAXFLOAT;
CGFloat horizontalCenter = proposedContentOffset.x + (CGRectGetWidth(self.collectionView.bounds) / 2.0);

CGRect targetRect = CGRectMake(proposedContentOffset.x, 0.0, self.collectionView.bounds.size.width, self.collectionView.bounds.size.height);
NSArray* array = [super layoutAttributesForElementsInRect:targetRect];

for (UICollectionViewLayoutAttributes* layoutAttributes in array) {
CGFloat itemHorizontalCenter = layoutAttributes.center.x;
if (ABS(itemHorizontalCenter - horizontalCenter) < ABS(offsetAdjustment)) {
offsetAdjustment = itemHorizontalCenter - horizontalCenter;
}
}
return CGPointMake(proposedContentOffset.x + offsetAdjustment, proposedContentOffset.y);

*/
