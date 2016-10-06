//
//  UIImage+Category.h
//  KidsTC
//
//  Created by zhanping on 7/14/16.
//  Copyright © 2016 詹平. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Category)

#pragma mark - 生成某种颜色的图片
+ (UIImage *)imageWithColor:(UIColor *)color;

+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size;

#pragma mark -为图片填充自定义颜色
- (UIImage *)imageWithTintColor:(UIColor *)tintColor;

#pragma mark -为图片填充自定义颜色 渐变
- (UIImage *)imageWithGradientTintColor:(UIColor *)tintColor;

#pragma mark - 获取未被渲染的Image
+(UIImage *)imageOriginalWithImageName:(NSString *)imageName;

#pragma mark - 缩放图片
- (UIImage *)imageByScalingToSize:(CGSize)targetSize;

#pragma mark - 获取图片大小（单位：字节）
+ (NSUInteger)byteCountOfImage:(UIImage *)image;

#pragma mark - 缩放图片
- (UIImage *)imageByScalingToSize:(CGSize)targetSize retinaFit:(BOOL)needFit;

- (UIImage *)imageRotatedByDegrees:(CGFloat)degrees;

#pragma mark - 画圆(带边框)
+ (instancetype)circleImageWithImage:(UIImage *)image borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor;

#pragma mark - 画圆
+ (instancetype)createRoundedRectImage:(UIImage*)image size:(CGSize)size radius:(NSInteger)r;

- (UIImage *)imageByScalingProportionallyToSize:(CGSize)targetSize;
@end
