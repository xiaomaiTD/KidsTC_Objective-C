//
//  SearchFactorSortDataItem.m
//  KidsTC
//
//  Created by 詹平 on 2016/11/29.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "SearchFactorSortDataItem.h"

@implementation SearchFactorSortDataItem
+ (instancetype)itemWithImg:(NSString *)img title:(NSString *)title value:(NSString *)value {
    SearchFactorSortDataItem *item = [SearchFactorSortDataItem new];
    item.img = img;
    item.title = title;
    item.value = value;
    item.selected = NO;
    return item;
}
@end
