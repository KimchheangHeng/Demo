//
//  PageCell.swift
//  LayoutChange
//
//  Created by 星宇陈 on 15/4/8.
//  Copyright (c) 2015年 BoTai Technology. All rights reserved.
//

import UIKit

class PageCell: UICollectionViewCell {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        let size = LayoutSpec.layoutConstants.normalLayout.itemSize
        let containerView = UIView(frame: CGRectMake(0, 0, size.width, size.height))
        containerView.backgroundColor = UIColor.lightGrayColor()
        self.contentView.addSubview(containerView)
    }
}
