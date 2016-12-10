//
//  ProductOrderFreeDetailData.h
//  KidsTC
//
//  Created by 詹平 on 2016/12/10.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ProductOrderFreeDetailStore.h"
#import "ProductOrderFreeDetailBooking.h"
#import "ProductOrderFreeDetailBtn.h"
#import "ProductDetailTime.h"

@interface ProductOrderFreeDetailData : NSObject
@property (nonatomic, strong) ProductDetailTime *time;
@property (nonatomic, strong) NSString *ageStr;
@property (nonatomic, strong) NSString *orderNo;
@property (nonatomic, strong) NSString *productSysNo;
@property (nonatomic, assign) NSInteger productType;
@property (nonatomic, assign) NSInteger commentType;
@property (nonatomic, assign) ProductOrderFreeListType freeType;
@property (nonatomic, strong) NSString *freeTypeStr;
@property (nonatomic, strong) NSString *productName;
@property (nonatomic, strong) NSString *channelId;
@property (nonatomic, strong) NSString *productImg;
@property (nonatomic, strong) ProductOrderFreeDetailStore *storeInfo;
@property (nonatomic, strong) NSString *LotteryTime;
@property (nonatomic, strong) NSString *joinCount;
@property (nonatomic, assign) NSInteger productStatus;
@property (nonatomic, strong) NSString *productStatusStr;
@property (nonatomic, strong) NSString *startTime;
@property (nonatomic, strong) NSString *startTimeStr;
@property (nonatomic, assign) BOOL isShowCountDown;
@property (nonatomic, assign) NSTimeInterval countDownValue;
@property (nonatomic, strong) NSString *countDownText;
@property (nonatomic, strong) NSString *rowCreateTime;
@property (nonatomic, strong) ProductOrderFreeDetailBooking *onlineBespeak;
@property (nonatomic, assign) BOOL isLottery;
@property (nonatomic, assign) BOOL isCanOnlineBespeak;
@property (nonatomic, assign) BOOL isCanComment;
@property (nonatomic, strong) NSArray<NSNumber *> *orderBtns;
@property (nonatomic, assign) ProductOrderFreeDetailBtnType defaultBtn;
@property (nonatomic, assign) NSInteger orderStatus;
//selfDefine
@property (nonatomic, strong) NSString *countDownValueString;
@property (nonatomic, strong) NSArray<NSString *> *supplierPhones;
@property (nonatomic, strong) NSArray<ProductOrderFreeDetailBtn *> *btns;
@end
