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
    let center: Dynamic<CGPoint>
    let size: Dynamic<CGSize>
    let scale: Dynamic<CGFloat>
    let rotation: Dynamic<CGFloat>
    
    init(model: ComponentModel) {
        self.model = model
        center = Dynamic(model.center)
        size = Dynamic(model.size)
        scale = Dynamic(model.scale)
        rotation = Dynamic(model.rotation)
    }
}

class MaskViewModel: MaskViewModelAttributes {
    let relateComponentViewModel: ComponentViewModel
    let center: Dynamic<CGPoint>
    let size: Dynamic<CGSize>
    let scale: Dynamic<CGFloat>
    let rotation: Dynamic<CGFloat>
    
    init(viewModel: ComponentViewModel) {
        relateComponentViewModel = viewModel
        center = Dynamic(viewModel.center.value)
        size = Dynamic(viewModel.size.value)
        scale = Dynamic(viewModel.scale.value)
        rotation = Dynamic(viewModel.rotation.value)
    }
}
