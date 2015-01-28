//
//  ViewController.swift
//  TextKit
//
//  Created by Emiaostein on 15/1/26.
//  Copyright (c) 2015年 Emiaostein. All rights reserved.
//

import UIKit


class ViewController: UIViewController {
    
    var mainTextView: UITextView!
    
    let textStorage: SyntaxHighlightTextStorage! = SyntaxHighlightTextStorage()
    
    let note: String! = "Shop List\n\n1. Still *reading* ? OK, *from* the margin.\n\n2. Section breaks (the visual breaks between the scenes in your story) are indicated as above using a centered number sign.. \n\n3. A 25 *line* page, *Four hundred pages* is about a hundred thousand words.\n"
    
    let timeIndicatorView: TimeIndicatorView! = TimeIndicatorView(date: NSDate(timeIntervalSinceNow: 0))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setup()
    }
    
    override func viewDidLayoutSubviews() {
        
        self.updateTimeIndicatorFrame()
    }
    
    func setup() {
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "preferredContentSizeDidChanged:", name: UIContentSizeCategoryDidChangeNotification, object: nil)
        
        self.createTextView()
        
        self.view.addSubview(timeIndicatorView)
        
        self.updateFont()
    }
    
    
}

// MARK: Public Method
extension ViewController {
    
    
    
}

// MARK: UITextView Delegate
extension ViewController : UITextViewDelegate {
    
}

// MARK: Private Method
extension ViewController {
    
    private func createTextView() {
        
        let textViewRect = self.view.bounds
        
        // 1. Create the text storage that back the editor
        let attris = [NSFontAttributeName : UIFont.preferredFontForTextStyle(UIFontTextStyleBody)]
        let attrString = NSAttributedString(string: note, attributes: attris)
        textStorage .appendAttributedString(attrString)
        
        // 2. Create layoutManager
        let layoutManager = NSLayoutManager()
        
        // 3. Create a text container
        let container = NSTextContainer(size: CGSize(width: textViewRect.width, height: CGFloat.max))
        layoutManager.addTextContainer(container)
        textStorage.addLayoutManager(layoutManager)
        
        // 4. Create textView
        mainTextView = UITextView(frame: textViewRect, textContainer: container);
        mainTextView.delegate = self
        self.view .addSubview(mainTextView)
    }
}


// MARK: TimeIdicatorView
extension ViewController {
    
    private func updateTimeIndicatorFrame() {
        
        mainTextView.frame = self.view.bounds
        
        timeIndicatorView.updateSize()
        
        timeIndicatorView.frame = CGRectOffset(timeIndicatorView.frame,
            CGRectGetWidth(self.view.frame) - CGRectGetWidth(timeIndicatorView.frame),
            0.0)
        
        let exclusionPath = timeIndicatorView.curvePathWithOrigin(timeIndicatorView.center)
        mainTextView.textContainer.exclusionPaths = [exclusionPath]
        
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
        let attrString = NSAttributedString(string: self.mainTextView.text, attributes: dic)
        
        
        self.mainTextView.attributedText = attrString
        
        self.updateTimeIndicatorFrame()
    }
    
}

