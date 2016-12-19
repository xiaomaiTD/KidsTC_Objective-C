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
#import "ProductOrderFreeListBtn.h"
#import "SegueModel.h"
#import "ProductOrderFreeListCountDown.h"

@interface ProductOrderFreeListItem : NSObject
@property (nonatomic, strong) NSString *orderNo;
@property (nonatomic, strong) NSString *productSysNo;
@property (nonatomic, assign) NSInteger productType;
@property (nonatomic, assign) NSInteger commentType;
@property (nonatomic, assign) FreeType freeType;
@property (nonatomic, strong) NSString *freeTypeStr;
@property (nonatomic, strong) NSString *productName;
@property (nonatomic, strong) NSString *channelId;
@property (nonatomic, strong) NSString *productImg;
@property (nonatomic, strong) ProductOrderFreeListStore *storeInfo;
@property (nonatomic, strong) NSString *LotteryTime;
@property (nonatomic, strong) NSString *joinCount;
@property (nonatomic, assign) NSInteger productStatus;
@property (nonatomic, strong) NSString *productStatusStr;
@property (nonatomic, strong) NSString *startTime;
@property (nonatomic, strong) NSString *startTimeStr;
@property (nonatomic, strong) ProductOrderFreeListCountDown *countDown;
@property (nonatomic, strong) NSString *rowCreateTime;
@property (nonatomic, strong) ProductOrderFreeListBooking *onlineBespeak;
@property (nonatomic, assign) BOOL isLottery;
@property (nonatomic, assign) BOOL isCanOnlineBespeak;
@property (nonatomic, assign) BOOL isCanComment;
@property (nonatomic, strong) NSArray<NSNumber *> *orderBtns;
@property (nonatomic, assign) ProductOrderFreeListBtnType defaultBtn;
@property (nonatomic, assign) NSInteger orderStatus;
@property (nonatomic, assign) PlaceType placeType;
@property (nonatomic, strong) NSString *supplierMobie;
//selfDefine
@property (nonatomic, strong) NSArray<NSString *> *supplierPhones;
@property (nonatomic, strong) NSArray<ProductOrderFreeListBtn *> *btns;
@property (nonatomic, strong) SegueModel *segueModel;
@end
