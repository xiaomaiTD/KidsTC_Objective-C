//
//  SearchFactorAreaDataManager.m
//  KidsTC
//
//  Created by 詹平 on 2016/11/29.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "SearchFactorAreaDataManager.h"


@implementation SearchFactorAreaDataManager
singleM(SearchFactorAreaDataManager)
- (NSArray<SearchFactorAreaDataItem *> *)areas {
    NSArray<AreaAndAgeListItem *> * addr = [AreaAndAgeDataManager shareAreaAndAgeDataManager].model.data.Addr;
    NSMutableArray *areas = [NSMutableArray array];
    SearchFactorAreaDataItem *firstItem = [SearchFactorAreaDataItem itemWithTitle:@"全部地区" value:@""];
    if (firstItem) [areas addObject:firstItem];
    [addr enumerateObjectsUsingBlock:^(AreaAndAgeListItem * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        SearchFactorAreaDataItem *item = [SearchFactorAreaDataItem itemWithTitle:obj.Name value:obj.Value];
        if(item) [areas addObject:item];
    }];
    return [NSArray arrayWithArray:areas];
}
@end
