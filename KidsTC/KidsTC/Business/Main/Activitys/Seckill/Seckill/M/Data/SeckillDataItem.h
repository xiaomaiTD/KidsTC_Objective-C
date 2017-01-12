//
//  SeckillDataItem.h
//  KidsTC
//
//  Created by 詹平 on 2017/1/11.
//  Copyright © 2017年 zhanping. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SeckillDataBanner.h"

typedef enum : NSUInteger {
    SeckillDataItemBtnStatusRemindMe = 1,//提醒我
    SeckillDataItemBtnStatusHasRemind = 2,//已提醒
    SeckillDataItemBtnStatusBuyNow = 3,//立即抢购
    SeckillDataItemBtnStatusHasSaleOut = 4,//已抢完
    SeckillDataItemBtnStatusHasFinished = 5,//已结束
    SeckillDataItemBtnStatusWaitOpen = 6,//等待开抢
} SeckillDataItemBtnStatus;

typedef enum : NSUInteger {
    SeckillDataItemShowTypeSmall = 1,
    SeckillDataItemShowTypeLarge = 2,
    SeckillDataItemShowTypeBanner = 9999,
} SeckillDataItemShowType;

@interface SeckillDataItem : NSObject
@property (nonatomic, strong) NSString *productNo;
@property (nonatomic, strong) NSString *channelId;
@property (nonatomic, strong) NSString *productName;
@property (nonatomic, strong) NSString *imageUrl;
@property (nonatomic, strong) NSString *price;
@property (nonatomic, strong) NSString *orignalPrice;
@property (nonatomic, strong) NSString *promotionText;
@property (nonatomic, assign) SeckillDataItemBtnStatus status;
@property (nonatomic, assign) CGFloat buyPercent;
@property (nonatomic, strong) NSString *remindCount;
@property (nonatomic, assign) BOOL isRemind;
@property (nonatomic, assign) NSInteger productShowStyle;
@property (nonatomic, assign) NSInteger productPlatformTagType;
@property (nonatomic, strong) NSString *productPlatformTagTypeDesc;
@property (nonatomic, strong) NSString *agegroup;
@property (nonatomic, strong) NSArray<SeckillDataBanner *> *advertisement;
@property (nonatomic, assign) SeckillDataItemShowType type;
@property (nonatomic, strong) NSString *address;
@property (nonatomic, strong) NSString *timeDesc;
@property (nonatomic, assign) ProductDetailType productType;

//selfDefine
@property (nonatomic, strong) SegueModel *segueModel;

@end
