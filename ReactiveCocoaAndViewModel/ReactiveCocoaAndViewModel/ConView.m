//
//  ConView.m
//  ReactiveCocoaAndViewModel
//
//  Created by 星宇陈 on 15/2/15.
//  Copyright (c) 2015年 BoTai Technology. All rights reserved.
//

#import "ConView.h"
#import "conViewEditServices.h"
#import "QCMethod.h"

@interface ConView () <conViewEditServices>

@property (nonatomic, strong)ConViewModel *viewModel;
@property (nonatomic, strong)UIGestureRecognizer *pan;
@property (nonatomic, strong)UITapGestureRecognizer *tap;
@property (nonatomic, strong)CATextLayer *text;
@property (nonatomic, strong)CALayer *Group;
@property (nonatomic, strong)CAShapeLayer * rectangle;
@property (nonatomic, strong)UITextView *textView;


@end

@implementation ConView

- (instancetype)initWithViewModel:(ConViewModel *)viewModel {
  
  if (self = [super initWithFrame:CGRectZero]) {
    
    [self addGesture];
    [self bindViewModel:viewModel];
    [self setupTextView];
  }
  
  return self;
}

- (void)addGesture {
  
  self.pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:nil];
  self.tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:nil];
  [self addGestureRecognizer:_pan];

}

- (RACSignal *)EditByGesture {
  
  return _pan.rac_gestureSignal;
}


- (void)bindViewModel:(id)viewModel {
  
  _viewModel = viewModel;
  _viewModel.service = self;
  
  self.frame = _viewModel.frame;
  
  RACSignal *frameSignal = RACObserve(_viewModel, frame);
  RACSignal *stringSignal = RACObserve(_viewModel, string);
  
  RAC(self,frame) = frameSignal;

//  [self setupLayers];
  
  [[frameSignal
   map:^id(NSValue *value) {
     
     NSLog(@"TEXT:%@, FRAME:%@", NSStringFromCGRect(_text.frame),value);
     
     CGRect vFrame = [value CGRectValue];
     
     return [NSValue valueWithCGRect:CGRectMake(0, 0, vFrame.size.width, vFrame.size.height)];
     
   }] subscribeNext:^(NSValue *value) {

     _textView.bounds = [value CGRectValue];
//     [self setNeedsDisplay];
//     [self setupLayerFrames];
     
   }];
  
  
//  [stringSignal subscribeNext:^(id x) {
//    
//    [self setNeedsDisplay];
//  }];
}

- (void)setupTextView {
  
  UITextView *textView = [[UITextView alloc] initWithFrame:self.bounds];
  textView.backgroundColor = [UIColor lightGrayColor];
  textView.attributedText = [self myString];
  
//  RAC(textView, text) = RACObserve(_viewModel, string);
  RAC(_viewModel, string) = textView.rac_textSignal;
  self.textView = textView;
  [self addSubview:textView];
}

- (NSAttributedString*)myString
{
  // Create the attributed string
  NSMutableAttributedString *myString = [[NSMutableAttributedString alloc]initWithString:
                                         _viewModel.string];
  
  
  // Declare the fonts
  UIFont *myStringFont1 = [UIFont fontWithName:@"Wyue-GutiFangsong-NC" size:12.0];
  
  // Declare the colors
  UIColor *myStringColor1 = [UIColor colorWithRed:0.000000 green:0.000000 blue:0.000000 alpha:1.000000];
  
  
  // Create the attributes and add them to the string
  NSUInteger length = _viewModel.string.length;
  [myString addAttribute:NSUnderlineColorAttributeName value:myStringColor1 range:NSMakeRange(0,length)];
//  [myString addAttribute:NSParagraphStyleAttributeName value:myStringParaStyle1 range:NSMakeRange(0,42)];
  [myString addAttribute:NSFontAttributeName value:myStringFont1 range:NSMakeRange(0,length)];
  
  return [[NSAttributedString alloc]initWithAttributedString:myString];
}

- (void)setupLayers{
  CALayer * Group = [CALayer layer];
  [self.layer addSublayer:Group];
  
  _Group = Group;
  {
    CAShapeLayer * rectangle = [CAShapeLayer layer];
    [Group addSublayer:rectangle];
    rectangle.fillColor   = [UIColor colorWithRed:0.902 green: 0.902 blue:0.902 alpha:1].CGColor;
    rectangle.strokeColor = [UIColor colorWithRed:0.26 green: 0.26 blue:0.26 alpha:1].CGColor;
    rectangle.lineDashPattern = @[@10, @10];
    _rectangle = rectangle;
    
    CATextLayer * text = [CATextLayer layer];
    [Group addSublayer:text];
    text.contentsScale   = [[UIScreen mainScreen] scale];
    text.string          = @"what can i do for you ?\n\ntoday is good day , do you want to have breakfast?\n\nthank you very much !";
    text.font            = (__bridge CFTypeRef)@"Helvetica";
    text.fontSize        = 24;
    text.alignmentMode   = kCAAlignmentCenter;
    text.foregroundColor = [UIColor blackColor].CGColor;
    text.wrapped         = YES;
    _text = text;
    
  }
  
  [self setupLayerFrames];
}


