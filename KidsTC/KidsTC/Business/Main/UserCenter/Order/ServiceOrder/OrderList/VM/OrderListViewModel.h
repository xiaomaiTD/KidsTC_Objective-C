//
//  OrderListViewModel.h
//  KidsTC
//
//  Created by 钱烨 on 8/11/15.
//  Copyright (c) 2015 KidsTC. All rights reserved.
//

#import "OrderListView.h"
#import "OrderListModel.h"

@interface OrderListViewModel : NSObject

@property (nonatomic, assign) OrderListType orderListType;

- (NSArray *)orderModels;

- (void)getMoreOrders;

- (instancetype)initWithView:(UIView *)view;

- (void)startUpdateDataWithSucceed:(void (^)(NSDictionary *))succeed failure:(void (^)(NSError *))failure;


@end
