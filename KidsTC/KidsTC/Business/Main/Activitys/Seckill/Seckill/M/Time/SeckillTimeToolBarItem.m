//
//  SeckillTimeToolBarItem.m
//  KidsTC
//
//  Created by 詹平 on 2017/1/11.
//  Copyright © 2017年 zhanping. All rights reserved.
//

#import "SeckillTimeToolBarItem.h"

@implementation SeckillTimeToolBarItem
+ (instancetype)itemWithTitle:(NSString *)title img:(NSString *)img type:(SeckillTimeToolBarItemActionType)type {
    SeckillTimeToolBarItem *item = [SeckillTimeToolBarItem new];
    item.title = title;
    item.img = img;
    item.type = type;
    return item;
}
@end
