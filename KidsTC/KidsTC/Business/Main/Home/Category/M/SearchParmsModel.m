//
//  SearchParmsItem.m
//  KidsTC
//
//  Created by zhanping on 6/28/16.
//  Copyright © 2016 KidsTC. All rights reserved.
//

#import "SearchParmsModel.h"
#import "YYKit.h"

@implementation SearchParmsModel

@end

@implementation SearchParmsArticleModel
+(instancetype)modelWithDic:(NSDictionary *)dic{
    return [SearchParmsArticleModel modelWithDictionary:dic];
}
@end

@implementation SearchParmsProductOrStoreModel
+(instancetype)modelWithDic:(NSDictionary *)dic{
    return [SearchParmsProductOrStoreModel modelWithDictionary:dic];
}
@end
