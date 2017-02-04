//
//  RadishProductDetailInsuranceItem.m
//  KidsTC
//
//  Created by 詹平 on 2016/10/27.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "RadishProductDetailInsuranceItem.h"

@implementation RadishProductDetailInsuranceItem
+ (instancetype)item:(NSString *)imageName title:(NSString *)title {
    RadishProductDetailInsuranceItem *item = [[self alloc] init];
    item.imageName = imageName;
    item.title = title;
    return item;
}
@end
