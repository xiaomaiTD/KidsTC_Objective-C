//
//  ThemeModel.m
//  KidsTC
//
//  Created by zhanping on 7/14/16.
//  Copyright © 2016 詹平. All rights reserved.
//

#import "ThemeModel.h"

@implementation DownloadedTabBarItemElementModel

@end

@implementation ThemeDownloadedConfigModel

@end

//======================================================================

@implementation ThemeData
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"version":@"newVersion"};
}

@end

@implementation ThemeModel
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"errNo":@"errno"};
}

@end
