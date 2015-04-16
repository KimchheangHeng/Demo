//
//  ViewController.swift
//  AsyncDisplayKitInSwift
//
//  Created by 星宇陈 on 4/15/15.
//  Copyright (c) 2015 Emiaostein. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var edit = false
    @IBOutlet weak var collectionView: UICollectionView!
    var cellVMs: [cellViewModel] = []
    let queue = NSOperationQueue()
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.decelerationRate = 0.1
        cellVMs = dataCreator.createCellViewModels(100)
    }
}

extension ViewController: UICollectionViewDataSource {
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return cellVMs.count
    }
    
    // The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("Cell", forIndexPath: indexPath) as! pageCollectionViewCell
        let cellVM = cellVMs[indexPath.item]
        cell.configCell(cellVM, queue: queue)

        return cell
    }
    
}

 // MARK: - IBActions
extension ViewController {
    
    @IBAction func longPressAction(sender: UILongPressGestureRecognizer) {
        
//        println("longPressAction")
    }
    
    @IBAction func tapAction(sender: UITapGestureRecognizer) {
        
        println("tapAction")
        let location = sender.locationInView(collectionView)
        if let indexPath = collectionView.indexPathForItemAtPoint(location) {
            let cell = collectionView.cellForItemAtIndexPath(indexPath) as! pageCollectionViewCell
            let cellVM = cellVMs[indexPath.item]
            let inCellLocatoin = sender.locationInView(cell.containerNode?.view)
            let selectedItem: ASDisplayNode? = cell.containerNode?.subnodes.filter({ (itemVM: AnyObject) -> Bool in
                
                if let subNode = itemVM as? ASDisplayNode {
                    if let textEdit = subNode as? ASEditableTextNode {
                        self.collectionView.userInteractionEnabled = true
                        self.edit = false
                        textEdit.resignFirstResponder()
                    }
                    return CGRectContainsPoint(subNode.frame, inCellLocatoin)
                }
                return false
                
            }).last as? ASDisplayNode
            if let textEdit = selectedItem as? ASEditableTextNode {
                collectionView.userInteractionEnabled = false
                edit = true
                if textEdit.isFirstResponder() == false {
                    textEdit.becomeFirstResponder()
                }
                
            }
            println("inCellLocatoin = \(selectedItem)")
        }
    }
}


extension ViewController: UIGestureRecognizerDelegate {
    
//    func gestureRecognizerShouldBegin(gestureRecognizer: UIGestureRecognizer) -> Bool {
//        
//        return edit
//    }
}

