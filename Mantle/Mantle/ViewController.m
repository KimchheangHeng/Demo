//
//  ViewController.m
//  Mantle
//
//  Created by 星宇陈 on 2/10/15.
//  Copyright (c) 2015 Emiaostein. All rights reserved.
//

#import "ViewController.h"
#import "EMModel.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
  [super viewDidLoad];

  NSString *path = [[NSBundle mainBundle]pathForResource:@"json" ofType:@""];
  NSData *data = [NSData dataWithContentsOfFile:path];
  NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
  
//  NSLog(@"%@", dic);
  
  EMModel *model = [MTLJSONAdapter modelOfClass:[EMModel class] fromJSONDictionary:dic error:nil];
  
  NSDictionary *serialDic = [MTLJSONAdapter JSONDictionaryFromModel:model];
  
//  NSLog(@"%s",[model.subEntity isKindOfClass:[EMSubModel class]] ? "YES" : "NO");
    NSLog(@"%@", model.subEntites);
    NSLog(@"%@", serialDic);

}

@end
