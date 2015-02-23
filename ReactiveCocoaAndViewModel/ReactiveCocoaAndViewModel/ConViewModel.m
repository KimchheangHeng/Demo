//
//  ConViewModel.m
//  ReactiveCocoaAndViewModel
//
//  Created by 星宇陈 on 15/2/15.
//  Copyright (c) 2015年 BoTai Technology. All rights reserved.
//


#import "ConViewModel.h"

@interface ConViewModel ()

@property (nonatomic, strong)ConModel *model;

@end

@implementation ConViewModel


- (instancetype)initWithFrame:(CGRect)frame {
  
  if (self = [self initWithFrame:frame string:@"text"]) {

  }
  return self;
}

- (instancetype)initWithFrame:(CGRect)frame string:(NSString *)string {
  
  if (self = [super init]) {
    
    ConModel *model = [ConModel new];
    model.frame = frame;
    model.string = string;
    [self bindModel:model];
  }

  return self;
}

- (instancetype)initWithConModel:(ConModel *)model {
  
  if (self = [super init]) {
    
    [self bindModel:model];
  }
  
  return self;
}

- (void)setService:(id<conViewEditServices>)service {
  
  _service = service;
  
  RACSignal *gestureSignal = [_service EditByGesture];
  
  [gestureSignal subscribeNext:^(UIPanGestureRecognizer *gesture) {
    
    CGPoint translation = [gesture translationInView:gesture.view];
    CGRect frame = _model.frame;
      
    frame.size = CGSizeMake(frame.size.width + translation.x, frame.size.height + translation.y);

    _model.frame = frame;
    [gesture setTranslation:CGPointZero inView:gesture.view];

  }];
}

- (void)bindModel:(id)model {
  
  _model = model;
  
  self.frame = _model.frame;
  self.string = _model.string;
  
  RAC(self, frame) = RACObserve(_model, frame);
//  RAC(self, string) = RACObserve(_model, string);
 RACSignal* sin = RAC(_model, string) = RACObserve(self, string);
  
  [sin subscribeNext:^(NSString *x) {
    
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    path = [path stringByAppendingPathComponent:@"content"];
    
//    NSLog(@"%@",x);
    
    [x writeToFile:path atomically:YES encoding:NSUTF8StringEncoding error:nil];
  }];
}


@end
