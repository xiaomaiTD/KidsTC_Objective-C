//
//  NSString+Category.h
//  KidsTC
//
//  Created by 詹平 on 16/7/16.
//  Copyright © 2016年 詹平. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSString (Category)
#pragma mark 校验用户手机号码
+(BOOL)validateMobile:(NSString *)mobileNum;
#pragma mark 校验用户密码（密码6-20位数字和字母组合）
+ (BOOL)validatePassword:(NSString *)password;
+(NSString *)generateSMSCodeKey;
#pragma mark 通过字串取得颜色
+ (UIColor *)colorWithString:(NSString *)string;
#pragma mark 查找字串 返回数组
+ (NSArray<NSString *> *)rangeStringsOfSubString:(NSString *)sub inString:(NSString *)string;
#pragma mark 判断是否不为空
- (BOOL)isNotNull;
#pragma mark 最多两位小数的价格字符串
+ (NSString *)priceStr:(CGFloat)price;
#pragma mark 获取手机的IP地址
+ (NSString *)deviceIPAdress;
@end
