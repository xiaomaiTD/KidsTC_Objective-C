//
//  ServiceOrderDetailModel.h
//  KidsTC
//
//  Created by zhanping on 8/15/16.
//  Copyright © 2016 詹平. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PayModel.h"
#import "SettlementPickStoreModel.h"
#import "OrderBookingModel.h"

typedef enum : NSUInteger {
    ServiceOrderDetailOrderStateWaitPay=1,//待付款
    ServiceOrderDetailOrderStateWaitUse,//待使用
    ServiceOrderDetailOrderStatePartUse,//部分使用
    ServiceOrderDetailOrderStateWaitComment,//待评价
    ServiceOrderDetailOrderStateCanceled,//订单已取消
    ServiceOrderDetailOrderStateRefunding,//退款中
    ServiceOrderDetailOrderStateRefundSuccess,//退款成功
    ServiceOrderDetailOrderStateRefundFailure,//退款失败
    ServiceOrderDetailOrderStateHasComment,//已评价
    ServiceOrderDetailOrderStateHasOverTime,//已过期
} ServiceOrderDetailOrderState;

@interface ServiceOrderDetailInsurance : NSObject
@property (nonatomic, assign) BOOL refund_anytime;
@property (nonatomic, assign) BOOL refund_outdate;
@property (nonatomic, assign) BOOL refund_part;
/**==selfDefine==*/
@property (nonatomic, assign) BOOL canShow;
@property (nonatomic, strong) NSAttributedString *tipStr;
@end

@interface ServiceOrderDetailRefund : NSObject
@property (nonatomic, strong) NSString *refund_notice;
@property (nonatomic, strong) NSArray<NSString *> *consume_codes;
@property (nonatomic, assign) NSInteger refund_status;
@property (nonatomic, strong) NSString *refund_status_desc;
@property (nonatomic, assign) CGFloat refund_money;
@property (nonatomic, assign) NSUInteger refund_score;
@property (nonatomic, strong) NSString *refund_apply_time;
/**==selfDefine==*/
@property (nonatomic, strong) NSAttributedString *refundDescStr;
@end

@interface ServiceOrderDetailRemark : NSObject
@property (nonatomic, strong) NSString *remark;
@property (nonatomic, strong) NSString *remarkTime;
@end

@interface ServiceOrderDetailUserAddress : NSObject
@property (nonatomic, strong) NSString *peopleName;
@property (nonatomic, strong) NSString *fullAddress;
@property (nonatomic, strong) NSString *mobileNumber;
@end

@interface ServiceOrderDetailData : NSObject
@property (nonatomic, strong) NSString *oderId;
@property (nonatomic, strong) NSString *serveId;
@property (nonatomic, assign) ServiceOrderDetailOrderState orderState;
@property (nonatomic, strong) NSString *orderStateName;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, assign) PayType paytype;
@property (nonatomic, strong) NSString *paytypename;
@property (nonatomic, strong) NSString *imgUrl;
@property (nonatomic, assign) CGFloat price;
@property (nonatomic, assign) NSUInteger count;
@property (nonatomic, strong) NSString *phone;
@property (nonatomic, strong) NSString *time;
@property (nonatomic, assign) NSInteger productType;
@property (nonatomic, strong) ServiceOrderDetailInsurance *insurance;
@property (nonatomic, assign) NSInteger originalAmt;
@property (nonatomic, assign) CGFloat totalPrice;
@property (nonatomic, assign) NSUInteger scoreNum;
@property (nonatomic, assign) CGFloat discountAmt;
@property (nonatomic, strong) NSString *orderDetailDesc;
@property (nonatomic, assign) BOOL canRefund;
@property (nonatomic, strong) NSArray<ServiceOrderDetailRefund *> *refunds;
@property (nonatomic, assign) BOOL isShowSendConsumeCode;
@property (nonatomic, assign) BOOL isNeedConnectService;
@property (nonatomic, strong) NSString *expireTimeDesc;
@property (nonatomic, strong) NSArray<NSString *> *supplierPhones;
@property (nonatomic, strong) ServiceOrderDetailUserAddress *userAddress;
@property (nonatomic, strong) SettlementPickStoreDataItem *storeInfo;
@property (nonatomic, assign) BOOL isFreightDiscount;
@property (nonatomic, strong) NSString *useValidTimeDesc;
@property (nonatomic, assign) CGFloat transportationExpenses;
@property (nonatomic, strong) NSString *noticePageUrl;
@property (nonatomic, strong) NSArray<ServiceOrderDetailRemark *> *remarks;

@property (nonatomic, assign) OrderBookingOnlineBespeakType onlineBespeakType;
@property (nonatomic, assign) BOOL isCanOnlineBespeak;
@property (nonatomic, strong) NSString *onlineBespeakTime;
@property (nonatomic, strong) NSString *onlineBespeakStatusDesc;
@property (nonatomic, strong) NSString *onlineBespeakButtonText;
//@property (nonatomic, strong) NSArray *orderUsedConsumeCode;
@property (nonatomic, assign) BOOL isShowRemainingTime;
@property (nonatomic, assign) NSTimeInterval remainingTime;
@property (nonatomic, assign) NSUInteger remainingDays;
@property (nonatomic, assign) BOOL isBuyAgain;
@property (nonatomic, strong) NSString *channelId;
@property (nonatomic, assign) OrderBookingBespeakStatus onlineBespeakStatus;

/**==selfDefine==*/
@property (nonatomic, assign) BOOL canShowButton;
@property (nonatomic, strong) NSAttributedString *remarksStr;
@property (nonatomic, strong) NSAttributedString *orderInfoStr;
@property (nonatomic, strong) NSAttributedString *countDownValueString;
@end

@interface ServiceOrderDetailModel : NSObject
@property (nonatomic, assign) NSInteger errNo;
@property (nonatomic, strong) ServiceOrderDetailData *data;
@end


