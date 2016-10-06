//
//  HotKeywordsModel.m
//  KidsTC
//
//  Created by zhanping on 6/28/16.
//  Copyright © 2016 KidsTC. All rights reserved.
//

#import "SearchHotKeywordsModel.h"

@implementation SearchHotKeywordsListItem

@end

@implementation SearchHotKeywordsListArticleItem

@end

@implementation SearchHotKeywordsListProductOrStoreItem

@end

@implementation SearchHotKeywordsData
+ (NSDictionary *)modelContainerPropertyGenericClass
{
    return @{@"article" : [SearchHotKeywordsListArticleItem class],
             @"product" : [SearchHotKeywordsListProductOrStoreItem class],
             @"store" : [SearchHotKeywordsListProductOrStoreItem class]};
}
@end

@implementation SearchHotKeywordsModel
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"errNo":@"errno"};
}
@end
