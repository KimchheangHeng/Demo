//
//  ComponentView.swift
//  EditResponder
//
//  Created by 星宇陈 on 15/4/11.
//  Copyright (c) 2015年 BoTai Technology. All rights reserved.
//

import UIKit

class ComponentView: UIView {

    var viewModel: ComponentViewModel! {
        didSet {
            viewModel.center.bindAndFire {
                [unowned self] in
                self.center = $0
            }
            
            viewModel.size.bindAndFire {
                [unowned self] in
                self.bounds.size = $0
            }
            
            viewModel.scale.bindAndFire {
                [unowned self] in
                
                let rotation = self.viewModel.rotation.value
                self.scaleAndRotation($0, rotation: rotation)
                
            }
            
            viewModel.rotation.bindAndFire {
                [unowned self] in
                let scale = self.viewModel.scale.value
                self.scaleAndRotation(scale, rotation: $0)
            }
        }
    }
    
    init(viewModel: ComponentViewModel) {
        super.init(frame: CGRectZero)
        setupBy(viewModel)
    }

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setupBy(viewModel: ComponentViewModel) {
        self.viewModel = viewModel
        self.backgroundColor = viewModel.model.color

    }
    
    private func scaleAndRotation(scale: CGFloat, rotation: CGFloat) {
        
        let scaleTransform = CGAffineTransformMakeScale(scale, scale)
        let rotationTransform = CGAffineTransformMakeRotation(rotation)
        let transform = CGAffineTransformConcat(scaleTransform, rotationTransform)
        self.transform = transform
        
    }
}
