//
//  LoginModel.m
//  KidsTC
//
//  Created by 詹平 on 16/7/16.
//  Copyright © 2016年 詹平. All rights reserved.
//

#import "LoginModel.h"


@implementation LoginItemModel


@end

@implementation LoginData

@end

@implementation LoginModel
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"errNo":@"errno"};
}
@end
