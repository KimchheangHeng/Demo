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
    var nodeConstructionOperation: NSOperation?
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        if let operation = nodeConstructionOperation {
            operation.cancel()
        }
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
                
                NSThread.sleepForTimeInterval(1)
                println("1 /n")
                if operation.cancelled {
                    return
                }
                NSThread.sleepForTimeInterval(3)
                println("2 /n")
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
                        
                        println("end")
                    }
                    
                })
            }
        }
        return operation
    }
}
