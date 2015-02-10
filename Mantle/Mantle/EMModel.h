//
//  EMModel.h
//  Mantle
//
//  Created by 星宇陈 on 2/10/15.
//  Copyright (c) 2015 Emiaostein. All rights reserved.
//

#import "MTLModel.h"
#import <MTLJSONAdapter.h>

typedef NS_ENUM(NSUInteger, EMModelState) {
  
  EMModelStateYES,
  EMModelStateNO
};

@interface EMModel : MTLModel<MTLJSONSerializing>

@property(nonatomic, copy, readonly)NSString *name;
@property(nonatomic, copy, readonly)NSDate *date;
@property(nonatomic, assign, readonly)NSNumber *age;
@property(nonatomic, copy)NSURL *url;


@end
