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
#import "SegueModel.h"
#import "ProductOrderFreeDetailCountDown.h"

@interface ProductOrderFreeDetailData : NSObject
@property (nonatomic, strong) ProductDetailTime *time;
@property (nonatomic, strong) NSString *ageStr;
@property (nonatomic, strong) NSString *orderNo;
@property (nonatomic, strong) NSString *productSysNo;
@property (nonatomic, assign) NSInteger productType;
@property (nonatomic, assign) NSInteger commentType;
@property (nonatomic, assign) FreeType freeType;
@property (nonatomic, strong) NSString *freeTypeStr;
@property (nonatomic, strong) NSString *productName;
@property (nonatomic, strong) NSString *channelId;
@property (nonatomic, strong) NSString *productImg;
@property (nonatomic, assign) PlaceType placeType;
@property (nonatomic, strong) ProductOrderFreeDetailStore *storeInfo;
@property (nonatomic, strong) NSString *LotteryTime;
@property (nonatomic, strong) NSString *joinCount;
@property (nonatomic, assign) NSInteger productStatus;
@property (nonatomic, strong) NSString *productStatusStr;
@property (nonatomic, strong) NSString *startTime;
@property (nonatomic, strong) NSString *startTimeStr;
@property (nonatomic, strong) ProductOrderFreeDetailCountDown *countDown;
@property (nonatomic, strong) NSString *rowCreateTime;
@property (nonatomic, strong) ProductOrderFreeDetailBooking *onlineBespeak;
@property (nonatomic, assign) BOOL isLottery;//是否中奖
@property (nonatomic, assign) BOOL isStartLottery;//是否开奖了
@property (nonatomic, assign) BOOL isCanOnlineBespeak;
@property (nonatomic, assign) BOOL isCanComment;
@property (nonatomic, strong) NSArray<NSNumber *> *orderBtns;
@property (nonatomic, assign) ProductOrderFreeDetailBtnType defaultBtn;
@property (nonatomic, assign) OrderState orderStatus;
@property (nonatomic, strong) NSString *userRemark;
@property (nonatomic, strong) NSString *supplierMobie;
@property (nonatomic, strong) NSString *noticePageUrl;
//selfDefine
@property (nonatomic, strong) NSString *countDownValueString;
@property (nonatomic, strong) NSAttributedString *userRemarkStr;
@property (nonatomic, strong) NSArray<NSString *> *supplierPhones;
@property (nonatomic, strong) NSArray<ProductOrderFreeDetailBtn *> *btns;
@property (nonatomic, strong) SegueModel *segueModel;
@end
