//
//  ProductDetailConsultModel.m
//  KidsTC
//
//  Created by 詹平 on 2016/10/28.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "ProductDetailConsultModel.h"

@implementation ProductDetailConsultModel
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"errNo":@"errno"};
}
+ (NSDictionary *)modelContainerPropertyGenericClass{
    return @{@"data":[ProductDetailConsultItem class]};
}
- (BOOL)modelCustomTransformFromDictionary:(NSDictionary *)dic {
    NSMutableArray *items = [NSMutableArray array];
    [_data enumerateObjectsUsingBlock:^(ProductDetailConsultItem * _Nonnull item1, NSUInteger idx, BOOL * _Nonnull stop) {
        [items addObject:item1];
        [item1.replies enumerateObjectsUsingBlock:^(ProductDetailConsultItem * _Nonnull item2, NSUInteger idx, BOOL * _Nonnull stop) {
            item2.isReply = YES;
            item2.name = [NSString stringWithFormat:@"%@ 回复",item2.name];
            [items addObject:item2];
        }];
    }];
    _items = [NSMutableArray arrayWithArray:items];
    
    return YES;
}
@end
