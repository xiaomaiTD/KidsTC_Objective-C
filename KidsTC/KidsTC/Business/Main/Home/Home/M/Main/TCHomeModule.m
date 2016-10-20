//
//  TCHomeModule.m
//  KidsTC
//
//  Created by 詹平 on 2016/10/11.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "TCHomeModule.h"
#import "TCHomeFloor.h"

@implementation TCHomeModule
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"type":@"floorType",
             @"name":@"floorName"};
}
+ (NSDictionary *)modelContainerPropertyGenericClass{
    return @{@"floors":[TCHomeFloor class]};
}
@end
