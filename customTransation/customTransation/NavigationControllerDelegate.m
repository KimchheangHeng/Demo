//
//  NavigationControllerDelegate.m
//  customTransation
//
//  Created by 星宇陈 on 12/13/14.
//  Copyright (c) 2014 Emiaostein. All rights reserved.
//

#import "NavigationControllerDelegate.h"
#import "CircleTransitionAnimator.h"

@interface NavigationControllerDelegate () {
    
    CGFloat panProgress;
}

@property(strong, nonatomic) UIPercentDrivenInteractiveTransition* interactionController;

@end

@implementation NavigationControllerDelegate

- (void)awakeFromNib {
    
    [super awakeFromNib];
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panned:)];
    [self.navigationController.view addGestureRecognizer:pan];
}

- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC {
    
    return [CircleTransitionAnimator new];
}

- (id <UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController
                          interactionControllerForAnimationController:(id <UIViewControllerAnimatedTransitioning>) animationController {
    
    return self.interactionController;
}

- (void)panned:(UIPanGestureRecognizer *)pan {
    
    
    
    switch (pan.state) {
        case UIGestureRecognizerStateBegan: {
            
            panProgress = 0.0f;
            
            self.interactionController = [UIPercentDrivenInteractiveTransition new];
        
            if (self.navigationController.viewControllers.count > 1) {
                
                [self.navigationController popViewControllerAnimated:YES];
            } else {
                
                [self.navigationController.topViewController performSegueWithIdentifier:@"pushSegue" sender:nil];
            }
            
        }
            
            break;
            
        case UIGestureRecognizerStateChanged: {
            
           
            
            CGPoint translation = [pan translationInView:self.navigationController.view];
            panProgress = fabsf(translation.x / CGRectGetWidth(self.navigationController.view.bounds)) ;
             NSLog(@"%f", panProgress);
            [self.interactionController updateInteractiveTransition:panProgress];
        }
            
            break;
            
        case UIGestureRecognizerStateEnded: {
            
            
            
            if (panProgress > 0.4) {
                
                [self.interactionController finishInteractiveTransition];
            } else {
                
                [self.interactionController cancelInteractiveTransition];
            }
            
            self.interactionController = nil;
        }
            
            break;
            
        default: {
            
            [self.interactionController cancelInteractiveTransition];
            self.interactionController = nil;
        }
            break;
    }
}

@end
