//
//  ViewController.swift
//  TextKit
//
//  Created by Emiaostein on 15/1/26.
//  Copyright (c) 2015年 Emiaostein. All rights reserved.
//

import UIKit


class ViewController: UIViewController {
    
    @IBOutlet weak var textView: UITextView!
    
    let timeIndicatorView: TimeIndicatorView! = TimeIndicatorView(date: NSDate(timeIntervalSinceNow: 0))
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "preferredContentSizeDidChanged:", name: UIContentSizeCategoryDidChangeNotification, object: nil)
        
        self.view.addSubview(timeIndicatorView)
        
        self.updateFont()
    }
    
    override func viewDidLayoutSubviews() {
        
        self.updateTimeIndicatorFrame()
    }
    
}

// MARK: Public Method
extension ViewController {
    
    
}

// MARK: TimeIdicatorView
extension ViewController {
    
    private func updateTimeIndicatorFrame() {
        
        timeIndicatorView.updateSize()
        
        timeIndicatorView.frame = CGRectOffset(timeIndicatorView.frame,
            CGRectGetWidth(self.view.frame) - CGRectGetWidth(timeIndicatorView.frame),
            0.0)
        
        let exclusionPath = timeIndicatorView.curvePathWithOrigin(timeIndicatorView.center)
        textView.textContainer.exclusionPaths = [exclusionPath]
        
    }
}

// MARK: textKit-Notifiction
extension ViewController {
    
    private func preferredContentSizeDidChanged(notifiction: NSNotification) {
        
        self.updateFont()
        self.updateTimeIndicatorFrame()
        
    }
    
    private func updateFont() {
        
        let font = UIFont.preferredFontForTextStyle(UIFontTextStyleBody)
        let color = UIColor.blueColor()
        let dic = [
            NSForegroundColorAttributeName : color,
            NSFontAttributeName : font,
            NSTextEffectAttributeName : NSTextEffectLetterpressStyle]
        let attrString = NSAttributedString(string: self.textView.text, attributes: dic)
        
        
        self.textView.attributedText = attrString
        
        self.updateTimeIndicatorFrame()
    }
    
}

