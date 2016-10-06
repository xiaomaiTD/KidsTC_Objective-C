//
//  AppVersionModel.m
//  KidsTC
//
//  Created by zhanping on 8/19/16.
//  Copyright © 2016 詹平. All rights reserved.
//

#import "AppVersionModel.h"

@implementation AppVersionData
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"appNewVersion":@"newVersion",
             @"desc":@"description"};
}
@end

@implementation AppVersionModel

@end
