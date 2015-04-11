//
//  ViewController.swift
//  EditResponder
//
//  Created by Emiaostein on 15/4/10.
//  Copyright (c) 2015年 BoTai Technology. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var aComponentViewModels: [ComponentViewModel] {
        let models = DataCreator.componentModels()
        var viewModels: [ComponentViewModel] = []
        
        for model in models {
            let viewModel = ComponentViewModel(model: model)
            viewModels.append(viewModel)
        }
        
        return viewModels
    }
    
    var componentViewModels: [ComponentViewModel] = []
    var maskView: MaskProxyView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        componentViewModels = aComponentViewModels
        setupComponents(componentViewModels)
    }
}

// MARK: - Private Func 
extension ViewController {
    
    private func setupComponents(viewModels: [ComponentViewModel]) {
        for viewModel in viewModels {
            let componentView = ComponentView(viewModel: viewModel)
            view.addSubview(componentView)
        }
    }
    
    private func refresh() {
        
        for subView in view.subviews {
            if subView is ComponentView {
                subView.removeFromSuperview()
            }
        }
        componentViewModels.removeAll(keepCapacity: false)
        componentViewModels = aComponentViewModels
        setupComponents(componentViewModels)
        removeMaskView()
    }
    
    private func activeMaskViewBy(componentViewModel: ComponentViewModel) {
        removeMaskView()
        setupMaskViewBy(componentViewModel)
    }
    
    private func setupMaskViewBy(componentViewModel: ComponentViewModel) {
        
        let maskViewModel = MaskViewModel(viewModel: componentViewModel)
        maskView = MaskProxyView(viewModel: maskViewModel)
        if let theMaskView = maskView {
            view.addSubview(theMaskView)
        }
    }
    
    private func removeMaskView() {
        
        if let theMaskView = maskView {
            theMaskView.removeFromSuperview()
            maskView = nil
        }
    }
}

// IBAction
extension ViewController {
    
    
    @IBAction func Refresh(sender: UIButton) {
        refresh()
    }
    
    @IBAction func gobalPanAction(sender: UIPanGestureRecognizer) {
        
        switch sender.state {
        case .Began:
            let location = sender.locationInView(self.view)
            
            let reverseCom = componentViewModels.reverse()
            var index = 0
            for viewModel in reverseCom {
                index++
                let center = viewModel.center.value
                let size = viewModel.size.value
                let rect = CGRectMake(center.x - size.width / 2.0, center.y - size.height / 2.0, size.width, size.height)
                if CGRectContainsPoint(rect, location) {
                    activeMaskViewBy(viewModel)

                    return
                }
            }
            removeMaskView()
            
        case .Changed:
            if let aMaskView = maskView {
                aMaskView.pan(sender)
            }
            
        default:
            return
        }
    }
    
    @IBAction func TapAction(sender: UITapGestureRecognizer) {
        //        println("TapAction");
        let location = sender.locationInView(self.view)
        
        let reverseCom = componentViewModels.reverse()
        
        println("com = " + "\(componentViewModels.last!.rotation.value)")
        
        var index = 0
        for viewModel in reverseCom {
            index++
            let center = viewModel.center.value
            let size = viewModel.size.value
            let rect = CGRectMake(center.x - size.width / 2.0, center.y - size.height / 2.0, size.width, size.height)
            if CGRectContainsPoint(rect, location) {
                activeMaskViewBy(viewModel)

                return
            }
        }
        removeMaskView()
        
    }
}


