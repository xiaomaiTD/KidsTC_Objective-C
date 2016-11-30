//
//  MyTracksModel.m
//  KidsTC
//
//  Created by 詹平 on 2016/11/30.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "MyTracksModel.h"

@implementation MyTracksModel
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"errNo":@"errno"};
}
+ (NSDictionary *)modelContainerPropertyGenericClass{
    return @{@"data":[MyTracksDateItem class]};
}
- (BOOL)modelCustomTransformFromDictionary:(NSDictionary *)dic {
    
    [_data enumerateObjectsUsingBlock:^(MyTracksDateItem * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        _currentCount += obj.BrowseHistoryLst.count;
    }];
    return YES;
}
@end
