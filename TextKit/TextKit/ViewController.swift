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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "preferredContentSizeDidChanged:", name: UIContentSizeCategoryDidChangeNotification, object: nil)
        
        self.updateFont()
    }
}

// MARK: textKit-Notifiction
extension ViewController {
    
    func preferredContentSizeDidChanged(notifiction: NSNotification) {
        
        self.updateFont()
        
    }
    
    func updateFont() {
        
        self.textView.font = UIFont.preferredFontForTextStyle(UIFontTextStyleBody)
    }
    
}

