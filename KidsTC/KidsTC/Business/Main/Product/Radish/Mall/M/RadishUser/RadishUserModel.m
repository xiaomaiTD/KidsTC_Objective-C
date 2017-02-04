//
//  RadishUserModel.m
//  KidsTC
//
//  Created by 詹平 on 2017/1/12.
//  Copyright © 2017年 zhanping. All rights reserved.
//

#import "RadishUserModel.h"

@implementation RadishUserModel
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"errNo":@"errno"};
}
@end
