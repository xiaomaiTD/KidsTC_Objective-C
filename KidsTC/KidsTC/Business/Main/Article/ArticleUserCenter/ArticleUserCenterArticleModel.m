//
//  ArticleUserCenterArticleModel.m
//  KidsTC
//
//  Created by zhanping on 2016/9/14.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "ArticleUserCenterArticleModel.h"

@implementation ArticleUserCenterArticleModel

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"errNo":@"errno"};
}

+ (NSDictionary *)modelContainerPropertyGenericClass
{
    return @{@"data":@"ArticleHomeItem"};
}

@end
