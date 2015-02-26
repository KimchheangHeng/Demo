//
//  ViewController.m
//  UIGestureDemo
//
//  Created by Emiaostein on 2/26/15.
//  Copyright (c) 2015 BoTai Technology. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)TapAction:(UITapGestureRecognizer *)sender {
    
    CGPoint location = [sender locationOfTouch:0 inView:sender.view];
    
    NSLog(@"%@", NSStringFromCGPoint(location));
    
    UIView *selectedView = nil;
    
    for (UIView *subView in sender.view.subviews) {
        
        CGRect frame = subView.frame;
        if (CGRectContainsPoint(frame, location)) {
            
            selectedView = subView;
            break;
        }
    }
    
    if (selectedView) {
        selectedView.backgroundColor = [UIColor redColor];
        
        for (UIView *subView in sender.view.subviews) {
            
            if (selectedView != subView) {
                
                subView.backgroundColor = [UIColor yellowColor];
            }
        }
        
    } else {
        for (UIView *subView in sender.view.subviews) {
            
            subView.backgroundColor = [UIColor yellowColor];
        }
    }
}


@end
