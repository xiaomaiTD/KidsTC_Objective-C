//
//  HomeDataManager.h
//  KidsTC
//
//  Created by ling on 16/7/18.
//  Copyright © 2016年 詹平. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GHeader.h"
#import "HomeModel.h"
@interface HomeDataManager : NSObject

@property (nonatomic, strong) HomeModel *homeModel;
@property (nonatomic, assign) BOOL noMoreData;
@property (nonatomic, strong) NSArray *dataArr;
@property (nonatomic, strong) UIViewController *targetVc;
singleH(HomeDataManager)
- (void)refreshHomeDataWithSucceed:(void(^)(NSDictionary *data))succeed failure:(void(^)(NSError *error))failure;
- (void)getCustomerRecommendWithSucceed:(void(^)(NSDictionary *data))succeed failure:(void(^)(NSError *error))failure;
@end
