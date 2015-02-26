//
//  ViewController.m
//  ReactiveCocoaAndViewModel
//
//  Created by Emiaostein on 2/11/15.
//  Copyright (c) 2015 BoTai Technology. All rights reserved.
//

#import "ViewController.h"
#import "ConModel.h"
#import "ConViewModel.h"
#import "ConView.h"
#import <RACEXTScope.h>
#import <ReactiveCocoa/ReactiveCocoa.h>
#import <ReactiveCocoa/UISlider+RACSignalSupport.h>

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UISlider *slider;
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UIButton *button;
@property (strong, nonatomic)UIView *the;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  
  [self setup];
}

- (void)setup {
  
  ConModel *model = [ConModel new];
  model.frame = CGRectMake(100, 100, 50, 100);
  
  NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
  path = [path stringByAppendingPathComponent:@"content"];
  
  NSData *data = [NSData dataWithContentsOfFile:path];
  
  model.string = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
  ConViewModel *viewModel = [[ConViewModel alloc] initWithConModel:model];
  ConView *conView = [[ConView alloc] initWithViewModel:viewModel];
//  conView.clipsToBounds = YES;
  conView.backgroundColor = [UIColor clearColor];
  [self.view addSubview:conView];
  
  _slider.value = model.frame.size.width /100.0;
  _textView.text = model.string;
  
  RACSignal *valueSignal = [_slider rac_newValueChannelWithNilValue:@0];

  [valueSignal
   subscribeNext:^(NSNumber *x) {
     CGRect frame = model.frame;
     frame.size = CGSizeMake([x floatValue] * 100, [x floatValue] * 200);
     model.frame = frame;
   } completed:^{

   }];
  
  [self.textView.rac_textSignal
   subscribeNext:^(NSString *x) {
     
     model.string = x;
   }];
  
  dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
    
    [conView startAllAnimations];
    
//    [conView startReverseAnimations];
  });
  
//  dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//    
//    [conView startAllAnimations];
//    
//    //    [conView startReverseAnimations];
//  });
  
  _the = conView;
  
  
}

- (IBAction)playan:(id)sender {
  
  [(ConView *)_the startAllAnimations];
}


@end
