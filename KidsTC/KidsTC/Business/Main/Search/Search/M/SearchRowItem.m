//
//  SearchRowItem.m
//  KidsTC
//
//  Created by 詹平 on 2016/12/6.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "SearchRowItem.h"

@implementation SearchRowItem
+ (instancetype)rowItemWithType:(SearchRowItemType)type icon:(NSString *)icon items:(NSArray<SearchHotKeywordsItem *> *)items {
    SearchRowItem *item = [SearchRowItem new];
    item.type = type;
    item.icon = icon;
    item.items = items;
    return item;
}
@end
