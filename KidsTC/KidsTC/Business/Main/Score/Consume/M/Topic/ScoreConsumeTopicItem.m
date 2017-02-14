//
//  ScoreConsumeTopicItem.m
//  KidsTC
//
//  Created by 童成mac-dev1 on 2017/2/14.
//  Copyright © 2017年 zhanping. All rights reserved.
//

#import "ScoreConsumeTopicItem.h"
#import "NSString+Category.h"

@implementation ScoreConsumeTopicItem
+ (NSDictionary *)modelContainerPropertyGenericClass{
    return @{@"products":[ScoreProductItem class]};
}
- (BOOL)modelCustomTransformFromDictionary:(NSDictionary *)dic {
    if (![_title isNotNull]) _title = @"会员特惠";
    return YES;
}
@end
