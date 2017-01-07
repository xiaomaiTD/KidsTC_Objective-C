//
//  BuryPointModel.m
//  KidsTC
//
//  Created by 詹平 on 2017/1/7.
//  Copyright © 2017年 zhanping. All rights reserved.
//

#import "BuryPointModel.h"
#import "NSString+Category.h"

@implementation BuryPointModel
+ (instancetype)modelWithPk:(NSString *)pk content:(NSString *)content {
    if (![content isNotNull]) return nil;
    BuryPointModel *model = [BuryPointModel new];
    model.status = NO;
    model.pk = pk;
    model.time = [[NSDate date] timeIntervalSince1970];
    model.content = content;
    return model;
}
@end
