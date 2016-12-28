//
//  WholesaleProductDetailCount.m
//  KidsTC
//
//  Created by 詹平 on 2016/12/28.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "WholesaleProductDetailCount.h"

@implementation WholesaleProductDetailCount
+ (instancetype)itemWithTitle:(NSString *)title index:(NSInteger)index {
    WholesaleProductDetailCount *item = [WholesaleProductDetailCount new];
    item.title = title;
    item.index = index;
    return item;
}
@end
