//
//  GCD_extension.swift
//  asyncDisplayKit_swift
//
//  Created by Emiaostein on 15/4/15.
//  Copyright (c) 2015年 Emiaostein. All rights reserved.
//

import Foundation

typealias Task = (cancel : Bool) -> ()

func delayinMainQueue(time: NSTimeInterval, task:()->()) -> Task? {
    return delay(time, dispatch_get_main_queue(), task)
}

func delay(time:NSTimeInterval, queue: dispatch_queue_t!, task:()->()) -> Task? {
    func dispatch_later(block:()->()) {
    dispatch_after(
    dispatch_time(
    DISPATCH_TIME_NOW,
    Int64(time * Double(NSEC_PER_SEC))),
    dispatch_get_main_queue(),
    block)
    }
    
    var closure: dispatch_block_t? = task
    var result: Task?
    let delayedClosure: Task = { cancel in
        if let internalClosure = closure {
            if (cancel == false) {
                dispatch_async(queue, internalClosure);
            }
        }
        closure = nil
        result = nil
    }
    result = delayedClosure
    dispatch_later {
        if let delayedClosure = result {
        delayedClosure(cancel: false)
        }
    }
    return result
}

func cancel(task:Task?) {
        task?(cancel: true)
}