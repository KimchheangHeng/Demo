//
//  MaskProxyView.swift
//  EditResponder
//
//  Created by Emiaostein on 15/4/10.
//  Copyright (c) 2015年 BoTai Technology. All rights reserved.
//

import UIKit

class MaskProxyView: UIView {
    
    var viewModel: MaskViewModel! {
        
        didSet {
            viewModel.center.bindAndFire {
                [unowned self] in
                self.center = $0
                self.viewModel.relateComponentViewModel.center.value = $0
                
            }
            viewModel.size.bindAndFire {
                [unowned self] in
                self.bounds.size = $0
                self.viewModel.relateComponentViewModel.size.value = $0
            }
            
            viewModel.scale.bindAndFire {
                [unowned self] in
                let rotation = self.viewModel.rotation.value
                self.scaleAndRotation($0, rotation: rotation)
                self.viewModel.relateComponentViewModel.scale.value = $0
            }
            
            viewModel.rotation.bindAndFire {
                [unowned self] in
                let scale = self.viewModel.scale.value
                self.scaleAndRotation(scale, rotation: $0)
                self.viewModel.relateComponentViewModel.rotation.value = $0
            }
        }
    }
    
    var resize: Bool = false
    var beganRotaton: CGFloat = 0
    var beganScale: CGFloat = 0
    
    var activeRegion: [CGRect] {
        
        let rect = CGRectOffset(bounds, 0, 0)
        return [rect]
    }
    
    var scaleRegion: CGRect {
        
        let scale = viewModel.scale.value
        let region = CGRectMake(0, 0, CGRectGetWidth(bounds) * scale, CGRectGetHeight(bounds) * scale)
        return CGRectOffset(region, region.width - 100, region.height - 100)
    }
    
    init(viewModel: MaskViewModel) {
        super.init(frame: CGRectZero)
        setupViewModelBy(viewModel)
        setupGesture()
    }

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    override func drawRect(rect: CGRect) {
        
        super.drawRect(rect)
//        self.layer.borderWidth = 1
//        self.layer.borderColor = UIColor.redColor().CGColor
//        self.backgroundColor = UIColor.blueColor()
//        drawCanvas1(frame: activeRegion[0] as CGRect)
    }
    
    func pan(sender: UIPanGestureRecognizer) {
        
        let transition = sender.translationInView(self.superview!)
        let location = sender.locationInView(self)
        println("location = \(location)")
        
        switch sender.state {
            
        case .Began:
            resize = CGRectContainsPoint(scaleRegion, location)
            
        case .Changed:
            if resize {
//                self.layer.anchorPoint = CGPointZero
                let atransition = sender.translationInView(self)
                let rotation = viewModel.rotation.value
                viewModel.size.value.width += atransition.x
                viewModel.size.value.height += atransition.y
                viewModel.center.value.x += transition.x / 2.0
                viewModel.center.value.y += transition.y / 2.0
                
                setNeedsDisplay()
            } else {
                let rotation = viewModel.rotation.value
                viewModel.center.value.x += transition.x
                viewModel.center.value.y += transition.y
            }
            
//        case .Cancelled, .Ended:
//            self.layer.anchorPoint = CGPointMake(0.5, 0.5)
            
        default:
            return
        }
        sender.setTranslation(CGPointZero, inView: self.superview!)
    }
    
    func rotation(sender: UIRotationGestureRecognizer) {
        
        switch sender.state {
        case .Began:
            beganRotaton = viewModel.rotation.value
        case .Changed:
            viewModel.rotation.value = beganRotaton + sender.rotation
        default:
            return
        }
    }
    
    func PinchAction(sender: UIPinchGestureRecognizer) {
        
        switch sender.state {
        case .Began:
            sender.scale = viewModel.scale.value
        case .Changed:
            viewModel.scale.value = sender.scale
        default:
            return
        }
    }
}

// MASK - Private method
extension MaskProxyView {
    
    private func scaleAndRotation(scale: CGFloat, rotation: CGFloat) {
        
        let scaleTransform = CGAffineTransformMakeScale(scale, scale)
        let rotationTransform = CGAffineTransformMakeRotation(rotation)
        let transform = CGAffineTransformConcat(scaleTransform, rotationTransform)
        self.transform = transform
        
    }
    
    private func setupViewModelBy(viewModel: MaskViewModel) {
        self.viewModel = viewModel
        self.backgroundColor = UIColor.blueColor()
//        setNeedsDisplay()
    }
    
    private func setupGesture() {
        self.backgroundColor = UIColor.clearColor()
        let pan = UIPanGestureRecognizer(target: self, action: "PanAction:")
        let rotation = UIRotationGestureRecognizer(target: self, action: "RotationAction:")
        let pinch = UIPinchGestureRecognizer(target: self, action: "PinchAction:")
        rotation.delegate = self
        pinch.delegate = self
        self.addGestureRecognizer(pan)
        self.addGestureRecognizer(rotation)
//        self.addGestureRecognizer(pinch)
    }
    
    private func drawCanvas1(#frame: CGRect) {
        //// General Declarations
        let context = UIGraphicsGetCurrentContext()
        
        
        //// Subframes
        let frame2 = CGRectMake(frame.minX + floor((frame.width - 15) * 0.00000 + 0.5), frame.minY + floor((frame.height - 15) * 0.00000 + 0.5), frame.width - 15 - floor((frame.width - 15) * 0.00000 + 0.5), frame.height - 15 - floor((frame.height - 15) * 0.00000 + 0.5))
        
        
        //// Rectangle Drawing
        let rectanglePath = UIBezierPath(rect: CGRectMake(frame2.minX + 1, frame2.minY + 1, floor((frame2.width - 1) * 1.00000 + 0.5), floor((frame2.height - 1) * 1.00000 + 0.5)))
        UIColor.redColor().setStroke()
        rectanglePath.lineWidth = 1
        CGContextSaveGState(context)
        CGContextSetLineDash(context, 0, [2, 2], 2)
        rectanglePath.stroke()
        CGContextRestoreGState(context)
        
        //// Oval Drawing
        var ovalPath = UIBezierPath(ovalInRect: CGRectMake(frame2.minX + frame2.width - 16, frame2.minY + frame2.height - 16, 30, 30))
        UIColor.whiteColor().setFill()
        ovalPath.fill()
        UIColor.redColor().setStroke()
        ovalPath.lineWidth = 0.5
        ovalPath.stroke()
    }
}

// MASK - Action
extension MaskProxyView {
    
    func PanAction(sender: UIPanGestureRecognizer) {
        pan(sender)
    }
    
    func RotationAction(sender: UIRotationGestureRecognizer) {
        rotation(sender)
    }
}

extension MaskProxyView: UIGestureRecognizerDelegate {
    
    override func pointInside(point: CGPoint, withEvent event: UIEvent?) -> Bool {
        
        for rect in activeRegion {
            if CGRectContainsPoint(rect, point) {
                return true
            }
        }
        return false
    }
    
    func gestureRecognizer(gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWithGestureRecognizer otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    
    
    
    override func gestureRecognizerShouldBegin(gestureRecognizer: UIGestureRecognizer) -> Bool {
        
        return true
    }
}
