//
//  ToolBox.h
//  KidsTC
//
//  Created by zhanping on 7/21/16.
//  Copyright © 2016 詹平. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

#define ScoreCoefficient (0.1)

@interface ToolBox : NSObject

+ (NSString *)distanceDescriptionWithMeters:(NSUInteger)meters;

+ (CLLocationCoordinate2D)coordinateFromString:(NSString *)string;

+ (NSString *)stringFromCoordinate:(CLLocationCoordinate2D)coordinate;

+ (id)getObjectFromNibWithView:(UIView *)view;

+ (void)renderGradientForView:(UIView *)view displayFrame:(CGRect)frame startPoint:(CGPoint)start endPoint:(CGPoint)end colors:(NSArray<UIColor *> *)colors locations:(NSArray<NSNumber *> *)locations;

+ (NSString *)jsonFromObject:(id)obj;

+ (void)resetLineView:(UIView *)view withLayoutAttribute:(NSLayoutAttribute)attribute;

+ (void)resetLineView:(UIView *)view withLayoutAttribute:(NSLayoutAttribute)attribute constant:(CGFloat)constant;

+ (CGFloat)heightForLabelWithWidth:(CGFloat)width LineBreakMode:(NSLineBreakMode)mode Font:(UIFont *)font topGap:(CGFloat)tGap bottomGap:(CGFloat)bGap andText:(NSString *)text;

+ (CGFloat)heightForLabelWithWidth:(CGFloat)width LineBreakMode:(NSLineBreakMode)mode Font:(UIFont *)font topGap:(CGFloat)tGap bottomGap:(CGFloat)bGap maxLine:(NSUInteger)line andText:(NSString *)text;

+ (CGFloat)heightForAttributeLabelWithWidth:(CGFloat)width LineBreakMode:(NSLineBreakMode)mode Font:(UIFont *)font topGap:(CGFloat)tGap bottomGap:(CGFloat)bGap maxLine:(NSUInteger)line andText:(NSString *)text;

+ (void)drawLineOnView:(UIView *)view
        withStartPoint:(CGPoint)start
              endPoint:(CGPoint)end
             lineWidth:(CGFloat)width
                   gap:(CGFloat)gap
         sectionLength:(CGFloat)length
                 color:(UIColor *)color
             isVirtual:(BOOL)isVirtual;

+ (NSString *)countDownTimeStringWithLeftTime:(NSTimeInterval)leftTime;
@end
