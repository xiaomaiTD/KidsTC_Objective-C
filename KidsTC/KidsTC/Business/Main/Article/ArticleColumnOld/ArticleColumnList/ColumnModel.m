//
//  ColumnModel.m
//  KidsTC
//
//  Created by zhanping on 4/14/16.
//  Copyright © 2016 KidsTC. All rights reserved.
//

#import "ColumnModel.h"

@implementation CDataItem
+ (NSDictionary *)modelCustomPropertyMapper
{
    return @{@"ID" : @"id"};
}
@end

@implementation ColumnResponse
+ (NSDictionary *)modelContainerPropertyGenericClass
{
    return @{@"data" : [CDataItem class]};
}
@end