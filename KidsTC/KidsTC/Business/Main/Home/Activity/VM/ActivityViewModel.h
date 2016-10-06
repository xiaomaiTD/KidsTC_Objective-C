//
//  ActivityViewModel.h
//  KidsTC
//
//  Created by 钱烨 on 10/12/15.
//  Copyright © 2015 KidsTC. All rights reserved.
//

#import "ActivityView.h"

@interface ActivityViewModel : NSObject

@property (nonatomic, strong) ActivityFiltItem *currentCategoryItem;

@property (nonatomic, strong) ActivityFiltItem *currentAreaItem;

- (instancetype)initWithView:(UIView *)view;

- (void)getCategoryDataWithSucceed:(void (^)(NSDictionary *data))succeed failure:(void (^)(NSError *error))failure;

- (void)startUpdateDataWithSucceed:(void (^)(NSDictionary *))succeed failure:(void (^)(NSError *))failure;

- (NSArray *)resultArray;

- (void)getMoreDataWithSucceed:(void (^)(NSDictionary *data))succeed failure:(void (^)(NSError *error))failure;

@end
