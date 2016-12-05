//
//  ProductOrderListAllTitleRowItem.h
//  KidsTC
//
//  Created by 詹平 on 2016/12/3.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum : NSUInteger {
    ProductOrderListAllTitleRowItemActionTypeAll = 1,//全部订单
    ProductOrderListAllTitleRowItemActionTypeCompleted,//已完成订单
    ProductOrderListAllTitleRowItemActionTypeCancled,//已取消订单
    ProductOrderListAllTitleRowItemActionTypeTicket,//票务
    ProductOrderListAllTitleRowItemActionTypeRealObject,//商品
    ProductOrderListAllTitleRowItemActionTypeActivity,//活动
    ProductOrderListAllTitleRowItemActionTypeFlash,//闪购
    ProductOrderListAllTitleRowItemActionTypeAppoinment,//我的预约,
    ProductOrderListAllTitleRowItemActionTypeRadish,//萝卜兑换
    ProductOrderListAllTitleRowItemActionTypeLottery,//我的抽奖
    ProductOrderListAllTitleRowItemActionTypeActivityRegister,//活动报名
} ProductOrderListAllTitleRowItemActionType;

@interface ProductOrderListAllTitleRowItem : NSObject
@property (nonatomic, assign) ProductOrderListAllTitleRowItemActionType actionType;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, assign) BOOL selected;
@property (nonatomic, assign) BOOL canSelected;
+(instancetype)itemWithType:(ProductOrderListAllTitleRowItemActionType)type;
@end
