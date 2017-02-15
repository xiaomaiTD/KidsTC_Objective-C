//
//  ScoreOrderItem.h
//  KidsTC
//
//  Created by 童成mac-dev1 on 2017/2/13.
//  Copyright © 2017年 zhanping. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SegueModel.h"
@interface ScoreOrderItem : NSObject
@property (nonatomic,strong) NSString *orderNo;
@property (nonatomic,assign) OrderKind orderKind;
@property (nonatomic,strong) NSString *statusName;
@property (nonatomic,strong) NSString *imgUrl;
@property (nonatomic,strong) NSString *productName;
@property (nonatomic,strong) NSString *storeName;
@property (nonatomic,strong) NSString *storeAddress;
@property (nonatomic,strong) NSString *venueName;
@property (nonatomic,strong) NSString *storeNo;
@property (nonatomic,assign) PlaceType placeType;
@property (nonatomic,strong) NSString *productNo;
@property (nonatomic,strong) NSString *chId;
@property (nonatomic,strong) NSString *createTime;
@property (nonatomic,strong) NSString *unitPrice;
@property (nonatomic,strong) NSString *payNum;
@property (nonatomic,strong) NSString *payPrice;
@property (nonatomic,strong) NSString *supplierMobie;
@property (nonatomic,strong) NSString *reservationRemark;
@property (nonatomic,strong) NSString *commentNo;
@property (nonatomic,assign) NSInteger commentType;
@property (nonatomic,strong) NSString *payDesc;
@property (nonatomic,strong) NSString *time;
@property (nonatomic,strong) NSString *useTimeStr;
@property (nonatomic,strong) NSString *openGroupHeader;
@property (nonatomic,strong) NSString *openGroupUserName;
@property (nonatomic,strong) NSString *openGroupId;
@property (nonatomic,strong) NSString *radishCount;
//selfDeine
@property (nonatomic, strong) SegueModel *segueModel;
@property (nonatomic, strong) NSArray<NSString *> *phones;
@end
