//
//  ScoreConsumeProductData.m
//  KidsTC
//
//  Created by 童成mac-dev1 on 2017/2/14.
//  Copyright © 2017年 zhanping. All rights reserved.
//

#import "ScoreConsumeProductData.h"
#import "NSString+Category.h"

@implementation ScoreConsumeProductData
+ (NSDictionary *)modelContainerPropertyGenericClass{
    return @{@"products":[ScoreProductItem class]};
}
- (BOOL)modelCustomTransformFromDictionary:(NSDictionary *)dic {
    if (![_title isNotNull]) _title = @"会员专享";
    return YES;
}
@end
