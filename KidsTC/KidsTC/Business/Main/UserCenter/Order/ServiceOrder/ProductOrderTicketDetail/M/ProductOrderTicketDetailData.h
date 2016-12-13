//
//  ProductOrderTicketDetailData.h
//  KidsTC
//
//  Created by 詹平 on 2016/12/13.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ProductOrderTicketDetailUserAddress.h"
#import "ProductOrderTicketDetailSeat.h"
#import "ProductOrderTicketDetailCountDown.h"
#import "ProductOrderTicketDetailRemark.h"
#import "ProductOrderTicketDetailRefund.h"
#import "ProductOrderTicketDetailDeliver.h"
#import "ProductOrderTicketDetailBtn.h"

@interface ProductOrderTicketDetailData : NSObject
@property (nonatomic, strong) NSString *orderNo;
@property (nonatomic, strong) NSString *orderStatusDesc;
@property (nonatomic, assign) OrderState orderStatus;
@property (nonatomic, strong) NSString *productNo;
@property (nonatomic, strong) NSString *chId;
@property (nonatomic, strong) NSString *serveName;
@property (nonatomic, strong) NSString *img;
@property (nonatomic, strong) NSString *theater;
@property (nonatomic, strong) NSString *city;
@property (nonatomic, strong) NSString *kind;
@property (nonatomic, strong) NSString *ticketTime;
@property (nonatomic, strong) ProductOrderTicketDetailUserAddress *userAddressInfo;
@property (nonatomic, strong) NSString *address;
@property (nonatomic, strong) NSString *mapAddress;
@property (nonatomic, strong) NSArray<ProductOrderTicketDetailSeat *> *seats;
@property (nonatomic, strong) NSString *showTime;
@property (nonatomic, assign) NSInteger takeTicketWay;
@property (nonatomic, strong) NSString *takeTicketWayDesc;
@property (nonatomic, assign) BOOL canRefund;
@property (nonatomic, strong) NSString *supplierPhone;
@property (nonatomic, strong) NSString *totalPrice;
@property (nonatomic, assign) CGFloat discountAmt;
@property (nonatomic, assign) NSInteger scoreNum;
@property (nonatomic, strong) NSString *payPrice;
@property (nonatomic, assign) CGFloat transportationExpenses;
@property (nonatomic, strong) NSString *payTypeDesc;
@property (nonatomic, strong) NSString *createTime;
@property (nonatomic, strong) ProductOrderTicketDetailCountDown *countDown;
@property (nonatomic, strong) NSArray<ProductOrderTicketDetailRemark *> *remarks;
@property (nonatomic, strong) NSArray<ProductOrderTicketDetailRefund *> *refunds;
@property (nonatomic, strong) NSArray<NSNumber *> *orderBtns;
@property (nonatomic, assign) ProductOrderTicketDetailBtnType defaultBtn;
@property (nonatomic, strong) ProductOrderTicketDetailDeliver *deliver;
//selfDefine
@property (nonatomic, strong) NSAttributedString *remarksStr;
@property (nonatomic, strong) NSArray<ProductOrderTicketDetailBtn *> *btns;
@property (nonatomic, strong) NSArray<NSString *> *supplierPhones;
@property (nonatomic, strong) SegueModel *productSegueModel;
@end
