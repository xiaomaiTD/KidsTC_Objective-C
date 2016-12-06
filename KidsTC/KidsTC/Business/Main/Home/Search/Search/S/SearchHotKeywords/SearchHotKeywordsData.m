//
//  SearchHotKeywordsData.m
//  KidsTC
//
//  Created by 詹平 on 2016/12/6.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "SearchHotKeywordsData.h"

@implementation SearchHotKeywordsData
+ (NSDictionary *)modelContainerPropertyGenericClass
{
    return @{@"location" : [SearchHotKeywordsItem class],
             @"product"  : [SearchHotKeywordsItem class],
             @"store"    : [SearchHotKeywordsItem class]};
}
@end
