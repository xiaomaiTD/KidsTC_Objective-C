//
//  GEnum.h
//  KidsTC
//
//  Created by 詹平 on 2016/11/10.
//  Copyright © 2016年 zhanping. All rights reserved.
//

typedef enum : NSUInteger {
    ProductDetailTypeNormal = 1,//普通商详
    ProductDetailTypeTicket,//票务商详
    ProductDetailTypeFree,//免费商详
} ProductDetailType;//商详类型

typedef enum : NSUInteger {
    CollectProductTypeAll = 1,//全部
    CollectProductTypeCategory,//分类
    CollectProductTypeReduct,//降价
} CollectProductType;

typedef enum : NSUInteger {
    ProductOrderListTypeAll = 1,//全部订单
    ProductOrderListTypeWaitPay = 2,//待付款
    ProductOrderListTypeWaiatUse = 3,//待使用
    ProductOrderListTypeWaitComment = 4,//待评价
    ProductOrderListTypeHasComment = 5,//已评价
    ProductOrderListTypeRefund = 6,//退款/售后
    ProductOrderListTypeCompleted = 7,//已完成
    ProductOrderListTypeCancled = 8,//已取消
    ProductOrderListTypeWaitRecive = 9,//待收货
} ProductOrderListType;

typedef enum : NSUInteger {
    ProductOrderListOrderTypeAll = 1,//所有
    ProductOrderListOrderTypeNormal,//普通订单（活动）
    ProductOrderListOrderTypeRealObject,//实物订单
    ProductOrderListOrderTypeTicket,//票务订单
} ProductOrderListOrderType;

typedef enum : NSUInteger {
    ProductOrderFreeListTypeFreeActivity = 1,//免费活动
    ProductOrderFreeListTypeLottery,//抽奖
} ProductOrderFreeListType;

typedef enum : NSUInteger {
    CouponListStatusUnused = 1,//未使用
    CouponListStatusUsed,//已使用
    CouponListStatusExpired,//已过期
} CouponListStatus;

typedef enum : NSUInteger {
    TCSexTypeUnkonw,//未知
    TCSexTypeBoy,//男
    TCSexTypeGirl,//女
} TCSexType;

typedef enum : NSUInteger {
    UseCouponStatusNotUse,//未使用
    UseCouponStatusUsed,//已使用
    UseCouponStatusNotArrvialTime,//未到达使用时间
    UseCouponStatusExpried//已过期
} UseCouponStatus;

typedef enum : NSUInteger {
    SearchTypeProduct,//搜索服务
    SearchTypeStore,//搜索门店
} SearchType;
