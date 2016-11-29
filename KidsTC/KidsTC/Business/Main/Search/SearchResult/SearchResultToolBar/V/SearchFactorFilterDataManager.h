//
//  SearchFactorFilterDataManager.h
//  KidsTC
//
//  Created by 詹平 on 2016/11/29.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "SearchFactorFilterDataItemLefe.h"
#import "Single.h"

@interface SearchFactorFilterDataManager : NSObject
singleH(SearchFactorFilterDataManager)
@property (nonatomic, strong) NSArray<NSArray<SearchFactorFilterDataItemLefe *> *> *filters;
@end
