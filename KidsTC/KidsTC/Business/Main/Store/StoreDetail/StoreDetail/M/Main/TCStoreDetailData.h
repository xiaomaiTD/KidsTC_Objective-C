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
#import "TCStoreDetailCoupon.h"
#import "TCStoreDetailProductPackage.h"
#import "TCStoreDetailMoreProductPackage.h"
#import "TCStoreDetailComment.h"
#import "TCStoreDetailCommentItem.h"
#import "CommonShareObject.h"
#import "TCStoreDetailNearbyData.h"
#import "TCStoreDetailColumn.h"
#import "CommentListItemModel.h"
#import "ActivityLogoItem.h"
#import "StoreDetailNearbyModel.h"

@interface TCStoreDetailData : NSObject
@property (nonatomic, strong) TCStoreDetailStoreBase *storeBase;
@property (nonatomic, strong) NSArray<TCStoreDetailFacility *> *facilities;
@property (nonatomic, strong) NSArray<NSString *> *storeGifts;
@property (nonatomic, assign) BOOL isFavor;
@property (nonatomic, strong) TCStoreDetailShare *share;
@property (nonatomic, strong) TCStoreDetailProductPackage *productPackage;
@property (nonatomic, strong) TCStoreDetailMoreProductPackage *moreProductPackage;
@property (nonatomic, assign) BOOL canProvideCoupon;
@property (nonatomic, strong) NSArray<TCStoreDetailCoupon *> *coupons;
@property (nonatomic, strong) TCStoreDetailComment *comment;
@property (nonatomic, assign) NSInteger commentImgCount;
@property (nonatomic, assign) NSInteger evaluate;
@property (nonatomic, strong) NSArray<TCStoreDetailCommentItem *> *comments;
//selfDefine
@property (nonatomic, strong) CommonShareObject *shareObject;
@property (nonatomic, strong) NSArray<CommentListItemModel *> *commentItemsArray;
@property (nonatomic, strong) TCStoreDetailNearbyData *nearbyData;
@property (nonatomic, assign) BOOL hasColumn;
@property (nonatomic, assign) NSUInteger columnsSection;
@property (nonatomic, strong) NSArray<TCStoreDetailColumn *> *columns;
@property (nonatomic, strong) NSArray<ActivityLogoItem *> *activeModelsArray;
@property (nonatomic, strong) NSArray<StoreDetailNearbyModel *> *nearbyFacilities;
@end
