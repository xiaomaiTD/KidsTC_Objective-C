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
        if (idx == 0) {
            TCHomeFloorTitleContent *titleContent = [TCHomeFloorTitleContent new];
            titleContent.name = @"童成精选";
            titleContent.subName = @"每日10:00更新";
            floor.titleType = TCHomeFloorTitleContentTypeRecommend;
            floor.hasTitle = YES;
            floor.titleContent = titleContent;
            floor.marginTop = 12;
        }
        [floor modelCustomTransformFromDictionary:nil];
        if (floor) [floors addObject:floor];
    }];
    _floors = [NSArray arrayWithArray:floors];
    
    return YES;
}
@end
