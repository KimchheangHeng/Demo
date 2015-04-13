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
                self.transform = CGAffineTransformScale(self.transform, $0, $0)
                self.viewModel.relateComponentViewModel.scale.value = $0
            }
            
            viewModel.rotation.bindAndFire {
                [unowned self] in
                self.transform = CGAffineTransformRotate(self.transform, $0)
                self.viewModel.relateComponentViewModel.rotation.value = $0
            }
        }
    }
    
    var beganRotaton: CGFloat = 0
    var beganScale: CGFloat = 0
    
    var activeRegion: [CGRect] {
        
        let rect = CGRectOffset(bounds, 0, 0)
        return [rect]
    }
    
    var scaleRegion: CGRect {
        
        return CGRectOffset(bounds, CGRectGetWidth(bounds) - 50, CGRectGetHeight(bounds) - 50)
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
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.redColor().CGColor
//        drawCanvas1(frame: activeRegion[0] as CGRect)
    }
    
    func pan(sender: UIPanGestureRecognizer) {
        
        let transition = sender.translationInView(self.superview!)
        let location = sender.locationInView(self)
        
        if CGRectContainsPoint(scaleRegion, location) {
            
            viewModel.size.value.width += transition.x
            viewModel.size.value.height += transition.y
            
            setNeedsDisplay()
        } else {

            viewModel.center.value.x += transition.x
            viewModel.center.value.y += transition.y
        }
        
        sender.setTranslation(CGPointZero, inView: self)
    }
    
    func rotation(sender: UIRotationGestureRecognizer) {
        
        switch sender.state {
        case .Began:
            beganRotaton = viewModel.rotation.value
        case .Changed:
            viewModel.rotation.value = sender.rotation
            sender.rotation = 0
            
        default:
            return
        }
    }
    
    func PinchAction(sender: UIPinchGestureRecognizer) {
        
        switch sender.state {
        case .Began:
//            sender.scale = viewModel.scale.value
            println("\(sender.scale)")
        case .Changed:
            viewModel.scale.value = sender.scale
            sender.scale = 1

        default:
            return
        }
        
        println("\(sender.scale)")
    }
    
}

// MASK - Private method
extension MaskProxyView {
    
    private func setupViewModelBy(viewModel: MaskViewModel) {
        self.viewModel = viewModel
        setNeedsDisplay()
    }
    
    private func setupGesture() {
        self.backgroundColor = UIColor.clearColor()
        let pan = UIPanGestureRecognizer(target: self, action: "PanAction:")
        let rotation = UIRotationGestureRecognizer(target: self, action: "RotationAction:")
        let pinch = UIPinchGestureRecognizer(target: self, action: "PinchAction:")
        self.addGestureRecognizer(pan)
        self.addGestureRecognizer(rotation)
        self.addGestureRecognizer(pinch)
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
    
    override func gestureRecognizerShouldBegin(gestureRecognizer: UIGestureRecognizer) -> Bool {
        
        return true
    }
}
