//
//  RadishProductDetailData.h
//  KidsTC
//
//  Created by 詹平 on 2017/1/6.
//  Copyright © 2017年 zhanping. All rights reserved.
//

#import "RadishProductDetailPromotionLink.h"
#import "RadishProductDetailBuyNotice.h"
#import "RadishProductDetailComment.h"
#import "RadishProductDetailCommentItem.h"
#import "RadishProductDetailCoupon.h"
#import "RadishProductDetailInsurance.h"
#import "RadishProductDetailNote.h"
#import "RadishProductDetailShare.h"
#import "RadishProductDetailStandard.h"
#import "RadishProductDetailStore.h"
#import "RadishProductDetailTime.h"
#import "RadishProductDetailCountDown.h"
#import "RadishProductDetailPlace.h"
#import "RecommendProduct.h"

typedef enum : NSUInteger {
    RadishProductDetailTwoColumnShowTypeDetail=100,//详情
    RadishProductDetailTwoColumnShowTypeConsult//咨询
} RadishProductDetailTwoColumnShowType;

@interface RadishProductDetailData : NSObject
@property (nonatomic, strong) NSString *serveId;
@property (nonatomic, strong) NSString *chId;
@property (nonatomic, assign) PriceSort priceSort;
@property (nonatomic, strong) NSString *priceSortName;
@property (nonatomic, strong) NSString *simpleName;
@property (nonatomic, strong) NSString *serveName;
@property (nonatomic, strong) NSString *promote;
@property (nonatomic, strong) NSString *content;
@property (nonatomic, strong) NSArray<NSString *> *applyContent;
@property (nonatomic, strong) NSArray<RadishProductDetailPromotionLink *> *promotionLink;
@property (nonatomic, assign) NSUInteger buyMinNum;
@property (nonatomic, assign) NSUInteger buyMaxNum;
@property (nonatomic, assign) BOOL isFavor;
@property (nonatomic, strong) NSArray<RadishProductDetailBuyNotice *> *buyNotice;
@property (nonatomic, strong) NSArray<NSString *> *narrowImg;
@property (nonatomic, assign) CGFloat picRate;
@property (nonatomic, assign) NSUInteger evaluate;
@property (nonatomic, assign) NSUInteger saleCount;
@property (nonatomic, assign) NSUInteger remainCount;
@property (nonatomic, strong) RadishProductDetailComment *comment;
@property (nonatomic, assign) NSUInteger commentImgCount;
@property (nonatomic, strong) NSArray<RadishProductDetailCommentItem *> *commentList;
@property (nonatomic, strong) NSArray<RadishProductDetailCoupon *> *coupon_provide;
@property (nonatomic, assign) BOOL canProvideCoupon;
@property (nonatomic, strong) NSString *detailUrl;
@property (nonatomic, strong) NSArray<NSString *> *fullCut;
@property (nonatomic, strong) NSArray<NSString *> *coupons;
@property (nonatomic, strong) NSString *originalPrice;
@property (nonatomic, strong) NSString *price;
@property (nonatomic, strong) NSString *priceDesc;
@property (nonatomic, strong) RadishProductDetailInsurance *insurance;
@property (nonatomic, strong) RadishProductDetailNote *note;
@property (nonatomic, strong) RadishProductDetailShare *share;
@property (nonatomic, strong) NSArray<RadishProductDetailStandard *> *product_standards;
@property (nonatomic, assign) NSInteger status;
@property (nonatomic, strong) NSString *statusDesc;
@property (nonatomic, strong) NSArray<RadishProductDetailStore *> *store;
@property (nonatomic, assign) NSUInteger advisoryCount;
@property (nonatomic, strong) RadishProductDetailTime *time;
@property (nonatomic, strong) NSString *synopsis;
@property (nonatomic, assign) NSInteger seeNum;
@property (nonatomic, assign) NSInteger wantSeeNum;
@property (nonatomic, strong) NSString *img;
@property (nonatomic, strong) RadishProductDetailCountDown *countDown;
@property (nonatomic, assign) PlaceType placeType;
@property (nonatomic, strong) NSArray<RadishProductDetailPlace *> *place;
@property (nonatomic, assign) NSInteger currentPlaceIndex;
@property (nonatomic, strong) NSString *commentNo;
@property (nonatomic, assign) NSInteger commentRelationType;
@property (nonatomic, strong) NSString *phone;
@property (nonatomic, strong) NSString *standardTitle;
@property (nonatomic, strong) NSString *standardName;

//selfDefine
@property (nonatomic, strong) NSAttributedString *attServeName;
@property (nonatomic, strong) NSAttributedString *attPromote;
@property (nonatomic, strong) NSArray<RecommendProduct *> *recommends;
//showType
@property (nonatomic, assign) RadishProductDetailTwoColumnShowType showType;
@property (nonatomic, assign) BOOL webViewHasOpen;
@property (nonatomic, assign) BOOL webViewHasLoad;

@end
