//
//  RWTViewModelServices.h
//  RWTFlickrSearch
//
//  Created by Emiaostein on 2/11/15.
//  Copyright (c) 2015 Colin Eberhardt. All rights reserved.
//

#ifndef RWTFlickrSearch_RWTViewModelServices_h
#define RWTFlickrSearch_RWTViewModelServices_h


#endif

@import Foundation;
#import "RWTFlickrSearch.h"

@protocol RWTViewModelServices <NSObject>

- (id<RWTFlickrSearch>) getFlickrSearchService;

@end