//
//  OrderRefundViewModel.h
//  KidsTC
//
//  Created by Altair on 11/28/15.
//  Copyright © 2015 KidsTC. All rights reserved.
//

#import "OrderRefundView.h"

@interface OrderRefundViewModel : NSObject

@property (nonatomic, strong) OrderRefundModel *refundModel;
- (instancetype)initWithView:(UIView *)view;
- (void)createOrderRefundWithSucceed:(void (^)(NSDictionary *data))succeed failure:(void (^)(NSError *error))failure;
- (void)startUpdateDataWithSucceed:(void (^)(NSDictionary *))succeed failure:(void (^)(NSError *))failure;
@end
