//
//  NormalProductDetailConsultModel.m
//  KidsTC
//
//  Created by 詹平 on 2017/2/4.
//  Copyright © 2017年 zhanping. All rights reserved.
//

#import "NormalProductDetailConsultModel.h"

@implementation NormalProductDetailConsultModel
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"errNo":@"errno"};
}
+ (NSDictionary *)modelContainerPropertyGenericClass{
    return @{@"data":[NormalProductDetailConsultItem class]};
}
- (BOOL)modelCustomTransformFromDictionary:(NSDictionary *)dic {
    NSMutableArray *items = [NSMutableArray array];
    [_data enumerateObjectsUsingBlock:^(NormalProductDetailConsultItem * _Nonnull item1, NSUInteger idx, BOOL * _Nonnull stop) {
        [items addObject:item1];
        [item1.replies enumerateObjectsUsingBlock:^(NormalProductDetailConsultItem * _Nonnull item2, NSUInteger idx, BOOL * _Nonnull stop) {
            item2.isReply = YES;
            item2.name = [NSString stringWithFormat:@"%@ 回复",item2.name];
            [items addObject:item2];
        }];
    }];
    _items = [NSMutableArray arrayWithArray:items];
    
    return YES;
}
@end
