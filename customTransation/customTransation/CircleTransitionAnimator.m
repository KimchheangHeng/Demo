//
//  CircleTransitionAnimator.m
//  customTransation
//
//  Created by 星宇陈 on 12/13/14.
//  Copyright (c) 2014 Emiaostein. All rights reserved.
//

#import "CircleTransitionAnimator.h"
#import "ViewController.h"

@interface CircleTransitionAnimator ()

@property (weak, nonatomic) id<UIViewControllerContextTransitioning> transitionContext;

@end

@implementation CircleTransitionAnimator

- (NSTimeInterval)transitionDuration:(id <UIViewControllerContextTransitioning>)transitionContext {
    
    return 0.5f;
}
// This method can only  be a nop if the transition is interactive and not a percentDriven interactive transition.
- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext {
    
    // 1
    self.transitionContext = transitionContext;
    
   UIView *containerView = [transitionContext containerView];
    
    ViewController *from = (ViewController *)[transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    ViewController *to = (ViewController *)[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    UIButton *button = from.button;
    
    [containerView addSubview:to.view];
    
    UIBezierPath *circleMaskPathInitial = [UIBezierPath bezierPathWithOvalInRect:button.frame];
    CGPoint extremePoint = CGPointMake(button.center.x - 0, button.center.y - MAX(CGRectGetHeight(to.view.bounds), CGRectGetWidth(to.view.bounds)));
    NSLog(@"to.height = %f",CGRectGetHeight(to.view.bounds));
    CGFloat radious = sqrtf((extremePoint.x * extremePoint.x) + (extremePoint.y * extremePoint.y));
    UIBezierPath *circleMaskPathFinal = [UIBezierPath bezierPathWithOvalInRect:CGRectInset(button.frame, -radious, -radious)];
    
    CAShapeLayer *maskLayer = [CAShapeLayer new];
    maskLayer.path = circleMaskPathFinal.CGPath;
    to.view.layer.mask = maskLayer;
    
    CABasicAnimation *maskLayerAnimation = [CABasicAnimation animationWithKeyPath:@"path"];
    maskLayerAnimation.fromValue = (__bridge id)(circleMaskPathInitial.CGPath);
    maskLayerAnimation.toValue = (__bridge id)(circleMaskPathFinal.CGPath);
    maskLayerAnimation.duration = 0.5f;
    maskLayerAnimation.delegate = self;
    
    [maskLayer addAnimation:maskLayerAnimation forKey:@"path"];
    
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    
    if (flag) {
        
        [self.transitionContext completeTransition:![self.transitionContext transitionWasCancelled]];
        ViewController *from = (ViewController *)[self.transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
        from.view.layer.mask = nil;
    }
}

@end
