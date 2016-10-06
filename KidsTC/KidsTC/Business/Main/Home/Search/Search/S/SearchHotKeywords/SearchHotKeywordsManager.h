//
//  SearchHotKeywordsManager.h
//  KidsTC
//
//  Created by zhanping on 6/28/16.
//  Copyright © 2016 KidsTC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SearchHotKeywordsModel.h"
#import "GHeader.h"
@interface SearchHotKeywordsManager : NSObject
singleH(SearchHotKeywordsManager)
@property (nonatomic, strong) SearchHotKeywordsModel *model;
- (void)synchronize;
@end
