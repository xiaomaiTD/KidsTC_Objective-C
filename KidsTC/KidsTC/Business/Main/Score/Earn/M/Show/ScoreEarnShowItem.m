
//
//  ScoreEarnShowItem.m
//  KidsTC
//
//  Created by 童成mac-dev1 on 2017/2/13.
//  Copyright © 2017年 zhanping. All rights reserved.
//

#import "ScoreEarnShowItem.h"

@implementation ScoreEarnShowItem
+ (instancetype)itemWithCellId:(NSString *)cellId index:(NSUInteger)index {
    ScoreEarnShowItem *item = [ScoreEarnShowItem new];
    item.cellId = cellId;
    item.index = index;
    return item;
}
@end
