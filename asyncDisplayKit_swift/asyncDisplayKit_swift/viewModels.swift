//
//  viewModels.swift
//  AsyncDisplayKitInSwift
//
//  Created by 星宇陈 on 4/15/15.
//  Copyright (c) 2015 Emiaostein. All rights reserved.
//

import UIKit

class viewModel: NSObject {
   
}

class itemViewModel: viewModel {
    var center = CGPointZero
    var size = CGSizeZero
    var rotation: CGFloat = 0
    
    init(aCenter: CGPoint, aSize: CGSize, aRotation: CGFloat) {
        self.center = aCenter
        self.size = aSize
        self.rotation = aRotation
    }
}

class cellViewModel: viewModel {
    var itemVMs: [itemViewModel] = []
    override init() {
        itemVMs = dataCreator.createItemViewModels(30)
    }
}

class dataCreator {
    
    class func createCellViewModels(max: UInt) -> [cellViewModel] {
        
        var array: [cellViewModel] = []
        for _ in 1...max {
            let cellVM = cellViewModel()
            array.append(cellVM)
        }
        return array
    }
    
    class func createItemViewModels(max: UInt) -> [itemViewModel] {
        var array: [itemViewModel] = []
        
        for i in 1...max {
            let x = CGFloat(arc4random() % 200 + 100)
            let y = CGFloat(arc4random() % 300 + 50)
            let w = CGFloat(arc4random() % 200 + 50)
            let h = CGFloat(arc4random() % 300 + 50)
            let center = CGPointMake(x, y)
            let size = CGSizeMake(w, h)
            let rotation = x % 90
            let itemVM = itemViewModel(aCenter: center, aSize: size, aRotation: rotation)
            array.append(itemVM)
        }
        
        return array
    }
}
