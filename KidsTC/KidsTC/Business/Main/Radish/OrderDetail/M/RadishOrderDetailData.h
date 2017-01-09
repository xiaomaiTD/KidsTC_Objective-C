//
//  RadishOrderDetailData.h
//  KidsTC
//
//  Created by 詹平 on 2016/12/12.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PayModel.h"

#import "RadishOrderDetailStore.h"
#import "RadishOrderDetailCountDown.h"
#import "RadishOrderDetailUserAddress.h"
#import "RadishOrderDetailRemark.h"
#import "RadishOrderDetailRefund.h"
#import "RadishOrderDetailConsumeCode.h"
#import "RadishOrderDetailInsurance.h"
#import "RadishOrderDetailBtn.h"
#import "RadishOrderDetailDeliver.h"

@interface RadishOrderDetailData : NSObject
@property (nonatomic, strong) NSString *orderId;
@property (nonatomic, strong) NSString *orderStateName;
@property (nonatomic, strong) NSString *time;
@property (nonatomic, strong) NSString *imgUrl;
@property (nonatomic, strong) NSString *serveId;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, assign) NSInteger productType;
@property (nonatomic, strong) NSString *productRedirect;
@property (nonatomic, strong) NSString *originalAmt;
@property (nonatomic, strong) NSString *totalPrice;
@property (nonatomic, assign) NSInteger count;
@property (nonatomic, assign) NSInteger scoreNum;
@property (nonatomic, strong) NSString *scoreAmt;
@property (nonatomic, assign) CGFloat discountAmt;
@property (nonatomic, assign) BOOL canRefund;
@property (nonatomic, assign) BOOL isNeedConnectService;
@property (nonatomic, assign) BOOL isShowSendConsumeCode;
@property (nonatomic, strong) NSString *supplierPhone;
@property (nonatomic, strong) RadishOrderDetailStore *storeInfo;
@property (nonatomic, assign) OrderBookingOnlineBespeakType onlineBespeakType;
@property (nonatomic, assign) BOOL isCanOnlineBespeak;
@property (nonatomic, assign) OrderBookingBespeakStatus onlineBespeakStatus;
@property (nonatomic, strong) NSString *onlineBespeakTime;
@property (nonatomic, strong) NSString *onlineBespeakStatusDesc;
@property (nonatomic, strong) NSString *onlineBespeakButtonText;
@property (nonatomic, assign) BOOL isShowRemainingTime;
@property (nonatomic, assign) NSTimeInterval remainingTime;
@property (nonatomic, strong) NSString *remainingDays;
@property (nonatomic, strong) RadishOrderDetailCountDown *countDown;
@property (nonatomic, strong) NSString *channelId;
@property (nonatomic, strong) RadishOrderDetailUserAddress *userAddress;
@property (nonatomic, strong) NSString *useValidTimeDesc;
@property (nonatomic, assign) OrderState orderState;
@property (nonatomic, strong) NSString *price;
@property (nonatomic, assign) PayType paytype;
@property (nonatomic, strong) NSString *paytypename;
@property (nonatomic, strong) NSString *phone;
@property (nonatomic, strong) NSString *orderDetailDesc;
@property (nonatomic, strong) NSString *expireTimeDesc;
@property (nonatomic, strong) NSArray<RadishOrderDetailRemark *> *remarks;
@property (nonatomic, strong) NSArray<RadishOrderDetailRefund *> *refunds;
@property (nonatomic, assign) CGFloat transportationExpenses;
@property (nonatomic, assign) BOOL isFreightDiscount;
@property (nonatomic, strong) NSArray<RadishOrderDetailConsumeCode *> *orderUsedConsumeCode;
@property (nonatomic, strong) RadishOrderDetailInsurance *insurance;
@property (nonatomic, strong) NSString *noticePageUrl;
@property (nonatomic, strong) NSArray<NSNumber *> *orderBtns;
@property (nonatomic, assign) RadishOrderDetailBtnType defaultBtn;
@property (nonatomic, strong) RadishOrderDetailDeliver *deliver;
@property (nonatomic, assign) PlaceType placeType;
@property (nonatomic, strong) NSString *userRemark;
//selfDefine
@property (nonatomic, assign) BOOL canShowButton;
@property (nonatomic, strong) NSAttributedString *remarksStr;
@property (nonatomic, strong) NSAttributedString *orderInfoStr;
@property (nonatomic, strong) NSAttributedString *userRemarkStr;
@property (nonatomic, strong) NSArray<RadishOrderDetailBtn *> *btns;
@property (nonatomic, strong) NSArray<NSString *> *supplierPhones;
@property (nonatomic, strong) SegueModel *productSegueModel;
@end
