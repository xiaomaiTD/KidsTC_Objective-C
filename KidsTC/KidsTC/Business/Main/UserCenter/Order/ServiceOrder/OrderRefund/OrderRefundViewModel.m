//
//  OrderRefundViewModel.m
//  KidsTC
//
//  Created by Altair on 11/28/15.
//  Copyright © 2015 KidsTC. All rights reserved.
//

#import "OrderRefundViewModel.h"
#import "NSString+Category.h"
#import "GHeader.h"

@interface OrderRefundViewModel () <OrderRefundViewDataSource>

@property (nonatomic, weak) OrderRefundView *view;

@property (nonatomic, copy) NSString *soleId;

- (void)loadRefundSucceed:(NSDictionary *)data;

- (void)loadRefundFailed:(NSError *)error;

- (void)createRefundSucceed:(NSDictionary *)data;

- (void)createRefundFailed:(NSError *)error;

@end

@implementation OrderRefundViewModel

- (instancetype)initWithView:(UIView *)view {
    self = [super init];
    if (self) {
        self.view = (OrderRefundView *)view;
        self.view.dataSource = self;
        self.refundModel = [[OrderRefundModel alloc] init];
        self.soleId = [NSString generateSMSCodeKey];
    }
    return self;
}

#pragma mark SoftwareSettingViewDataSource

- (OrderRefundModel *)refundModelForOrderRefundView:(OrderRefundView *)view {
    return self.refundModel;
}

#pragma mark Private methods

- (void)loadRefundSucceed:(NSDictionary *)data {
    NSDictionary *refundData = [data objectForKey:@"data"];
    if (![self.refundModel fillWithRawData:refundData]) {
        _refundModel = nil;
    }
    [self.view reloadData];
}

- (void)loadRefundFailed:(NSError *)error {
    _refundModel = nil;
}

- (void)createRefundSucceed:(NSDictionary *)data {
    
}

- (void)createRefundFailed:(NSError *)error {
    
}

#pragma mark Public methods

- (void)createOrderRefundWithSucceed:(void (^)(NSDictionary *))succeed failure:(void (^)(NSError *))failure {
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:
                           self.refundModel.orderId, @"orderid",
                           self.soleId, @"soleid",
                           self.refundModel.refundDescription, @"reason",
                           self.refundModel.selectedReasonItem.identifier, @"type",
                           [NSNumber numberWithInteger:self.refundModel.refundCount], @"refundNum", nil];
    [Request startWithName:@"ORDER_CREATE_REFUND" param:param progress:nil success:^(NSURLSessionDataTask *task, NSDictionary *dic) {
        [self createRefundSucceed:dic];
        if (succeed) succeed(dic);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [self createRefundFailed:error];
        if (failure) failure(error);
    }];
}

#pragma mark Super methods

- (void)startUpdateDataWithSucceed:(void (^)(NSDictionary *))succeed failure:(void (^)(NSError *))failure {
    NSDictionary *param = [NSDictionary dictionaryWithObject:self.refundModel.orderId forKey:@"orderId"];
    [Request startWithName:@"ORDER_GET_USER_REFUND" param:param progress:nil success:^(NSURLSessionDataTask *task, NSDictionary *dic) {
        [self loadRefundSucceed:dic];
        if (succeed) succeed(dic);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [self loadRefundFailed:error];
        if (failure) failure(error);
    }];
}


@end
