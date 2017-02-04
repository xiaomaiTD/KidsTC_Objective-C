//
//  NormalProductDetailInsuranceItem.m
//  KidsTC
//
//  Created by 詹平 on 2017/2/4.
//  Copyright © 2017年 zhanping. All rights reserved.
//

#import "NormalProductDetailInsuranceItem.h"

@implementation NormalProductDetailInsuranceItem
+ (instancetype)item:(NSString *)imageName title:(NSString *)title {
    NormalProductDetailInsuranceItem *item = [[self alloc] init];
    item.imageName = imageName;
    item.title = title;
    return item;
}
@end
