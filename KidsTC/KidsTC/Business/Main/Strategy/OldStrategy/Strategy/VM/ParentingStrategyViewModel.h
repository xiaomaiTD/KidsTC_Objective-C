//
//  ParentingStrategyViewModel.h
//  KidsTC
//
//  Created by 钱烨 on 8/24/15.
//  Copyright (c) 2015 KidsTC. All rights reserved.
//


#import "ParentingStrategyView.h"
#import "ParentingStrategyFilterView.h"
#import "ParentingStrategyListItemModel.h"

@interface ParentingStrategyViewModel : NSObject

- (instancetype)initWithView:(UIView *)view;

@property (nonatomic, assign) ParentingStrategySortType currentSortType;

@property (nonatomic, assign) NSUInteger currentAreaIndex;

- (void)getMoreStrategies;

- (NSArray *)resutlStrategies;

- (void)startUpdateDataWithSucceed:(void (^)(NSDictionary *))succeed failure:(void (^)(NSError *))failure;

@end
