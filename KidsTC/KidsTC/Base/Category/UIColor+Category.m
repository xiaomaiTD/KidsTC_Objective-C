//
//  UIColor+Category.m
//  KidsTC
//
//  Created by zhanping on 7/14/16.
//  Copyright © 2016 詹平. All rights reserved.
//

#import "UIColor+Category.h"

@implementation UIColor (Category)

#pragma mark - 根据字符串生成颜色,字符串样式RGB:"225,225,225"
+ (UIColor *)colorWithRGBString:(NSString *)string{
    if (string.length==0) return nil;
    NSArray *colorArray = [string componentsSeparatedByString:@","];
    if ([colorArray count] < 3) return nil;
    UIColor *color = [UIColor colorWithRed:[[colorArray objectAtIndex:0] floatValue]/255.0
                                     green:[[colorArray objectAtIndex:1] floatValue]/255.0
                                      blue:[[colorArray objectAtIndex:2] floatValue]/255.0
                                     alpha:1];
    return color;
}

@end
