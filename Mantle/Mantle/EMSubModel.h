//
//  EMSubModel.h
//  Mantle
//
//  Created by Emiaostein on 2/11/15.
//  Copyright (c) 2015 Emiaostein. All rights reserved.
//

#import "MTLModel.h"
#import <MTLJSONAdapter.h>

@interface EMSubModel : MTLModel<MTLJSONSerializing>

@property(nonatomic, copy)NSString *address;

@end
