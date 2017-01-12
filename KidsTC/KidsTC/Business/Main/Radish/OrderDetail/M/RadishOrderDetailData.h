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

/*
 orderId	Long	3170100003363
 orderStateName	String	已取消
 time	String	2017-01-11 21:23:57
 imgUrl	String	http://img.test.kidstc.com/v1/img/T1ARETBTAT1RCvBVdK.jpeg
 serveId	Integer	2015072601
 name	String	孕期瑜伽 +产后修复 - V. YOGA
 productType	Integer	2
 originalAmt	Integer	0
 totalPrice	Integer	0
 count	Integer	0
 radishNum	Integer	100
 canRefund	Boolean	false
 isNeedConnectService	Boolean	false
 isShowSendConsumeCode	Boolean	false
 supplierPhone	String
 placeType	Integer	3
 storeInfo	Object
 onlineBespeakType	Integer	0
 isCanOnlineBespeak	Boolean	false
 onlineBespeakStatus	Integer	0
 onlineBespeakTime	Null	null
 onlineBespeakStatusDesc	String	UNKNOWN
 onlineBespeakButtonText	String	不可预约
 isShowRemainingTime	Boolean	false
 remainingTime	Integer	0
 remainingDays	Integer	0
 countDown	Null	null
 channelId	Integer	0
 userAddress	Null	null
 useValidTimeDesc	Null	null
 orderState	Integer	4
 price	Integer	0
 paytype	Integer	0
 paytypename	Null	null
 phone	Null	null
 orderDetailDesc	Null	null
 expireTimeDesc	Null	null
 remarks	Null	null
 refunds	Null	null
 transportationExpenses	Null	null
 isFreightDiscount	Boolean	true
 orderUsedConsumeCode	Null	null
 insurance	Null	null
 noticePageUrl	String	http://m.kidstc.com/tools/order_notice_page
 orderBtns	Array
 defaultBtn	Null	null
 deliver	Null	null
 userRemark	String
 */

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
@property (nonatomic, strong) NSString *radishNum;
//selfDefine
@property (nonatomic, assign) BOOL canShowButton;
@property (nonatomic, strong) NSAttributedString *remarksStr;
@property (nonatomic, strong) NSAttributedString *orderInfoStr;
@property (nonatomic, strong) NSAttributedString *userRemarkStr;
@property (nonatomic, strong) NSArray<RadishOrderDetailBtn *> *btns;
@property (nonatomic, strong) NSArray<NSString *> *supplierPhones;
@property (nonatomic, strong) SegueModel *productSegueModel;
@end
