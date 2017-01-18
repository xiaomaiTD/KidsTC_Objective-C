//
//  TCHomeModule.m
//  KidsTC
//
//  Created by 詹平 on 2016/10/11.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "TCHomeModule.h"
#import "TCHomeFloor.h"

@implementation TCHomeModule
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"type":@"floorType",
             @"name":@"floorName"};
}
+ (NSDictionary *)modelContainerPropertyGenericClass{
    return @{@"floors":[TCHomeFloor class]};
}
- (BOOL)modelCustomTransformFromDictionary:(NSDictionary *)dic {
    
    NSMutableArray *ary = [NSMutableArray array];
    [_floors enumerateObjectsUsingBlock:^(TCHomeFloor *obj, NSUInteger idx, BOOL *stop) {
        switch (obj.contentType) {
            case TCHomeFloorContentTypeBanner:
            case TCHomeFloorContentTypeTwinklingElf:
            case TCHomeFloorContentTypeHorizontalList:
            case TCHomeFloorContentTypeThree:
            case TCHomeFloorContentTypeTwoColumn:
            case TCHomeFloorContentTypeNews:
            case TCHomeFloorContentTypeImageNews:
            case TCHomeFloorContentTypeThreeImageNews:
            case TCHomeFloorContentTypeWholeImageNews:
            case TCHomeFloorContentTypeNotice:
            case TCHomeFloorContentTypeBigImageTwoDesc:
            case TCHomeFloorContentTypeOneToFour:
            case TCHomeFloorContentTypeRecommend:
            case TCHomeFloorContentTypeFive:
            case TCHomeFloorContentTypeTwoColumns:
            case TCHomeFloorContentTypeThreeScroll:
            {
                [ary addObject:obj];
            }
                break;
        }
    }];
    _floors = [NSArray arrayWithArray:ary];
    
    return YES;
}
@end
