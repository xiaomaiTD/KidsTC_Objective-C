//
//  RadishProductOrderListItem.h
//  KidsTC
//
//  Created by 詹平 on 2017/1/6.
//  Copyright © 2017年 zhanping. All rights reserved.
//

#import "RadishProductOrderListBtn.h"
#import "RadishProductOrderListDeliver.h"
#import "RadishProductOrderListCountDown.h"

@interface RadishProductOrderListItem : NSObject
@property (nonatomic, strong) NSString *orderNo;
@property (nonatomic, strong) NSString *statusName;
@property (nonatomic, strong) NSString *imgUrl;
@property (nonatomic, strong) NSString *productName;
@property (nonatomic, strong) NSString *storeName;
@property (nonatomic, strong) NSString *productNo;
@property (nonatomic, strong) NSString *chId;
@property (nonatomic, strong) NSString *createTime;
@property (nonatomic, strong) NSString *supplierIcon;
@property (nonatomic, strong) RadishProductOrderListDeliver *deliver;
@property (nonatomic, strong) RadishProductOrderListCountDown *countDown;
@property (nonatomic, strong) NSString *unitPrice;
@property (nonatomic, strong) NSString *payNum;
@property (nonatomic, strong) NSString *payPrice;
@property (nonatomic, strong) NSString *supplierMobie;
@property (nonatomic, strong) NSString *reservationRemark;
@property (nonatomic, strong) NSArray<NSNumber *> *orderBtns;
@property (nonatomic, assign) RadishProductOrderListBtnType defaultBtn;
@property (nonatomic, strong) NSString *commentNo;
@property (nonatomic, assign) NSInteger commentType;
@property (nonatomic, strong) NSString *venueName;
@property (nonatomic, strong) NSString *payDesc;
@property (nonatomic, strong) NSString *storeNo;
@property (nonatomic, assign) PlaceType placeType;
@property (nonatomic, strong) NSString *useTimeStr;
@property (nonatomic, strong) NSString *storeAddress;
@property (nonatomic, strong) NSString *radishNo;
@property (nonatomic, strong) NSString *radishCount;
//selfDefine
@property (nonatomic, strong) NSArray<RadishProductOrderListBtn *> *btns;
@property (nonatomic, strong) NSArray<NSString *> *supplierPhones;
@property (nonatomic, strong) SegueModel *segueModel;
@end
