//
//  ServiceSettlementModel.h
//  KidsTC
//
//  Created by zhanping on 8/11/16.
//  Copyright © 2016 詹平. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserAddressManageModel.h"
#import "SettlementPickStoreModel.h"

@interface ServiceSettlementCouponItem : NSObject
@property (nonatomic, strong) NSString  *name;
@property (nonatomic, strong) NSString  *code;
@property (nonatomic, strong) NSString  *desc;
@property (nonatomic, assign) CGFloat   couponAmt;
@property (nonatomic, assign) CGFloat   fiftyAmt;
@property (nonatomic, assign) NSInteger status;
@property (nonatomic, strong) NSString  *statusName;
@property (nonatomic, strong) NSString  *fetchTime;
@property (nonatomic, strong) NSString  *startTime;
@property (nonatomic, strong) NSString  *endTime;

@property (nonatomic, assign) BOOL selected;
@end

@interface ServiceSettlementPayType : NSObject
@property (nonatomic, assign) BOOL ali;
@property (nonatomic, assign) BOOL WeChat;
@end

@interface ServiceSettlementPromotion : NSObject
@property (nonatomic, strong) NSString *promotionId;
@property (nonatomic, strong) NSString *fullcutdesc;
@property (nonatomic, assign) CGFloat fiftyamt;
@property (nonatomic, assign) CGFloat promotionamt;
@end

@interface ServiceSettlementDataItem : NSObject
@property (nonatomic, strong) NSString *channelId;
@property (nonatomic, assign) NSUInteger count;
@property (nonatomic, strong) NSArray<ServiceSettlementCouponItem *> *coupon;
@property (nonatomic, strong) NSString *imgUrl;
@property (nonatomic, strong) ServiceSettlementCouponItem *maxCoupon;
@property (nonatomic, strong) ServiceSettlementPayType *pay_type;
@property (nonatomic, assign) CGFloat price;
@property (nonatomic, assign) CGFloat totalPrice;
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
@end

@interface ServiceSettlementModel : NSObject
@property (nonatomic, assign) NSInteger errNo;
@property (nonatomic, strong) NSArray<ServiceSettlementDataItem *> *data;
@property (nonatomic, strong) NSString *soleid;
@end


