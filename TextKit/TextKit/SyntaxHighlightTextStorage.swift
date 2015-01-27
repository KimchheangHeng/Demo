//
//  SyntaxHighlightTextStorage.swift
//  TextKit
//
//  Created by Emiaostein on 15/1/27.
//  Copyright (c) 2015年 Emiaostein. All rights reserved.
//

import UIKit

class SyntaxHighlightTextStorage: NSTextStorage {
   
    var backingStore: NSMutableAttributedString! = NSMutableAttributedString()
    
    
}

// MARK: Public Method 
extension SyntaxHighlightTextStorage {
    
    internal func string() -> String {
        
        return backingStore.string
    }
}

// MARK: override
extension SyntaxHighlightTextStorage {
    
    override func attributesAtIndex(location: Int, effectiveRange range: NSRangePointer) -> [NSObject : AnyObject] {
        
        return backingStore.attributesAtIndex(location, effectiveRange: range)
    }

    override func replaceCharactersInRange(range: NSRange, withString str: String) {
        
//        println("range: \(range), string: \(str)")
        
        self.beginEditing()
        backingStore.replaceCharactersInRange(range, withString: str)
        self.edited(NSTextStorageEditActions.EditedAttributes | NSTextStorageEditActions.EditedCharacters, range: range, changeInLength: countElements(str) - range.length)
        self.endEditing()
    }
    
    override func setAttributes(attrs: [NSObject : AnyObject]?, range: NSRange) {
        
//        println("setAttributes: \(attrs), range: \(range)")
        
        self.beginEditing()
        backingStore.setAttributes(attrs, range: range)
        self.edited(
            NSTextStorageEditActions.EditedAttributes,
            range: range,
            changeInLength: 0)
        self.endEditing()
    }
    
    override func processEditing() {
        
        self.performReplacementsFor(self.editedRange)
        super.processEditing()
    }
    
    private func performReplacementsFor(ChangedRange: NSRange) {
        
//        let extendeRange = NSUnionRange(ChangedRange, <#range2: NSRange#>)
    }
}
