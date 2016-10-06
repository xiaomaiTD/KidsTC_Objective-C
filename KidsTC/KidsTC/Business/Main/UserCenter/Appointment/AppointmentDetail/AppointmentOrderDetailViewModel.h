//
//  AppointmentOrderDetailViewModel.h
//  KidsTC
//
//  Created by 钱烨 on 8/12/15.
//  Copyright (c) 2015 KidsTC. All rights reserved.
//

#import "AppointmentOrderDetailView.h"

@interface AppointmentOrderDetailViewModel : NSObject

@property (nonatomic, strong) AppointmentOrderModel *orderModel;
- (instancetype)initWithView:(UIView *)view;
- (void)cancelOrderWithSucceed:(void(^)())succeed failure:(void(^)(NSError *error))failure;
- (void)startUpdateDataWithSucceed:(void (^)(NSDictionary *))succeed failure:(void (^)(NSError *))failure;
@end
