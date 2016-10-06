//
//  FlashServiceOrderDetailModel.h
//  KidsTC
//
//  Created by zhanping on 8/17/16.
//  Copyright © 2016 詹平. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SettlementPickStoreModel.h"
#import "FlashDetailModel.h"
#import "OrderBookingModel.h"

@interface FlashServiceOrderDetailRefund : NSObject
@property (nonatomic, strong) NSString  *refund_notice;
@property (nonatomic, strong) NSString  *consume_codes;
@property (nonatomic, assign) NSInteger refund_status;
@property (nonatomic, strong) NSString  *refund_status_desc;
@property (nonatomic, assign) CGFloat   refund_money;
@property (nonatomic, assign) NSInteger refund_score;
@property (nonatomic, strong) NSString  *refund_apply_time;
/**==selfDefine==*/
@property (nonatomic, strong) NSAttributedString *refundDescStr;
@end

@interface FlashServiceOrderDetailPriceConfig : NSObject
@property (nonatomic, assign) NSUInteger peopleNum;
@property (nonatomic, assign) CGFloat price;
@property (nonatomic, assign) FDPriceStatus priceStatus;
@property (nonatomic, strong) NSString *priceStatusName;
@end

@interface FlashServiceOrderDetailUserAddress : NSObject
@property (nonatomic, strong) NSString *peopleName;
@property (nonatomic, strong) NSString *fullAddress;
@property (nonatomic, strong) NSString *mobileNumber;
@end

@interface FlashServiceOrderDetailRemark : NSObject
@property (nonatomic, strong) NSString *remark;
@property (nonatomic, strong) NSString *remarkTime;
@end

typedef enum : NSUInteger {
    FlashServiceOrderDetailOrderStatusNotJoin               = 1,//预付款未付，尚未参加(预付款未付)
    FlashServiceOrderDetailOrderStatusJoin                  = 2,//预付款已付，已参加(预付款已付)
    FlashServiceOrderDetailOrderStatusBalanceSettlement     = 3,//尾款未付，尾款已确认(尾款未付)
    FlashServiceOrderDetailOrderStatusPayed                 = 4,//尾款已付，已支付(尾款已付)
    FlashServiceOrderDetailOrderStatusCanceled              = 5,//已取消
    FlashServiceOrderDetailOrderStatusPayExpired            = 6,//已过期
    FlashServiceOrderDetailOrderStatusRefunding             = 7,//退款中
    FlashServiceOrderDetailOrderStatusRefundSuccess         = 8,//退款成功
    FlashServiceOrderDetailOrderStatusWaitComment           = 9,//待评价
    FlashServiceOrderDetailOrderStatusEvaluated             = 10,//已评价
    FlashServiceOrderDetailOrderStatusPrepaidRefundSuccess  = 11,//预付款退款成功
} FlashServiceOrderDetailOrderStatus;

@interface FlashServiceOrderDetailData : NSObject
@property (nonatomic, strong) NSString *orderId;
@property (nonatomic, strong) NSString *fsSysNo;
@property (nonatomic, assign) CGFloat prepaidMoney;
@property (nonatomic, assign) CGFloat balanceMoney;
@property (nonatomic, assign) NSUInteger scoreNum;
@property (nonatomic, assign) CGFloat storePrice;
@property (nonatomic, assign) FlashServiceOrderDetailOrderStatus orderStatus;
@property (nonatomic, strong) NSString *orderStatusDesc;
@property (nonatomic, assign) FDDataStatus status;
@property (nonatomic, strong) NSString *statusDesc;
@property (nonatomic, assign) BOOL isLink;
@property (nonatomic, assign) BOOL isShowCountDown;
@property (nonatomic, assign) NSTimeInterval countDownValue;
@property (nonatomic, strong) NSString *countDownStr;
@property (nonatomic, strong) NSString *productNo;
@property (nonatomic, strong) NSString *productName;
@property (nonatomic, strong) NSString *productImg;
@property (nonatomic, assign) NSInteger productType;
@property (nonatomic, strong) NSString *promotionText;
@property (nonatomic, assign) NSUInteger saleStock;
@property (nonatomic, assign) NSUInteger prepaidNum;
@property (nonatomic, assign) BOOL canRefund;
@property (nonatomic, assign) BOOL isFlashSuccess;
@property (nonatomic, strong) NSArray<FlashServiceOrderDetailRefund *> *refunds;
@property (nonatomic, assign) BOOL isShowSendConsumeCode;
@property (nonatomic, assign) BOOL isNeedConnectService;
@property (nonatomic, strong) NSString *joinTime;
@property (nonatomic, strong) NSString *buyTime;
@property (nonatomic, strong) NSString *buyTimeEnd;
@property (nonatomic, strong) NSArray<FlashServiceOrderDetailPriceConfig *> *priceConfigs;
@property (nonatomic, strong) NSString *supplierPhone;
@property (nonatomic, strong) FlashServiceOrderDetailUserAddress *userAddress;
@property (nonatomic, strong) SettlementPickStoreDataItem *storeInfo;
@property (nonatomic, strong) NSString *useValidTimeDesc;
@property (nonatomic, assign) CGFloat transportationExpenses;
@property (nonatomic, strong) NSString *noticePageUrl;
@property (nonatomic, strong) NSArray *remarks;
@property (nonatomic, assign) OrderBookingOnlineBespeakType onlineBespeakType;
@property (nonatomic, assign) BOOL isCanOnlineBespeak;
@property (nonatomic, strong) NSString *onlineBespeakTime;
@property (nonatomic, strong) NSString *onlineBespeakStatusDesc;
@property (nonatomic, strong) NSString *onlineBespeakButtonText;
//@property (nonatomic, strong) NSArray *orderUsedConsumeCode;
@property (nonatomic, assign) BOOL isShowRemainingTime;
@property (nonatomic, strong) NSString *remainingTime;
@property (nonatomic, assign) NSUInteger remainingDays;
@property (nonatomic, assign) OrderBookingBespeakStatus onlineBespeakStatus;

/**==selfDefine==*/
@property (nonatomic, assign) BOOL canShowButton;
@property (nonatomic, strong) NSArray<NSString *> *supplierPhones;
@property (nonatomic, assign) NSTimeInterval countDownValueOriginal;
@property (nonatomic, strong) NSAttributedString *remarksStr;
@property (nonatomic, strong) NSAttributedString *orderInfoStr;
@property (nonatomic, strong) NSAttributedString *countDownValueString;
@end


@interface FlashServiceOrderDetailModel : NSObject
@property (nonatomic, assign) NSInteger errNo;
@property (nonatomic, strong) FlashServiceOrderDetailData *data;
@end
