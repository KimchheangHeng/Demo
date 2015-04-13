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
                self.transform = CGAffineTransformScale(self.transform, $0, $0)
            }
            
            viewModel.rotation.bindAndFire {
                [unowned self] in
                self.transform = CGAffineTransformRotate(self.transform, $0)
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
}
