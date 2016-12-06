//
//  ProductOrderFreeListItem.h
//  KidsTC
//
//  Created by 詹平 on 2016/12/5.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ProductOrderFreeListStore.h"
#import "ProductOrderFreeListBooking.h"

@interface ProductOrderFreeListItem : NSObject
@property (nonatomic, strong) NSString *orderNo;
@property (nonatomic, strong) NSString *productSysNo;
@property (nonatomic, assign) NSInteger productType;
@property (nonatomic, assign) ProductOrderFreeListType freeType;
@property (nonatomic, strong) NSString *productName;
@property (nonatomic, strong) NSString *channelId;
@property (nonatomic, strong) NSString *productImg;
@property (nonatomic, strong) ProductOrderFreeListStore *storeInfo;
//@property (nonatomic, strong) NSString *LotteryTime;
@property (nonatomic, strong) NSString *joinCount;
//@property (nonatomic, strong) NSString *productStatus;
@property (nonatomic, strong) NSString *productStatusStr;
@property (nonatomic, strong) NSString *startTime;
@property (nonatomic, assign) BOOL isShowCountDown;
@property (nonatomic, assign) NSTimeInterval countDownValue;
@property (nonatomic, strong) NSString *rowCreateTime;
@property (nonatomic, strong) ProductOrderFreeListBooking *onlineBespeak;
@property (nonatomic, assign) BOOL isLottery;
@property (nonatomic, assign) BOOL isCanOnlineBespeak;
@property (nonatomic, assign) BOOL isCanComment;
//@property (nonatomic, strong) NSString *orderStatus;

//selfDefine
@property (nonatomic, strong) NSString *countDownValueString;
@property (nonatomic, strong) NSArray<NSString *> *supplierPhones;
@end