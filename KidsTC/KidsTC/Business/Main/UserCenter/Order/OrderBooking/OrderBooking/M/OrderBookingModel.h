//
//  OrderBookingModel.h
//  KidsTC
//
//  Created by zhanping on 2016/9/19.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OrderBookingProductOnlineBespeakConfig : NSObject
@property (nonatomic, strong) NSString *productId;
@property (nonatomic, strong) NSString *productName;
@property (nonatomic, assign) NSUInteger advanceDay;
@property (nonatomic, strong) NSString *advanceDayDesc;
@property (nonatomic, assign) OrderBookingOnlineBespeakType bespeakType;
@property (nonatomic, assign) BOOL isBabyName;
@property (nonatomic, assign) BOOL isBabyBirthday;
@property (nonatomic, assign) BOOL isBabySex;
@property (nonatomic, assign) BOOL isHouseHoldName;
@property (nonatomic, assign) BOOL isDistrictId;
@property (nonatomic, assign) BOOL isBabyAge;
@end

@interface OrderBookingOnlineBespeakTimeItem : NSObject
@property (nonatomic, strong) NSString *startTime;
@property (nonatomic, strong) NSString *endTime;
@end

@interface OrderBookingOnlineBespeakTimeConfigItem : NSObject
@property (nonatomic, strong) NSString *startDate;
@property (nonatomic, strong) NSString *endDate;
@property (nonatomic, strong) NSArray<OrderBookingOnlineBespeakTimeItem *> *times;
@end

@interface OrderBookingTimeShowModel : NSObject
@property (nonatomic, strong) NSString *dayStr;
@property (nonatomic, strong) NSArray<NSString *> *timesAry;
@property (nonatomic, assign) NSUInteger selectIndex;
@property (nonatomic, strong) NSString *weakStr;
@property (nonatomic, assign) NSTimeInterval timeInterval;
@end

@interface OrderBookingProductInfo : NSObject
@property (nonatomic, strong) NSString *productId;
@property (nonatomic, strong) NSString *productName;
@property (nonatomic, strong) NSString *productImage;
@property (nonatomic, strong) NSString *ageGroupDesc;
@end

@interface OrderBookingStoreInfo : NSObject
@property (nonatomic, strong) NSString *storeNo;
@property (nonatomic, strong) NSString *storeName;
@property (nonatomic, strong) NSString *officeHoursDesc;
@property (nonatomic, strong) NSString *address;
@property (nonatomic, strong) NSString *longitudeLatitude;
/**selfDefine*/
@property (nonatomic, strong) NSAttributedString *storeDesc;
@end

@interface OrderBookingUserBespeakInfo : NSObject
@property (nonatomic, strong) NSString *babyName;
@property (nonatomic, strong) NSString *babyBirthday;
//@property (nonatomic, assign) <#type#> babySex;
@property (nonatomic, strong) NSString *householdName;
@property (nonatomic, strong) NSString *provinceId;
@property (nonatomic, strong) NSString *cityId;
@property (nonatomic, strong) NSString *districtId;
@property (nonatomic, assign) NSUInteger babyAge;
@end

@interface OrderBookingRemarkItem : NSObject
@property (nonatomic, strong) NSString *remark;
@property (nonatomic, strong) NSString *time;
@end

@interface OrderBookingData : NSObject
@property (nonatomic, strong) OrderBookingProductOnlineBespeakConfig *productOnlineBespeakConfig;
@property (nonatomic, strong) NSArray<OrderBookingOnlineBespeakTimeConfigItem *> *onlineBespeakTimeConfig;
@property (nonatomic, strong) NSString *recommendOnlineBespeakTime;
@property (nonatomic, strong) OrderBookingProductInfo *productInfo;
@property (nonatomic, strong) OrderBookingStoreInfo *storeInfo;
@property (nonatomic, strong) OrderBookingUserBespeakInfo *userBespeakInfo;
@property (nonatomic, strong) NSString *orderNo;
@property (nonatomic, assign) NSInteger uid;
@property (nonatomic, assign) NSInteger bespeakTimeCountLimit;
@property (nonatomic, strong) NSString *bespeakTimeDesc;
@property (nonatomic, strong) OrderBookingOnlineBespeakTimeConfigItem *bespeakTime;
@property (nonatomic, strong) NSArray<OrderBookingRemarkItem *> *supplierRemark;
@property (nonatomic, strong) NSArray<OrderBookingRemarkItem *> *userRemark;
@property (nonatomic, assign) OrderBookingBespeakStatus bespeakStatus;
@property (nonatomic, strong) NSString *bespeakStatusDesc;
@property (nonatomic, assign) ProductDetailType productRedirect;
/**selfDefine*/
@property (nonatomic, strong) NSAttributedString *supplierRemarkStr;
@property (nonatomic, strong) NSAttributedString *userRemarkStr;
@property (nonatomic, strong) OrderBookingTimeShowModel *currentTimeShowModel;
@property (nonatomic, strong) NSArray<OrderBookingTimeShowModel *> *timeShowModels;
@end

@interface OrderBookingModel : NSObject
@property (nonatomic, assign) NSInteger errNo;
@property (nonatomic, strong) OrderBookingData *data;
@end
