//
//  CouponListViewModel.h
//  KidsTC
//
//  Created by 钱烨 on 9/6/15.
//  Copyright (c) 2015 KidsTC. All rights reserved.
//


#import "CouponListView.h"
#import "ServiceListItemModel.h"

@interface CouponListViewModel : NSObject

- (void)startUpdateDataWithViewTag:(CouponListViewTag)tag;

- (void)getMoreDataWithViewTag:(CouponListViewTag)tag;

- (void)resetResultWithViewTag:(CouponListViewTag)tag;

- (NSArray *)resultOfCurrentViewTag;

- (instancetype)initWithView:(UIView *)view;

@end
