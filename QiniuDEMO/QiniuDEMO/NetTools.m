//
//  NetTools.m
//  QiniuDEMO
//
//  Created by Emiaostein on 15/3/2.
//  Copyright (c) 2015年 BoTai Technology. All rights reserved.
//

#import "NetTools.h"
#import <Qiniu/QiniuSDK.h>

@implementation NetTools

+ (void)upload {
  
  NSString *token = @"zXqNlKjpzQpFzydm6OCcngSa76aVNp-SwmqG-kUy:btLtchzaOEVW8YIwBa2Cz4Km0dc=:eyJzY29wZSI6ImN1cmlvcyIsImRlYWRsaW5lIjoxNDI1MzgxMzU1fQ==";

  QNUploadManager *upManager = [[QNUploadManager alloc] init];
  NSData *data = [@"theworld" dataUsingEncoding : NSUTF8StringEncoding];
  [upManager putData:data key:@"hello" token:token
            complete: ^(QNResponseInfo *info, NSString *key, NSDictionary *resp) {
              NSLog(@"info = %@", info);
              NSLog(@"resp = %@", resp);
            } option:nil];
}

@end