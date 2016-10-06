//
//  HotKeywordsModel.h
//  KidsTC
//
//  Created by zhanping on 6/28/16.
//  Copyright © 2016 KidsTC. All rights reserved.
//

#import "Model.h"
#import "SearchParmsModel.h"

/**
 *  热门关键字模型
 */
@interface SearchHotKeywordsListItem : Model
@property (nonatomic, strong) NSString *name;
@end

/**
 *  资讯的热门关键字模型
 */
@interface SearchHotKeywordsListArticleItem : SearchHotKeywordsListItem
@property (nonatomic, strong) SearchParmsArticleModel *search_parms;
@end

/**
 *  服务或门店的热门关键字模型
 */
@interface SearchHotKeywordsListProductOrStoreItem : SearchHotKeywordsListItem
@property (nonatomic, strong) SearchParmsProductOrStoreModel *search_parms;
@end

@interface SearchHotKeywordsData : Model
@property (nonatomic, strong) NSArray<SearchHotKeywordsListArticleItem *> *article;
@property (nonatomic, strong) NSArray<SearchHotKeywordsListProductOrStoreItem *> *product;
@property (nonatomic, strong) NSArray<SearchHotKeywordsListProductOrStoreItem *> *store;
@end

@interface SearchHotKeywordsModel : Model
@property (nonatomic, strong) SearchHotKeywordsData *data;
@property (nonatomic, assign) NSInteger errNo;
@property (nonatomic, strong) NSString *md5;
@end
