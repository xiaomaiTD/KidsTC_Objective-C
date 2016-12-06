//
//  SearchHotKeywordsItem.m
//  KidsTC
//
//  Created by 詹平 on 2016/12/6.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "SearchHotKeywordsItem.h"

@implementation SearchHotKeywordsItem
+ (instancetype)itemWithName:(NSString *)name {
    SearchHotKeywordsItem *item = [SearchHotKeywordsItem new];
    item.name = name;
    return item;
}
@end
