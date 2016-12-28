//
//  WholesaleProductDetailBase.h
//  KidsTC
//
//  Created by 詹平 on 2016/12/27.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WholesaleProductDetailBuyNotice.h"
#import "ProductDetailTime.h"
#import "WholesaleProductDetailStore.h"
#import "WholesaleProductDetailShare.h"
#import "WholesaleProductDetailCountDown.h"
#import "WholesaleProductDetailTeam.h"
#import "WholesaleProductDetailCount.h"
#import "WholesaleProductDetailOtherProduct.h"
#import "WolesaleProductDetailPlace.h"
#import "WholesaleProductDetailStoreItem.h"
#import "CommonShareObject.h"

@interface WholesaleProductDetailBase : NSObject
@property (nonatomic, strong) NSString *productNo;
@property (nonatomic, strong) NSString *channelId;
@property (nonatomic, assign) BOOL isCanBuy;
@property (nonatomic, strong) NSString *storeNo;
@property (nonatomic, strong) NSString *buyNum;
@property (nonatomic, strong) NSString *productName;
@property (nonatomic, strong) NSString *productImage;
@property (nonatomic, strong) NSString *platFormPrice;
@property (nonatomic, strong) NSString *fightGroupPrice;
@property (nonatomic, strong) NSString *openGroupUserCount;
@property (nonatomic, strong) NSArray<WholesaleProductDetailBuyNotice *> *buyNotice;
@property (nonatomic, strong) ProductDetailTime *productTime;
@property (nonatomic, strong) WholesaleProductDetailStore *store;
@property (nonatomic, strong) WholesaleProductDetailShare *share;
@property (nonatomic, assign) PlaceType placeType;
@property (nonatomic, strong) NSArray<WolesaleProductDetailPlace *> *place;
@property (nonatomic, strong) NSArray<WholesaleProductDetailStoreItem *> *stores;
@property (nonatomic, strong) WholesaleProductDetailCountDown *countDown;
@property (nonatomic, strong) NSString *detailUrl;
@property (nonatomic, strong) NSString *flowUrl;
//selfDefine
@property (nonatomic, assign) BOOL webViewHasLoad;
@property (nonatomic, strong) NSArray<WholesaleProductDetailTeam *> *teams;
@property (nonatomic, strong) NSArray<WholesaleProductDetailCount *> *teamCounts;
@property (nonatomic, strong) NSArray<WholesaleProductDetailOtherProduct *> *otherProducts;
@property (nonatomic, strong) NSArray<WholesaleProductDetailCount *> *otherProductCounts;
//shareObj
@property (nonatomic, strong) CommonShareObject *shareObject;
@end
