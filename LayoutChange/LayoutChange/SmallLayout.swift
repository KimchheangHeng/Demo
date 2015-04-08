//
//  SmallLayout.swift
//  LayoutChange
//
//  Created by 星宇陈 on 15/4/7.
//  Copyright (c) 2015年 BoTai Technology. All rights reserved.
//

import UIKit

class SmallLayout: UICollectionViewFlowLayout {
    
    override init() {
        super.init()
        setup()
    }

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    private func setup() {
        
        itemSize = LayoutSpec.layoutConstants.smallLayout.itemSize
        sectionInset = LayoutSpec.layoutConstants.smallLayout.sectionInsets
        scrollDirection = .Horizontal
    }
    
    override func shouldInvalidateLayoutForBoundsChange(newBounds: CGRect) -> Bool {
        return true
    }
}
