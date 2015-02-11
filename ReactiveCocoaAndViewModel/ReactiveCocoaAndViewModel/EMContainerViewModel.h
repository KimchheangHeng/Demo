//
//  EMContainerViewModel.h
//  ReactiveCocoaAndViewModel
//
//  Created by Emiaostein on 2/11/15.
//  Copyright (c) 2015 BoTai Technology. All rights reserved.
//

#import "RVMViewModel.h"
#import "ContainerModel.h"

@interface EMContainerViewModel : RVMViewModel

@property(nonatomic, readonly)ContainerModel *model;

@property(nonatomic, readonly)CGRect frame;

- (instancetype)initWithContainerModel:(ContainerModel *)model;

@end
