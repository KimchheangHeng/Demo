//
//  ConView.h
//  ReactiveCocoaAndViewModel
//
//  Created by 星宇陈 on 15/2/15.
//  Copyright (c) 2015年 BoTai Technology. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ConViewModel.h"
#import "ReactViewProtocol.h"

@interface ConView : UIView<ReactViewProtocol>

- (instancetype)initWithViewModel:(ConViewModel *)viewModel;

- (void)startAllAnimations;

- (void)startReverseAnimations;

@end
