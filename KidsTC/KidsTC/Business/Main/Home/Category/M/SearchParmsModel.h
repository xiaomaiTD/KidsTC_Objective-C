//
//  SearchParmsItem.h
//  KidsTC
//
//  Created by zhanping on 6/28/16.
//  Copyright © 2016 KidsTC. All rights reserved.
//

#import "Model.h"

@interface SearchParmsModel : Model
@property (nonatomic, strong) NSString *k;
@end

/**
 *  资讯的搜索模型
 */
@interface SearchParmsArticleModel : SearchParmsModel
@property (nonatomic, assign) NSInteger ak;
@property (nonatomic, strong) NSString *a;
@property (nonatomic, strong) NSString *p;
@property (nonatomic, assign) NSInteger t;
+(instancetype)modelWithDic:(NSDictionary *)dic;
@end

/**
 *  服务和门店的搜索模型
 */
@interface SearchParmsProductOrStoreModel : SearchParmsModel
@property (nonatomic, strong) NSString *a;
@property (nonatomic, assign) NSInteger c;
@property (nonatomic, strong) NSString *st;
@property (nonatomic, strong) NSString *s;

@property (nonatomic, strong) NSString *mapaddr;

+(instancetype)modelWithDic:(NSDictionary *)dic;
@end
