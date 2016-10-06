//
//  RegisterModel.m
//  KidsTC
//
//  Created by 詹平 on 16/7/17.
//  Copyright © 2016年 詹平. All rights reserved.
//

#import "RegisterModel.h"

@implementation RegisterData

@end

@implementation RegisterModel
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"errNo":@"errno"};
}
@end
