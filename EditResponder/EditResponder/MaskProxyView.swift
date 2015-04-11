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
            viewModel.frame.bindAndFire {
                [unowned self] in
                println($0)
                self.frame = $0
                
            }
            viewModel.compoFrame.bindAndFire {
                [unowned self] in
                self.viewModel.relateComponentViewModel.frame.value = $0
            }
        }
    }
    
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
        drawCanvas1(frame: activeRegion[0] as CGRect)
    }
    
    func pan(sender: UIPanGestureRecognizer) {
        
        let transition = sender.translationInView(self)
        let location = sender.locationInView(self)
        
        if CGRectContainsPoint(scaleRegion, location) {
            
            viewModel.frame.value.size.width += transition.x
            viewModel.frame.value.size.height += transition.y
            viewModel.compoFrame.value.size.width += transition.x
            viewModel.compoFrame.value.size.height += transition.y
            
            let width = viewModel.frame.value.size.width
            let height = viewModel.frame.value.size.height
            let comWidth = width - 15.0
            let comHeight = height - 15.0
            
            viewModel.frame.value.size.width = width <= 60.0 ? 60.0 : width
            viewModel.frame.value.size.height = height <= 60.0 ? 60.0 : height
            viewModel.compoFrame.value.size.width = width <= 60.0 ? 45.0 : comWidth
            viewModel.compoFrame.value.size.height = height <= 60.0 ? 45.0 : comHeight
            
            setNeedsDisplay()
        } else {
            viewModel.frame.value.origin.x += transition.x
            viewModel.frame.value.origin.y += transition.y
            viewModel.compoFrame.value.origin.x += transition.x
            viewModel.compoFrame.value.origin.y += transition.y
        }
        
        sender.setTranslation(CGPointZero, inView: self)
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
        self.addGestureRecognizer(pan)
        pan.delegate = self;
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
