
//
//  ScoreConsumeShowItem.m
//  KidsTC
//
//  Created by 童成mac-dev1 on 2017/2/13.
//  Copyright © 2017年 zhanping. All rights reserved.
//

#import "ScoreConsumeShowItem.h"

@implementation ScoreConsumeShowItem
+ (instancetype)itemWithCellId:(NSString *)cellId title:(NSString *)title item:(ScoreProductItem *)item {
    ScoreConsumeShowItem *showItem = [ScoreConsumeShowItem new];
    showItem.cellId = cellId;
    showItem.title = title;
    showItem.item = item;
    return showItem;
}
@end
