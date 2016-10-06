//
//  ArticleWeChatModel.m
//  KidsTC
//
//  Created by zhanping on 7/13/16.
//  Copyright © 2016 KidsTC. All rights reserved.
//

#import "ArticleWeChatModel.h"

@implementation ArticleWeChatItem
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"ID":@"id"};
}
@end

@implementation ArticleWeChatDataItem
+ (NSDictionary *)modelContainerPropertyGenericClass
{
    return @{@"item" : [ArticleWeChatItem class]};
}
@end

@implementation ArticleWeChatModel
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"errNo":@"errno"};
}
+ (NSDictionary *)modelContainerPropertyGenericClass
{
    return @{@"data" : [ArticleWeChatDataItem class]};
}
@end
