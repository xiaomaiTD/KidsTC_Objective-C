//
//  SearchModel.h
//  KidsTC
//
//  Created by 詹平 on 2016/12/6.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SearchHotKeywordsManager.h"
#import "SearchHistoryKeywordsManager.h"
#import "SearchSectionItem.h"

@interface SearchModel : NSObject
singleH(SearchModel)
@property (nonatomic, strong) NSArray<SearchSectionItem *> *sections;
@property (nonatomic, assign) BOOL isHasHistory;
@end
