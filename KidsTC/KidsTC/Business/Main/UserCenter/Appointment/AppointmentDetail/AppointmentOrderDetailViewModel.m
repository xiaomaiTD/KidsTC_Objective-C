//
//  AppointmentOrderDetailViewModel.m
//  KidsTC
//
//  Created by 钱烨 on 8/12/15.
//  Copyright (c) 2015 KidsTC. All rights reserved.
//

#import "AppointmentOrderDetailViewModel.h"
#import "GHeader.h"

@interface AppointmentOrderDetailViewModel () <AppointmentOrderDetailViewDataSource>

@property (nonatomic, weak) AppointmentOrderDetailView *view;

- (void)cancelOrderSucceed:(NSDictionary *)data;

- (void)cancelOrderFailed:(NSError *)error;

@end

@implementation AppointmentOrderDetailViewModel

- (instancetype)initWithView:(UIView *)view {
    self = [super init];
    if (self) {
        self.view = (AppointmentOrderDetailView *)view;
        self.view.dataSource = self;
    }
    return self;
}

#pragma mark AppointmentOrderDetailViewDataSource

- (AppointmentOrderModel *)orderModelForAppointmentOrderDetailView:(AppointmentOrderDetailView *)detailView {
    return self.orderModel;
}

#pragma mark Private methods

- (void)cancelOrderSucceed:(NSDictionary *)data {
    
}

- (void)cancelOrderFailed:(NSError *)error {
    
}

#pragma mark Public methods

- (void)cancelOrderWithSucceed:(void (^)())succeed failure:(void (^)(NSError *))failure {
    NSDictionary *param = [NSDictionary dictionaryWithObject:self.orderModel.orderId forKey:@"orderId"];
    [Request startWithName:@"ORDER_CANCLE_APPOINTMENTORDER" param:param progress:nil success:^(NSURLSessionDataTask *task, NSDictionary *dic) {
        [self cancelOrderSucceed:dic];
        if (succeed) succeed();
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if (failure) failure(error);
    }];

}

#pragma mark Super methods

- (void)startUpdateDataWithSucceed:(void (^)(NSDictionary *))succeed failure:(void (^)(NSError *))failure {
    [self.view reloadData];
}

@end
