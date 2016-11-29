//
//  SearchFactorFilterDataItemLefe.m
//  KidsTC
//
//  Created by 詹平 on 2016/11/29.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "SearchFactorFilterDataItemLefe.h"

@implementation SearchFactorFilterDataItemLefe
+ (instancetype)itemWithTitle:(NSString *)title items:(NSArray<SearchFactorFilterDataItemRight *> *)items {
    SearchFactorFilterDataItemLefe *item = [SearchFactorFilterDataItemLefe new];
    item.title = title;
    item.items = items;
    return item;
}
@end