- (void)setupLayerFrames{
  _Group.frame     = CGRectMake(0,0, CGRectGetWidth(_Group.superlayer.bounds), CGRectGetHeight(_Group.superlayer.bounds));
  _rectangle.frame = CGRectMake(0, 0,CGRectGetWidth(_rectangle.superlayer.bounds),  CGRectGetHeight(_rectangle.superlayer.bounds));
  _rectangle.path  = [self rectanglePathWithBounds:_rectangle.bounds].CGPath;
  _text.frame      = CGRectMake(0, 0,  CGRectGetWidth(_text.superlayer.bounds),  CGRectGetHeight(_text.superlayer.bounds));
}


#pragma mark - Bezier Path

- (UIBezierPath*)rectanglePathWithBounds:(CGRect)bound{
  UIBezierPath*  rectanglePath = [UIBezierPath bezierPathWithRect:bound];
  return rectanglePath;
}

- (void)drawRect:(CGRect)rect {
  
  [super drawRect:rect];
  
  [self drawCanvas1WithFrame:rect];
}

- (void)drawCanvas1WithFrame: (CGRect)frame
{
  //// General Declarations
  CGContextRef context = UIGraphicsGetCurrentContext();
  
  //// Text Drawing
  CGRect textRect = CGRectMake(CGRectGetMinX(frame) + floor(CGRectGetWidth(frame) * 0.02083 + 0.5), CGRectGetMinY(frame) + floor(CGRectGetHeight(frame) * 0.04167 + 0.5), floor(CGRectGetWidth(frame) * 0.97917 + 0.5) - floor(CGRectGetWidth(frame) * 0.02083 + 0.5), floor(CGRectGetHeight(frame) * 0.95833 + 0.5) - floor(CGRectGetHeight(frame) * 0.04167 + 0.5));
  UIBezierPath* textPath = [UIBezierPath bezierPathWithRect: textRect];
  [UIColor.darkGrayColor setStroke];
  textPath.lineWidth = 0.5;
  CGFloat textPattern[] = {8, 8};
  [textPath setLineDash: textPattern count: 2 phase: 0];
  [textPath stroke];
  {
    NSString* textContent = _viewModel.string;

    NSMutableParagraphStyle* textStyle = NSMutableParagraphStyle.defaultParagraphStyle.mutableCopy;
    textStyle.alignment = NSTextAlignmentCenter;
    
    NSDictionary* textFontAttributes = @{NSFontAttributeName: [UIFont systemFontOfSize: UIFont.labelFontSize], NSForegroundColorAttributeName: UIColor.blackColor, NSParagraphStyleAttributeName: textStyle};
    
    CGFloat textTextHeight = [textContent boundingRectWithSize: CGSizeMake(textRect.size.width, INFINITY)  options: NSStringDrawingUsesLineFragmentOrigin attributes: textFontAttributes context: nil].size.height;
    CGContextSaveGState(context);
    CGContextClipToRect(context, textRect);
    [textContent drawInRect: CGRectMake(CGRectGetMinX(textRect), CGRectGetMinY(textRect) + (CGRectGetHeight(textRect) - textTextHeight) / 2, CGRectGetWidth(textRect), textTextHeight) withAttributes: textFontAttributes];
    CGContextRestoreGState(context);
  }
}

- (void)startAllAnimations{
  [self.layer addAnimation:[self rectangleAnimation] forKey:@"rectangleAnimation"];
  [QCMethod updateValueFromAnimationsForLayers:@[self.layer]];
}

- (void)startReverseAnimations{
  CGFloat totalDuration = 0;
  [self.layer addAnimation:[QCMethod reverseAnimation:[self rectangleAnimation] totalDuration:totalDuration] forKey:@"rectangleAnimation"];
  [QCMethod updateValueFromAnimationsForLayers:@[self.layer]];
}

- (CABasicAnimation*)rectangleAnimation{
  CABasicAnimation * positionAnim = [CABasicAnimation animationWithKeyPath:@"position"];
  positionAnim.fromValue          = [NSValue valueWithCGPoint:self.center];
  positionAnim.toValue            = [NSValue valueWithCGPoint:CGPointMake(200, 300)];
  positionAnim.duration           = 1;
  positionAnim.timingFunction     = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
  positionAnim.fillMode = kCAFillModeBackwards;

//  positionAnim.removedOnCompletion = NO;
//  positionAnim.autoreverses = YES;
  
  return positionAnim;
}

@end
