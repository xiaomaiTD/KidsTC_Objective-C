//
//  CategoryModel.m
//  KidsTC
//
//  Created by zhanping on 6/27/16.
//  Copyright © 2016 KidsTC. All rights reserved.
//

#import "CategoryModel.h"

@implementation CategoryListItem
+ (NSDictionary *)modelContainerPropertyGenericClass
{
    return @{@"ScondCategory" : [CategoryListItem class]};
}
@end

@implementation CategoryModel
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"errNo":@"errno"};
}

+ (NSDictionary *)modelContainerPropertyGenericClass
{
    return @{@"data" : [CategoryListItem class]};
}
@end
