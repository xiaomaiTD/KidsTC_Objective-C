//
//  UIColor+Category.h
//  KidsTC
//
//  Created by zhanping on 7/14/16.
//  Copyright © 2016 詹平. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (Category)

#pragma mark - 根据字符串生成颜色,字符串样式RGB:"225,225,225"
+ (UIColor *)colorWithRGBString:(NSString *)string;

@end
