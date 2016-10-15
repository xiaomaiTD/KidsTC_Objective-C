//
//  TCHomeData.m
//  KidsTC
//
//  Created by 詹平 on 2016/10/11.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "TCHomeData.h"

@implementation TCHomeData
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"modules":@"homeModules",
             @"categorys":@"wirelessCategorys"};
}
+ (NSDictionary *)modelContainerPropertyGenericClass{
    return @{@"modules":[TCHomeModule class],
             @"categorys":[TCHomeCategory class]};
}
- (BOOL)modelCustomTransformFromDictionary:(NSDictionary *)dic {
    if (_modules.count>0) {
        NSMutableArray<TCHomeFloor *> *sections = [NSMutableArray array];
        [_modules enumerateObjectsUsingBlock:^(TCHomeModule * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if (obj.floors.count>0) {
                [sections addObjectsFromArray:obj.floors];
            }
        }];
        _sections = [NSArray arrayWithArray:sections];
    }
    return YES;
}
@end