//
//  ViewModels.swift
//  EditResponder
//
//  Created by 星宇陈 on 15/4/11.
//  Copyright (c) 2015年 BoTai Technology. All rights reserved.
//

import UIKit

class Dynamic<T> {
    
    typealias Listener = T -> Void
    var listener: Listener?
    var value: T {
        didSet {
            listener?(value)
        }
    }
    
    init(_ v: T) {
        value = v
    }
    
    func bind(listener: Listener?) {
        self.listener = listener
    }
    
    func bindAndFire(listener: Listener?) {
        self.listener = listener
        listener?(value)
    }
}

class ComponentViewModel: ComponentViewModelAttributes {
    let model: ComponentModel
    let frame: Dynamic<CGRect>
    
    init(model: ComponentModel) {
        self.model = model
        frame = Dynamic(model.frame)
    }
}

class MaskViewModel: MaskViewModelAttributes {
    let relateComponentViewModel: ComponentViewModel
    let frame: Dynamic<CGRect>
    let compoFrame: Dynamic<CGRect>
    
    init(viewModel: ComponentViewModel) {
        relateComponentViewModel = viewModel
        let comFrame = viewModel.frame.value
        frame = Dynamic(CGRectMake(comFrame.origin.x, comFrame.origin.y, comFrame.size.width + 15, comFrame.size.height + 15))
        compoFrame = Dynamic(viewModel.frame.value)
    }
}
