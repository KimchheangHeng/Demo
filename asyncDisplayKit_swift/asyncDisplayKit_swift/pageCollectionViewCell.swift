//
//  pageCollectionViewCell.swift
//  AsyncDisplayKitInSwift
//
//  Created by 星宇陈 on 4/15/15.
//  Copyright (c) 2015 Emiaostein. All rights reserved.
//

import UIKit

class pageCollectionViewCell: UICollectionViewCell {
    
    var containerNode: ASDisplayNode?
    var containerNodeView: UIView?
    var nodeConstructionOperation: NSOperation?
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        if let operation = nodeConstructionOperation {
            operation.cancel()
        }
        
        containerNode?.recursivelySetDisplaySuspended(true)
        containerNodeView?.removeFromSuperview()
        containerNodeView = nil
        containerNode = nil
    }
    
    func configCell(cellVM: cellViewModel, queue: NSOperationQueue) {
        
        if let oldOperation = nodeConstructionOperation {
            oldOperation.cancel()
        }
        
        let newOperation = configCellTaskBy(cellVM, queue: queue)
        nodeConstructionOperation = newOperation
        queue.addOperation(newOperation)
    }
}

// MARK - private
extension pageCollectionViewCell {
    
    private func configCellTaskBy(cellVM: cellViewModel, queue: NSOperationQueue) -> NSOperation {
        
        let operation = NSBlockOperation()
        operation.addExecutionBlock { [weak self, unowned operation] in
            
            if operation.cancelled {
                return
            }
            
            if let strongSelf = self {

               let aContaierNode = strongSelf.renderNodesBy(cellVM)
                
                if operation.cancelled {
                    return
                }
                dispatch_async(dispatch_get_main_queue(), { [weak operation] in
                    if let strongOperation = operation{
                        if strongOperation.cancelled{
                            return
                        }
                        
                        if strongSelf.nodeConstructionOperation != operation {
                            return
                        }
                        
                        if aContaierNode.displaySuspended {
                            return
                        }
                        
                        strongSelf.contentView.addSubview(aContaierNode.view)
                        aContaierNode.setNeedsDisplay()
                        strongSelf.containerNodeView = aContaierNode.view
                        strongSelf.containerNode = aContaierNode
                        println("end")
                    }
                })
            }
        }
        return operation
    }
    
    private func renderNodesBy(cellVM: cellViewModel) -> ASDisplayNode {
        
        let aContainerNode = ASDisplayNode()
        aContainerNode.layerBacked = false
        aContainerNode.frame = self.bounds
        aContainerNode.userInteractionEnabled = true
        
        for itemVM in cellVM.itemVMs {
            
            let node = ASEditableTextNode()
            node.layerBacked = false
            node.attributedText = NSAttributedString(string: "EMiaostein")
            node.frame.origin.x = itemVM.center.x - itemVM.size.width / 2.0
            node.frame.origin.y = itemVM.center.y - itemVM.size.height / 2.0
            node.bounds.size = itemVM.size
//            let image = UIImage(named: "Cycling Tours.jpeg")
//            node.image = image
//            node.transform = CATransform3DMakeRotation(itemVM.rotation, 0, 0, 1)
            node.backgroundColor = UIColor(red: CGFloat(Double(itemVM.size.width % 255) / 255.0), green: CGFloat(Double(itemVM.size.width) / 255.0), blue: CGFloat(Double(itemVM.size.width) / 255.0), alpha: 1)
            aContainerNode.addSubnode(node)
        }
        
        return aContainerNode
    }
}

