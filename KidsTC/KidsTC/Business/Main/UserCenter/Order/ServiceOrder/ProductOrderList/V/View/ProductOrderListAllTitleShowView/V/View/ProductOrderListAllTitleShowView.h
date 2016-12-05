//
//  ProductOrderListAllTitleShowView.h
//  KidsTC
//
//  Created by 詹平 on 2016/12/3.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum : NSUInteger {
    ProductOrderListAllTitleShowViewActionTypeAll = 1,//全部订单
    ProductOrderListAllTitleShowViewActionTypeCompleted,//已完成订单
    ProductOrderListAllTitleShowViewActionTypeCancled,//已取消订单
    ProductOrderListAllTitleShowViewActionTypeTicket,//票务
    ProductOrderListAllTitleShowViewActionTypeRealObject,//商品
    ProductOrderListAllTitleShowViewActionTypeActivity,//活动
    ProductOrderListAllTitleShowViewActionTypeFlash,//闪购
    ProductOrderListAllTitleShowViewActionTypeAppoinment,//我的预约,
    ProductOrderListAllTitleShowViewActionTypeRadish,//萝卜兑换
    ProductOrderListAllTitleShowViewActionTypeLottery,//我的抽奖
    ProductOrderListAllTitleShowViewActionTypeActivityRegister,//活动报名
    
    ProductOrderListAllTitleShowViewActionTypeClose = 100,//关闭
} ProductOrderListAllTitleShowViewActionType;

@class ProductOrderListAllTitleShowView;
@protocol ProductOrderListAllTitleShowViewDelegate <NSObject>
- (void)ProductOrderListAllTitleShowView:(ProductOrderListAllTitleShowView *)view actionType:(ProductOrderListAllTitleShowViewActionType)type value:(id)value;
@end

@interface ProductOrderListAllTitleShowView : UIView
@property (nonatomic, assign) BOOL open;
@property (nonatomic, weak) id<ProductOrderListAllTitleShowViewDelegate> delegate;
@end
