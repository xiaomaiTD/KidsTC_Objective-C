//
//  Article.m
//  KidsTC
//
//  Created by zhanping on 4/13/16.
//  Copyright © 2016 KidsTC. All rights reserved.
//

#import "ArticleModel.h"

@implementation AITagsItem
@end

@implementation AIProductsItem
@end

@implementation ALstItem
+ (NSDictionary *)modelContainerPropertyGenericClass
{
    return @{@"banners" : [AHBannersItem class],
             @"imgPicUrls" : [NSString class],
             @"products" :[AIProductsItem class],
             @"tags" : [AITagsItem class]};
}
@end

@implementation AHBannersItem
@end

@implementation ACTagsItem
+ (NSDictionary *)modelCustomPropertyMapper
{
    return @{@"ID" : @"id"};
}
@end
@implementation AHColumnTitle
+ (NSDictionary *)modelContainerPropertyGenericClass
{
    return @{@"tags" : [ACTagsItem class]};
}
@end

@implementation AHAlbumEntrysItem
@end

@implementation AHeader
+ (NSDictionary *)modelContainerPropertyGenericClass
{
    return @{@"banners" : [AHBannersItem class],
             @"columnEntrys" : [AHAlbumEntrysItem class],
             @"albumEntrys" : [AHAlbumEntrysItem class]};
}
@end

@implementation AData
+ (NSDictionary *)modelContainerPropertyGenericClass
{
    return @{
             @"articleLst" : [ALstItem class]
             };
}

@end

@implementation ArticleResponse
@end


@implementation ADHeader

@end


@implementation ALData
+ (NSDictionary *)modelContainerPropertyGenericClass
{
    return @{@"article" : [ALstItem class]};
}
@end

@implementation ArticleLikeResponse

@end


@implementation ArticleCollectionResponse
+ (NSDictionary *)modelContainerPropertyGenericClass
{
    return @{@"data" : [ALstItem class]};
}

@end


/**
 *  user_base_info
 */
@implementation UBData

@end

@implementation UserBaseInfoResponse

@end

