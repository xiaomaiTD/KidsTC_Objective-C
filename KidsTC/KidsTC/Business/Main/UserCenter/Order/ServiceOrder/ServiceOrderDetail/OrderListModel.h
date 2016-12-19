//
//  OrderListModel.h
//  KidsTC
//
//  Created by 钱烨 on 7/25/15.
//  Copyright (c) 2015 KidsTC. All rights reserved.
//

#import "OrderModel.h"

typedef enum {
    OrderListTypeAll = 1,//所有订单
    OrderListTypeWaitingPayment,//待支付
    OrderListTypeWaitingUse,//待使用
    OrderListTypeWaitingComment,//待评论
    OrderListTypeHasCommented,//已评论
    OrderListTypeRefund//退款/售后
}OrderListType;

@interface OrderListModel : OrderModel

- (instancetype)initWithRawData:(NSDictionary *)data;

- (CGFloat)cellHeight;

@end
