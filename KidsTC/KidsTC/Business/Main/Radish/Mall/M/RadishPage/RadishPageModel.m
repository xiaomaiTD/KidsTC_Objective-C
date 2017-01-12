//
//  RadishPageModel.m
//  KidsTC
//
//  Created by 詹平 on 2017/1/12.
//  Copyright © 2017年 zhanping. All rights reserved.
//

#import "RadishPageModel.h"

@implementation RadishPageModel
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"errNo":@"errno"};
}
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"data":[RadishMallProduct class]};
}
- (BOOL)modelCustomTransformFromDictionary:(NSDictionary *)dic {
    [self.data enumerateObjectsUsingBlock:^(RadishMallProduct *obj, NSUInteger idx, BOOL *stop) {
        obj.showType = RadishMallProductTypeLarge;
    }];
    return YES;
}
@end
