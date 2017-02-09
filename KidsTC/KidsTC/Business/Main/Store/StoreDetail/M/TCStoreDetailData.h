//
//  TCStoreDetailData.h
//  KidsTC
//
//  Created by 詹平 on 2017/2/8.
//  Copyright © 2017年 zhanping. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TCStoreDetailStoreBase.h"
#import "TCStoreDetailFacility.h"
#import "TCStoreDetailShare.h"
#import "TCStoreDetailProductPackage.h"
#import "TCStoreDetailMoreProductPackage.h"
#import "TCStoreDetailComment.h"
#import "TCStoreDetailCommentItem.h"
#import "CommonShareObject.h"

typedef enum : NSUInteger {
    TCStoreDetailDataColumnShowTypeWebDetail = 1,
    TCStoreDetailDataColumnShowTypeComment,
    TCStoreDetailDataColumnShowTypeNearby,
} TCStoreDetailDataColumnShowType;

@interface TCStoreDetailData : NSObject
@property (nonatomic, strong) TCStoreDetailStoreBase *storeBase;
@property (nonatomic, strong) NSArray<TCStoreDetailFacility *> *facilities;
@property (nonatomic, strong) NSArray<NSString *> *storeGifts;
@property (nonatomic, assign) BOOL isFavor;
@property (nonatomic, strong) TCStoreDetailShare *share;
@property (nonatomic, strong) TCStoreDetailProductPackage *productPackage;
@property (nonatomic, strong) TCStoreDetailMoreProductPackage *moreProductPackage;
@property (nonatomic, assign) BOOL canProvideCoupon;
@property (nonatomic, strong) NSArray<NSString *> *coupons;
@property (nonatomic, strong) TCStoreDetailComment *comment;
@property (nonatomic, assign) NSInteger commentImgCount;
@property (nonatomic, assign) NSInteger evaluate;
@property (nonatomic, strong) NSArray<TCStoreDetailCommentItem *> *comments;
//selfDefine
@property (nonatomic, strong) CommonShareObject *shareObject;
@end
