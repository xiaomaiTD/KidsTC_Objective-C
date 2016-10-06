//
//  FlashSettlementModel.h
//  KidsTC
//
//  Created by zhanping on 8/16/16.
//  Copyright © 2016 詹平. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserAddressManageModel.h"
#import "SettlementPickStoreModel.h"

@interface FlashSettlementPayChannel : NSObject
@property (nonatomic, assign) BOOL ali;
@property (nonatomic, assign) BOOL WeChat;
@end

@interface FlashSettlementPriceConfig : NSObject
@property (nonatomic, assign) NSUInteger peopleNum;
@property (nonatomic, assign) CGFloat price;
@property (nonatomic, assign) NSInteger priceStatus;
@property (nonatomic, strong) NSString *priceStatusName;
@end

@interface FlashSettlementData : NSObject
@property (nonatomic, strong) NSString *orderNo;
@property (nonatomic, assign) NSUInteger maxScoreNum;
@property (nonatomic, strong) NSString *fsSysNo;
@property (nonatomic, strong) NSString *productNo;
@property (nonatomic, strong) NSString *productName;
@property (nonatomic, assign) NSString *storeNo;
@property (nonatomic, strong) NSString *storeName;
@property (nonatomic, assign) CGFloat price;
@property (nonatomic, strong) FlashSettlementPayChannel *payChannel;
@property (nonatomic, strong) NSString *imgUrl;
@property (nonatomic, strong) NSArray<FlashSettlementPriceConfig *> *priceConfigLs;
@property (nonatomic, strong) NSString *prepaidRuleLinkUrl;
@property (nonatomic, strong) UserAddressManageDataItem *userAddress;
@property (nonatomic, strong) SettlementPickStoreDataItem *storeInfo;
@property (nonatomic, assign) BOOL hasUserAddress;//是否需要填写收货地址
@property (nonatomic, assign) CGFloat transportationExpenses;
@property (nonatomic, strong) NSString *useValidTimeDesc;
@property (nonatomic, assign) BOOL isFreightDiscount;
/**selfDefine*/
@property (nonatomic, assign) NSUInteger useScoreNum;
@end

@interface FlashSettlementModel : NSObject
@property (nonatomic, assign) NSInteger errNo;
@property (nonatomic, strong) FlashSettlementData *data;
@property (nonatomic, strong) NSString *soleid;
@end
