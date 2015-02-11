//
//  EMContainerViewModel.m
//  ReactiveCocoaAndViewModel
//
//  Created by Emiaostein on 2/11/15.
//  Copyright (c) 2015 BoTai Technology. All rights reserved.
//

#import "EMContainerViewModel.h"

@implementation EMContainerViewModel

- (instancetype)initWithContainerModel:(ContainerModel *)model {
    
    self = [super init];
    
    if (!self) {
        return nil;
    }
    
    _model = model;
    [self bindViewModel];
    
    return self;
}

- (void)bindViewModel {
    
    
}


@end
