//
//  SearchFactorFilterDataItemRight.m
//  KidsTC
//
//  Created by 詹平 on 2016/11/29.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "SearchFactorFilterDataItemRight.h"

@implementation SearchFactorFilterDataItemRight
+ (instancetype)itemWithTitle:(NSString *)title value:(NSString *)value {
    SearchFactorFilterDataItemRight *item = [SearchFactorFilterDataItemRight new];
    item.title = title;
    item.value = value;
    return item;
}
@end
