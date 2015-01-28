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
        
//        let extendedRange = NSUnionRange(ChangedRange, backingStore.string.lineRangeForRange(aRange: Range<String.Index>))
        var extendedRange = NSUnionRange(ChangedRange, NSMakeRange(ChangedRange.location, 0))
        extendedRange = NSUnionRange(ChangedRange, NSMakeRange(ChangedRange.location, 0))
        
        self.applyStylesToRange(extendedRange)
    }
    
    private func applyStylesToRange(searchRange: NSRange) {
    
        // 1. Create some fonts
        let fontDescriptor = UIFontDescriptor.preferredFontDescriptorWithTextStyle(UIFontTextStyleBody)
        let boldFontDescriptor = fontDescriptor.fontDescriptorWithSymbolicTraits(.TraitBold)
        let boldFont = UIFont(descriptor: boldFontDescriptor, size: 0.0)
        let normalFont = UIFont.preferredFontForTextStyle(UIFontTextStyleBody)
        
        // 2. match items surrounded by asterisks
        let regexStr = "(\\*\\w+(\\s\\w+)*\\*)\\s"
        let regex = NSRegularExpression(pattern: regexStr, options: NSRegularExpressionOptions(0), error: nil)
        
        let boldAttribute = [NSFontAttributeName : boldFont]
        let normalAttribute = [NSFontAttributeName : normalFont]
        
        // 3. iterate over each match, making the text bold
        regex?.enumerateMatchesInString(backingStore.string, options: NSMatchingOptions(0), range: searchRange, usingBlock: { [unowned self] (match: NSTextCheckingResult!, flags: NSMatchingFlags, stop: UnsafeMutablePointer<ObjCBool>) -> Void in
            
            let matchRange = match.rangeAtIndex(1)
            
            self.addAttributes(boldAttribute, range: matchRange)
            
            // 4. reset the style to the original
            if NSMaxRange(matchRange) + 1 < self.length {
                
                self.addAttributes(normalAttribute, range: NSMakeRange(NSMaxRange(matchRange) + 1, 1))
            }
        })
    
    }
}
