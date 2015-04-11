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
            viewModel.frame.bindAndFire {
                [unowned self] in
                self.frame = $0
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
