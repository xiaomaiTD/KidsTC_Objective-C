//
//  SearchTypeItem.h
//  KidsTC
//
//  Created by 詹平 on 16/6/29.
//  Copyright © 2016年 KidsTC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SearchHotKeywordsModel.h"
#import "SearchHistoryKeywordsModel.h"

@interface SearchTypeItem : NSObject
@property (nonatomic, assign) SearchType searchType;
@property (nonatomic, strong) NSString *searchTypeTitle;
@property (nonatomic, strong) NSString *placeHolder;
+(NSArray<SearchTypeItem *> *)searchTypeItemArrayWith:(SearchHotKeywordsModel *)searchHotKeywordsModel;
@end
