//
//  SearchHotKeywordsData.h
//  KidsTC
//
//  Created by 詹平 on 2016/12/6.
//  Copyright © 2016年 zhanping. All rights reserved.
//
#import "Model.h"
#import "SearchHotKeywordsItem.h"

@interface SearchHotKeywordsData : Model
@property (nonatomic, strong) NSArray<SearchHotKeywordsItem *> *location;
@property (nonatomic, strong) NSArray<SearchHotKeywordsItem *> *product;
@property (nonatomic, strong) NSArray<SearchHotKeywordsItem *> *store;
@end
