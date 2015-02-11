//
//  RWTFlickrPhoto.h
//  RWTFlickrSearch
//
//  Created by Emiaostein on 2/11/15.
//  Copyright (c) 2015 Colin Eberhardt. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RWTFlickrPhoto : NSObject

@property(nonatomic, copy)NSString *title;
@property(nonatomic, strong)NSURL *url;
@property(nonatomic, copy)NSString *identifier;

@end
