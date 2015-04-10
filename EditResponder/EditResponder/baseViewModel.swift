//
//  baseViewModel.swift
//  EditResponder
//
//  Created by Emiaostein on 15/4/10.
//  Copyright (c) 2015年 BoTai Technology. All rights reserved.
//

import UIKit

class baseViewModel: NSObject {
   
}

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
