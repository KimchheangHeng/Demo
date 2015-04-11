//
//  ViewModelProtocol.swift
//  EditResponder
//
//  Created by 星宇陈 on 15/4/11.
//  Copyright (c) 2015年 BoTai Technology. All rights reserved.
//

import Foundation
import UIKit

protocol ComponentViewModelAttributes {
    var frame: Dynamic<CGRect> { get }
}

protocol MaskViewModelAttributes: ComponentViewModelAttributes {
    var compoFrame: Dynamic<CGRect>{ get }
}
