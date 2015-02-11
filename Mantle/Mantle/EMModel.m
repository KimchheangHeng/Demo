//
//  EMModel.m
//  Mantle
//
//  Created by 星宇陈 on 2/10/15.
//  Copyright (c) 2015 Emiaostein. All rights reserved.
//

#import "EMModel.h"
#import "EMSubModel.h"
#import <MTLJSONAdapter.h>
#import <Mantle/NSValueTransformer+MTLPredefinedTransformerAdditions.h>
#import <MTLValueTransformer.h>

@implementation EMModel

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
  
  return @{
           @"date":@"result.date",
           @"age":@"result.age",
           @"url":@"result.htmlurl"
           };
}

+ (NSDateFormatter *)dateFormatter {
  NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
  dateFormatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
  dateFormatter.dateFormat = @"yyyy-MM-dd'T'HH:mm:ss'Z'";
  return dateFormatter;
}

+ (NSValueTransformer *)urlJSONTransformer {
  
  return [NSValueTransformer valueTransformerForName:MTLURLValueTransformerName];
}

+ (NSValueTransformer *)dateJSONTransformer {
  
  NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
  dateFormatter.dateFormat = @"yyyy/MM/dd";
  
  return [MTLValueTransformer reversibleTransformerWithForwardBlock:^(NSString *dateStr) {
    return [dateFormatter dateFromString:dateStr];
  } reverseBlock:^(NSDate *date) {
    return [dateFormatter stringFromDate:date];
  }];
}

+ (NSValueTransformer *)subEntityJSONTransformer {
    
    return [MTLValueTransformer reversibleTransformerWithForwardBlock:^(NSDictionary *ModelStr) {
        
        return [MTLJSONAdapter modelOfClass:[EMSubModel class] fromJSONDictionary:ModelStr error:nil];
    } reverseBlock:^(EMSubModel *subEntity) {
        
        return  [MTLJSONAdapter JSONDictionaryFromModel:subEntity];
    }];
}

+ (NSValueTransformer *)subEntitesJSONTransformer {
    
    return [MTLValueTransformer reversibleTransformerWithForwardBlock:^(NSArray *ModelStrs) {
        
        return [MTLJSONAdapter modelsOfClass:[EMSubModel class] fromJSONArray:ModelStrs error:nil];
        
    } reverseBlock:^(NSArray *subEntities) {

        return  [MTLJSONAdapter JSONArrayFromModels:subEntities];
    }];
}

@end


/*
 
 {
 
 "name":"Emiaostein"
 "result":{
 "date":123123123123,
 "age":25,
 "html_url":"http://www.baidu.com"
 }
 }
 
 */