//
//  QCMethod.h
//
//  Version 1.02
//
//  www.quartzcodeapp.com
//

#import "TargetConditionals.h"
#import <QuartzCore/QuartzCore.h>

#if (TARGET_IPHONE_SIMULATOR || TARGET_OS_IPHONE)
#import <UIKit/UIKit.h>
#else
#import <Cocoa/Cocoa.h>
#endif

@interface QCMethod : NSObject
+ (CGFloat)maxDurationFromAnimations:(NSArray*)anims;
+ (CGFloat)maxDurationOfEffectAnimation:(CAAnimationGroup*)anim sublayersCount:(NSInteger)count;
+ (void)updateValueFromAnimationsForLayers:(NSArray*)layers;
+ (void)updateValueForAnimation:(CAAnimation*)anim layer:(CALayer *)layer;
+ (void)addSublayersAnimation:(CAAnimation*)anim forKey:(NSString*)key forLayer:(CALayer*)layer;
+ (void)addSublayersAnimation:(CAAnimation*)anim forKey:(NSString*)key forLayer:(CALayer*)layer reverseAnimation:(BOOL)reverse totalDuration:(CGFloat)totalDuration;
+ (CAGradientLayer*)gradientLayerOf:(CALayer*)layer;

+ (CAAnimation*)reverseAnimation:(CAAnimation*)anim totalDuration:(CGFloat)totalDuration;

#if (TARGET_IPHONE_SIMULATOR || TARGET_OS_IPHONE)
+ (UIBezierPath*)alignToBottomPath:(UIBezierPath*)path layer:(CALayer*)layer;
+ (UIBezierPath*)offsetPath:(UIBezierPath*)path by:(CGPoint)offset;

#else
+ (NSBezierPath*)offsetPath:(NSBezierPath*)path by:(CGPoint)offset;

#endif
@end

#if (TARGET_IPHONE_SIMULATOR || TARGET_OS_IPHONE)
#else
@interface NSBezierPath (Path)
- (CGPathRef)quartzPath;
@end

@interface NSImage (cgImage)
-(CGImageRef)cgImage;
@end


#endif