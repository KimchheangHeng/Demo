//
//  AppDelegate.h
//  collectionViewLayout
//
//  Created by 星宇陈 on 14/11/20.
//  Copyright (c) 2014年 Emiaostein. All rights reserved.
//

#import "LineLayout.h"


#define ITEM_SIZE 110.0

@implementation LineLayout

#define ACTIVE_DISTANCE 768
#define ZOOM_FACTOR 0.3

-(id)init
{
    self = [super init];
    if (self) {
        self.itemSize = CGSizeMake(ITEM_SIZE*1.5, ITEM_SIZE*2.5);
        self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        self.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
        self.minimumLineSpacing = 50.0;
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        self.itemSize = CGSizeMake(ITEM_SIZE*1.5, ITEM_SIZE*2.5);
        self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        self.sectionInset = UIEdgeInsetsMake(40, 160, 50, 160);
        self.minimumLineSpacing = 50.0;
    }
    return self;
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)oldBounds
{
    return YES;
}

-(NSArray*)layoutAttributesForElementsInRect:(CGRect)rect
{
    
    NSArray* array = [super layoutAttributesForElementsInRect:rect];
    CGRect visibleRect;
    visibleRect.origin = self.collectionView.contentOffset;
    visibleRect.size = self.collectionView.bounds.size;
    
    for (UICollectionViewLayoutAttributes* attributes in array) {
        if (CGRectIntersectsRect(attributes.frame, rect)) {
            CGFloat distance = CGRectGetMidX(visibleRect) - attributes.center.x; //vector
            
            CGFloat normalizedDistance = distance / ACTIVE_DISTANCE;
            if (ABS(distance) < ACTIVE_DISTANCE) {
//                CGFloat zoom = 1 + ZOOM_FACTOR*(1 - ABS(normalizedDistance));
//                attributes.transform3D = CATransform3DMakeScale(zoom, zoom, 1.0);
//                attributes.transform3D = CATransform3DRotate(attributes.transform3D, zoom, 0, 0, 1.0);
//                attributes.zIndex = 1;
                
                CGFloat rotation = 0 - (M_1_PI * 120 / 180.0)*(ABS(normalizedDistance));
                CGFloat dis =(ABS(normalizedDistance))*80;
                
                NSInteger sign = distance > 0 ? 1 : -1;
                attributes.transform3D = CATransform3DScale(attributes.transform3D, 1.3, 1.3, 1);
                attributes.transform3D = CATransform3DRotate(attributes.transform3D, rotation * sign, 0, 0, 1);

                attributes.transform3D = CATransform3DTranslate(attributes.transform3D, 0, +dis, -1.0 *ABS(normalizedDistance));

            } else {
                
                attributes.transform3D = CATransform3DRotate(attributes.transform3D, -(120*M_1_PI/ 180.0) * ABS(distance)/distance, 0, 0, 1.0);
                attributes.transform3D = CATransform3DScale(attributes.transform3D, 1, 1, 1);
                attributes.transform3D = CATransform3DTranslate(attributes.transform3D, 0, +60, -1.0 );
            }

            
        }
    }
    return array;
}


- (CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity
{
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
}

@end