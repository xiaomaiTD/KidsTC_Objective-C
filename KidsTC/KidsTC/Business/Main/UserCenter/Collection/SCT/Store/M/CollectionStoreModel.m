//
//  CollectionStoreModel.m
//  KidsTC
//
//  Created by 詹平 on 2016/11/26.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "CollectionStoreModel.h"

@implementation CollectionStoreModel
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"errNo":@"errno"};
}
+ (NSDictionary *)modelContainerPropertyGenericClass{
    return @{@"data":[CollectionStoreItem class]};
}
@end
