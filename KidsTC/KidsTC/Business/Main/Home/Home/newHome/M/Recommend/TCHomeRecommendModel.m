//
//  TCHomeRecommendModel.m
//  KidsTC
//
//  Created by 詹平 on 2016/10/14.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "TCHomeRecommendModel.h"


@implementation TCHomeRecommendModel
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"errNo":@"errno"};
}
+ (NSDictionary *)modelContainerPropertyGenericClass{
    return @{@"data":[TCHomeRecommendItem class]};
}
- (BOOL)modelCustomTransformFromDictionary:(NSDictionary *)dic {
    
    NSMutableArray *floors = [NSMutableArray array];
    [_data enumerateObjectsUsingBlock:^(TCHomeRecommendItem *obj, NSUInteger idx, BOOL *stop) {
        TCHomeFloor *floor = [obj conventToFloor];
        if (floor) [floors addObject:floor];
    }];
    _floors = [NSArray arrayWithArray:floors];
    
    return YES;
}
@end
