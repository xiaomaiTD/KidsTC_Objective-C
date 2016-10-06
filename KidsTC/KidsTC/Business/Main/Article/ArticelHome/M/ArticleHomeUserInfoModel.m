//
//  ArticleHomeUserInfoModel.m
//  KidsTC
//
//  Created by zhanping on 2016/9/14.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "ArticleHomeUserInfoModel.h"

@implementation ArticleHomeUserInfoData

@end

@implementation ArticleHomeUserInfoModel
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"errNo":@"errno"};
}
@end
