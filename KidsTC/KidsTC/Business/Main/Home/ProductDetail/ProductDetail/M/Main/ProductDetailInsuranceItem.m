//
//  ProductDetailInsuranceItem.m
//  KidsTC
//
//  Created by 詹平 on 2016/10/27.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "ProductDetailInsuranceItem.h"

@implementation ProductDetailInsuranceItem
+ (instancetype)item:(NSString *)imageName title:(NSString *)title {
    ProductDetailInsuranceItem *item = [[self alloc] init];
    item.imageName = imageName;
    item.title = title;
    return item;
}
@end
