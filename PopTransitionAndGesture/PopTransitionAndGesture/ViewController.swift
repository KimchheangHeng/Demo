//
//  ViewController.swift
//  PopTransitionAndGesture
//
//  Created by Emiaostein on 4/28/15.
//  Copyright (c) 2015 BoTai Technology. All rights reserved.
//

import UIKit


class ViewController: UIViewController {

    @IBOutlet weak var contentView: UIView!
    var originCenter = CGPointZero
    var backAnimation: POPSpringAnimation?
    var progress: Float = 0.0 {
        
        didSet {
            contentView.frame.origin.y = POPTransition(progress, startValue: 400, endValue: 100)
        }
    }
    
    var swi: Bool = false {
        
        didSet {
            togglePopAnimation(swi)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewDidAppear(animated: Bool) {
        
        originCenter = contentView.center
    }
    
    func POPTransition(progress: Float, startValue: Float, endValue: Float) -> CGFloat {
    
        return CGFloat(startValue + (progress * (endValue - startValue)))
    }
    
    @IBAction func TapAction(sender: UITapGestureRecognizer) {
        
        swi = !swi
        
    }
    
    @IBAction func PanAction(sender: UIPanGestureRecognizer) {
        
        let transition = sender.translationInView(view)
        switch sender.state {
        case .Began:
            
            contentView.layer.position.x += transition.x
            contentView.layer.position.y += transition.y
            
        case .Changed:
            contentView.layer.position.x += transition.x
            contentView.layer.position.y += transition.y
            
        case .Cancelled, .Ended:
            let ani = POPSpringAnimation()
            ani.property = POPAnimatableProperty.propertyWithName(kPOPLayerPosition) as! POPAnimatableProperty
            ani.springBounciness = 10
            ani.toValue = NSValue(CGPoint: originCenter)
            contentView.layer.pop_addAnimation(backAnimation, forKey: "position")
            ani.removedOnCompletion = true
            backAnimation = ani
            
        default:
            return
        }
        sender.setTranslation(CGPointZero, inView: view)
    }
}

extension ViewController {
    
    private func togglePopAnimation(on: Bool) {
        var animation: POPSpringAnimation! = self.pop_animationForKey("Pop") as! POPSpringAnimation!
        if animation == nil {
            animation = POPSpringAnimation()
            animation.springBounciness = 10
            animation.springSpeed = 10
            
            typealias PopInitializer = ((POPMutableAnimatableProperty!) -> Void)!
            
            let ainitializer: PopInitializer = {
                (prop: POPMutableAnimatableProperty!) -> Void in
                prop.readBlock = {
                   (obj: AnyObject!, values: UnsafeMutablePointer<CGFloat>) in
                    if let controller = obj as? ViewController {
                        values[0] = CGFloat(controller.progress)
                    }
                    
                }
                
                prop.writeBlock = {
                    (obj: AnyObject!, values: UnsafePointer<CGFloat>) -> Void in
                    if let controller = obj as? ViewController {
                        controller.progress = Float(values[0])
                    }
                }
                prop.threshold = 0.001
            }
            animation.property = POPAnimatableProperty.propertyWithName("progress", initializer: ainitializer) as! POPAnimatableProperty
            self.pop_addAnimation(animation, forKey: "Pop")
            
        }
        animation.toValue = on ? 1.0 : 0.0
    }
}










