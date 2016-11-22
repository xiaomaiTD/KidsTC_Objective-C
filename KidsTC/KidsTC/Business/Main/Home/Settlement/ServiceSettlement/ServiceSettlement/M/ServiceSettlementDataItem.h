//
//  ServiceSettlementDataItem.h
//  KidsTC
//
//  Created by 詹平 on 2016/11/21.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ServiceSettlementCouponItem.h"
#import "ServiceSettlementPayType.h"
#import "ServiceSettlementPromotion.h"
#import "UserAddressManageModel.h"
#import "SettlementPickStoreModel.h"
#import "ServiceSettlementSeat.h"
#import "ServiceSettlementShowTime.h"

typedef enum : NSUInteger {
    ServiceSettlementTakeTicketWayCar = 1,//快递
    ServiceSettlementTakeTicketWaySelf,//上门自取
} ServiceSettlementTakeTicketWay;

@interface ServiceSettlementDataItem : NSObject
@property (nonatomic, strong) NSString *channelId;
@property (nonatomic, assign) NSUInteger count;
@property (nonatomic, strong) NSArray<ServiceSettlementCouponItem *> *coupon;
@property (nonatomic, strong) NSString *imgUrl;
@property (nonatomic, strong) ServiceSettlementCouponItem *maxCoupon;
@property (nonatomic, strong) ServiceSettlementPayType *pay_type;
@property (nonatomic, strong) NSString *price;
@property (nonatomic, strong) NSString *totalPrice;
@property (nonatomic, assign) BOOL hasUserAddress;//是否需要填写收货地址
@property (nonatomic, assign) CGFloat transportationExpenses;
@property (nonatomic, strong) NSString *useValidTimeDesc;
@property (nonatomic, strong) ServiceSettlementPromotion *promotion;
@property (nonatomic, strong) UserAddressManageDataItem *userAddress;
@property (nonatomic, strong) SettlementPickStoreDataItem *store;
@property (nonatomic, assign) NSUInteger scorenum;
@property (nonatomic, assign) NSUInteger usescorenum;
@property (nonatomic, strong) NSString *serveId;
@property (nonatomic, strong) NSString *serveName;
@property (nonatomic, strong) NSString *storeName;
@property (nonatomic, strong) NSString *storeNo;
@property (nonatomic, assign) BOOL isFreightDiscount;
@property (nonatomic, assign) NSInteger minBuyNum;
@property (nonatomic, assign) NSInteger maxBuyNum;
//forTicket
@property (nonatomic, strong) NSString *theater;
@property (nonatomic, strong) NSString *payPrice;
@property (nonatomic, strong) ServiceSettlementShowTime *showTime;
@property (nonatomic, strong) NSArray<ServiceSettlementSeat *> *seats;
@property (nonatomic, assign) ServiceSettlementTakeTicketWay takeTicketWay;
@property (nonatomic, assign) BOOL isSupportExpress;//是否支持快递
@property (nonatomic, assign) BOOL isSupportSiteTickets;//是否支持上门自取

//selfDefine
@property (nonatomic, assign) ProductDetailType type;
@property (nonatomic, strong) NSAttributedString *attServiceInfo;

//ticketUser
@property (nonatomic, strong) NSString *ticketUserName;
@property (nonatomic, strong) NSString *ticketUserMobile;
@end
