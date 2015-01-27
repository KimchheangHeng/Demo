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
    
    let note: String! = "Shop List\n\n1. Still reading? OK, let\'s briefly discuss how to format your manuscript. In the standard format, section text is double-spaced, left-aligned, and set in a 12-point Courier font. The first line of a paragraph is indented one half inch, or 5 characters, from the margin.\n\n2. Section breaks (the visual breaks between the scenes in your story) are indicated as above using a centered number sign. To add a section break, place the cursor at the start of an empty paragraph, type the number character (\"#\"), and apply the Section Separator style, or simply center the paragraph. \n\n3. A 25 line page, then, will have an average of 250 words--a nice big round number. Four pages is about a thousand words. Four hundred pages is about a hundred thousand words.\n\n4. Chapters begin on a new page about a third of the way down and start with a centered chapter title, usually in all caps (i.e., all of the letters are capitalized). You can use the Chapter Title style to start a new chapter."
    
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

