//
//  RWTFlickrSearchViewModel.h
//  RWTFlickrSearch
//
//  Created by Emiaostein on 2/11/15.
//  Copyright (c) 2015 Colin Eberhardt. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ReactiveCocoa/ReactiveCocoa.h>
#import "RWTViewModelServices.h"

@interface RWTFlickrSearchViewModel : NSObject

@property(strong, nonatomic)NSString *searchText;
@property(strong, nonatomic)NSString *title;

@property(strong, nonatomic)RACCommand *executeSearch;

- (instancetype) initWithServices:(id<RWTViewModelServices>)services;

@end
