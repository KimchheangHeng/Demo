//
//  TransitionLayout.swift
//  LayoutChange
//
//  Created by 星宇陈 on 15/4/7.
//  Copyright (c) 2015年 BoTai Technology. All rights reserved.
//

import UIKit

class TransitionLayout: UICollectionViewTransitionLayout {
   
    override func shouldInvalidateLayoutForBoundsChange(newBounds: CGRect) -> Bool {
        return true
    }
}
