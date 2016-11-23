//
//  NurseryModel.m
//  KidsTC
//
//  Created by 詹平 on 2016/11/23.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "NurseryModel.h"

@implementation NurseryModel
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"errNo":@"errno"};
}

+ (NSDictionary *)modelContainerPropertyGenericClass
{
    return @{@"data" : [NurseryItem class]};
}
@end
