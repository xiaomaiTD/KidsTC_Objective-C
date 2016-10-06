//
//  ArticleCommentModel.m
//  KidsTC
//
//  Created by zhanping on 4/26/16.
//  Copyright © 2016 KidsTC. All rights reserved.
//

#import "ArticleCommentModel.h"

@implementation ADArticleInfro

@end

@implementation ACReply

@end

@implementation EvaListItem
+ (NSDictionary *)modelContainerPropertyGenericClass
{
    return @{@"imgUrls" : [NSArray class]};
}
@end

@implementation ADMyEva
+ (NSDictionary *)modelContainerPropertyGenericClass
{
    return @{@"evaList" : [EvaListItem class]};
}
@end

@implementation ADHotEva
+ (NSDictionary *)modelContainerPropertyGenericClass
{
    return @{@"evaList" : [EvaListItem class]};
}
@end

@implementation ACData
+ (NSDictionary *)modelContainerPropertyGenericClass
{
    return @{@"comments" : [EvaListItem class]};
}
@end

@implementation ArticleCommentResponseModel

@end




@implementation ArticleCommentNeedModel



@end





@implementation UDHeader

@end

@implementation UAData
+ (NSDictionary *)modelContainerPropertyGenericClass
{
    return @{@"comments" : [EvaListItem class]};
}
@end

@implementation UserArticleCommentsResponseModel


@end


@implementation MessageCenterResponseModel

+ (NSDictionary *)modelContainerPropertyGenericClass
{
    return @{@"data" : [EvaListItem class]};
}
@end










