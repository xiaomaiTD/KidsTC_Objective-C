//
//  SearchFactorSortDataManager.h
//  KidsTC
//
//  Created by 詹平 on 2016/11/29.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "SearchFactorSortDataItem.h"
#import "Single.h"

@interface SearchFactorSortDataManager : NSObject
singleH(SearchFactorSortDataManager)
@property (nonatomic, strong) NSArray<SearchFactorSortDataItem *> *items;
@end
