//
//  SearchFactorAreaDataItem.m
//  KidsTC
//
//  Created by 詹平 on 2016/11/29.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "SearchFactorAreaDataItem.h"

@implementation SearchFactorAreaDataItem
+(instancetype)itemWithTitle:(NSString *)title value:(NSString *)value {
    SearchFactorAreaDataItem *item = [SearchFactorAreaDataItem new];
    item.title = title;
    item.value = value;
    item.selected = NO;
    return item;
}
@end
