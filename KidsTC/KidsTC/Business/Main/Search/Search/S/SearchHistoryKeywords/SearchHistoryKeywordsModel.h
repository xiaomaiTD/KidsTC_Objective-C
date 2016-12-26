//
//  SearchHistoryKeywordsModel.h
//  KidsTC
//
//  Created by zhanping on 6/28/16.
//  Copyright © 2016 KidsTC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SearchHotKeywordsItem.h"
@interface SearchHistoryKeywordsModel : NSObject<NSCoding>
@property (nonatomic, strong) NSMutableArray<SearchHotKeywordsItem *> *history;
@end
