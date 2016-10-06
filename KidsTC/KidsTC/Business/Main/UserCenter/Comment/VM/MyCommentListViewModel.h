//
//  MyCommentListViewModel.h
//  KidsTC
//
//  Created by Altair on 12/1/15.
//  Copyright © 2015 KidsTC. All rights reserved.
//


#import "MyCommentListView.h"
#import "MyCommentListItemModel.h"

@interface MyCommentListViewModel : NSObject

- (instancetype)initWithView:(UIView *)view;

- (void)getMoreDataWithSucceed:(void (^)(NSDictionary *data))succeed failure:(void (^)(NSError *error))failure;


- (void)startUpdateDataWithSucceed:(void (^)(NSDictionary *))succeed failure:(void (^)(NSError *))failure;

- (NSArray *)resultArray;

@end
