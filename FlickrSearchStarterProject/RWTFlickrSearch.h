//
//  RWTFlickrSearch.h
//  RWTFlickrSearch
//
//  Created by Emiaostein on 2/11/15.
//  Copyright (c) 2015 Colin Eberhardt. All rights reserved.
//

#ifndef RWTFlickrSearch_RWTFlickrSearch_h
#define RWTFlickrSearch_RWTFlickrSearch_h




#endif

#import <ReactiveCocoa/ReactiveCocoa.h>
@import Foundation;

@protocol RWTFlickrSearch <NSObject>

- (RACSignal *)flickrSearchSignal:(NSString *)searchString;

@end