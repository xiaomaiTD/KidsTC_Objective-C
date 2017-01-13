//
//  GEnum.h
//  KidsTC
//
//  Created by 詹平 on 2016/11/10.
//  Copyright © 2016年 zhanping. All rights reserved.
//

typedef enum : NSUInteger {
    ProductDetailTypeNormal = 1,//普通商详
    ProductDetailTypeTicket = 2,//票务商详
    ProductDetailTypeFree = 3,//免费商详
    ProductDetailTypeWholesale = 4,//拼团商详
    ProductDetailTypeRadish = 5,//萝卜商详
    ProductDetailTypeFalsh = 6,//闪购商品详情
} ProductDetailType;//商详类型

typedef enum : NSUInteger {
    PriceSortPlatForm = 1,//童成专享价
    PriceSortPromotion = 2,//童成专享促销
    PriceSortGroup = 3,//童成专享团购
    PriceSortSecKill = 4,//童成专享秒杀
} PriceSort;

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
    OrderKindNormal = 1,//普通订单
    OrderKindFlash = 2,//闪购订单
    OrderKindRadish = 3,/// 萝卜订单
    OrderKindTicket = 4,/// 票务订单
    OrderKindFree = 5,/// 免费商品报名订单
    OrderKindFight = 6,/// 拼团
} OrderKind;

typedef enum : NSUInteger {
    OrderStateWaitPay=1,//待付款
    OrderStateWaitUse,//待使用
    OrderStatePartUse,//部分使用
    OrderStateWaitComment,//待评价
    OrderStateCanceled,//订单已取消
    OrderStateRefunding,//退款中
    OrderStateRefundSuccess,//退款成功
    OrderStateRefundFailure,//退款失败
    OrderStateHasComment,//已评价
    OrderStateHasOverTime,//已过期
} OrderState;

typedef enum : NSUInteger {
    FreeTypeFreeActivity = 1,//免费活动
    FreeTypeLottery,//抽奖
} FreeType;

typedef enum : NSUInteger {
    SearchResultProductTypeService = 1,//服务
    SearchResultProductTypeActivity,//活动
    SearchResultProductTypeMaterialObject,//实物
} SearchResultProductType;

typedef enum : NSInteger {
    SearchResultProductStatusUnder = -1,//已下架
    SearchResultProductStatusInitial = 0,//初始
    SearchResultProductStatusPublished = 1,//已上架
    SearchResultProductStatusSlodOut = 2,//已售罄
    SearchResultProductStatusNoStore = 3,//没有门店-暂不销售
    SearchResultProductStatusNotStart = 4,//即将开始
    SearchResultProductStatusFinished = 5,//已经结束-暂不销售
} SearchResultProductStatus;

typedef enum : NSUInteger {
    OrderBookingOnlineBespeakTypeNeed=1,//需要预约
    OrderBookingOnlineBespeakTypeNoNeed,//不需要预约
} OrderBookingOnlineBespeakType;

typedef enum : NSUInteger {
    OrderBookingBespeakStatusNoCanBespeak=1,//不可预约
    OrderBookingBespeakStatusCanBespeak,//可预约
    OrderBookingBespeakStatusBespeaking,//预约中
    OrderBookingBespeakStatusBespeakFail,//预约失败
    OrderBookingBespeakStatusBespeakSuccess,//预约成功
    OrderBookingBespeakStatusCancle,//已取消
} OrderBookingBespeakStatus;

typedef enum : NSUInteger {
    CouponListStatusUnused = 1,//未使用
    CouponListStatusUsed,//已使用
    CouponListStatusExpired,//已过期
} CouponListStatus;

typedef enum : NSUInteger {
    NurseryTypeNursery = 1, //育婴室
    NurseryTypeExhibitionHall,//展览馆
    NurseryTypeClander,//日历
} NurseryType;

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

typedef enum : NSUInteger {
    PlaceTypeStore = 1,//门店
    PlaceTypePlace = 2,//场地
    PlaceTypeNone = 3,//不显示地址
} PlaceType;

typedef enum : NSUInteger {
    RecommendProductTypeDefault = 1,//默认
    RecommendProductTypeUserCenter = 2,//个人中心
    RecommendProductTypeCollect = 3,//个人中心收藏页面
    RecommendProductTypeOrderList = 4,//订单列表
    RecommendProductTypeTicket = 5,//票务服务
    RecommendProductTypeNormal = 6,//普通服务
    RecommendProductTypeFree = 7,//免费
    RecommendProductTypeRadish = 8,//萝卜
} RecommendProductType;

typedef enum : NSUInteger {
    OrderRemindTypeTip = 1,//提醒
    OrderRemindTypeCancle = 2,//取消
} OrderRemindType;

typedef enum : NSUInteger {
    SettlementResultTypeService=1,//非闪购
    SettlementResultTypeFlash,//闪购
} SettlementResultType;//支付结果页类型

























