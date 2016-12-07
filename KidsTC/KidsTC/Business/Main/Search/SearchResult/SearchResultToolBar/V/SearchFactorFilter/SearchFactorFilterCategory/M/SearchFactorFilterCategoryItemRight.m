
//
//  SearchFactorFilterCategoryItemRight.m
//  KidsTC
//
//  Created by 詹平 on 2016/12/7.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "SearchFactorFilterCategoryItemRight.h"

@implementation SearchFactorFilterCategoryItemRight
+ (instancetype)itemWithTitle:(NSString *)title value:(NSString *)value{
    SearchFactorFilterCategoryItemRight *item = [SearchFactorFilterCategoryItemRight new];
    item.title = title;
    item.value = value;
    return item;
}
@end
