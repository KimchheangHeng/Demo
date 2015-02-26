//
//  ConViewModel.h
//  ReactiveCocoaAndViewModel
//
//  Created by 星宇陈 on 15/2/15.
//  Copyright (c) 2015年 BoTai Technology. All rights reserved.
//

#import "RVMViewModel.h"
#import "ViewModelProtocol.h"
#import "ConModel.h"
#import "conViewEditServices.h"
#import <ReactiveCocoa/ReactiveCocoa.h>

@interface ConViewModel : RVMViewModel

@property (nonatomic)CGRect frame;
@property (nonatomic, copy) NSString *string;
@property (nonatomic, weak)id<conViewEditServices> service;

- (instancetype)initWithFrame:(CGRect)frame;
- (instancetype)initWithFrame:(CGRect)frame string:(NSString *)string;

- (instancetype)initWithConModel:(ConModel *)model;

@end
