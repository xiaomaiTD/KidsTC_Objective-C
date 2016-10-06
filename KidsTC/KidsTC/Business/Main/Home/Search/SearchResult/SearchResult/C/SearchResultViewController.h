//
//  SearchResultViewController.h
//  KidsTC
//
//  Created by zhanping on 6/29/16.
//  Copyright © 2016 KidsTC. All rights reserved.
//

#import "ViewController.h"
#import "SearchParmsModel.h"
#import "SearchHistoryKeywordsManager.h"

@interface SearchResultViewController : ViewController
@property (nonatomic, strong) SearchParmsModel *searchParmsModel;
@property (nonatomic, assign) SearchType searchType;
@end
