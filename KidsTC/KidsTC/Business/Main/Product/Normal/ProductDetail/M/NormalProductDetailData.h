//
//  NormalProductDetailData.h
//  KidsTC
//
//  Created by 詹平 on 2017/2/3.
//  Copyright © 2017年 zhanping. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "NormalProductDetailPromotionLink.h"
#import "NormalProductDetailBuyNotice.h"
#import "VideoPlayVideoRes.h"
#import "NormalProductDetailComment.h"
#import "NormalProductDetialCommentItem.h"
#import "NormalProductDetailCountDown.h"
#import "NormalProdectDetailCoupon.h"
#import "NormalProductDetailInsurance.h"
#import "NormalProductDetailNote.h"
#import "NormalProductDetailShare.h"
#import "ProductDetailStandard.h"
#import "NormalProductDetailPlace.h"
#import "NormalProductDetailStore.h"
#import "ProductDetailTime.h"
//selfDeine
#import "RecommendProduct.h"
#import "NormalProductDetailConsultItem.h"
#import "CommentListItemModel.h"
#import "CommonShareObject.h"

typedef enum : NSUInteger {
    NormalProductDetailColumnShowTypeDetail=100,//详情
    NormalProductDetailColumnShowTypeConsult//咨询
} NormalProductDetailColumnShowType;

@interface NormalProductDetailData : NSObject
@property (nonatomic, strong) NSString *serveId;
@property (nonatomic, strong) NSString *chId;
@property (nonatomic, assign) PriceSort priceSort;
@property (nonatomic, strong) NSString *priceSortName;
@property (nonatomic, strong) NSString *simpleName;
@property (nonatomic, strong) NSString *serveName;
@property (nonatomic, strong) NSString *standardName;
@property (nonatomic, strong) NSString *promote;
@property (nonatomic, assign) NSInteger productType;
@property (nonatomic, strong) NSString *content;
@property (nonatomic, strong) NSArray<NSString *> *applyContent;
@property (nonatomic, strong) NSArray<NormalProductDetailPromotionLink *> *promotionLink;
@property (nonatomic, assign) NSUInteger buyMinNum;
@property (nonatomic, assign) NSUInteger buyMaxNum;
@property (nonatomic, assign) BOOL isFavor;
@property (nonatomic, strong) NSArray<NormalProductDetailBuyNotice *> *buyNotice;
@property (nonatomic, strong) VideoPlayVideoRes *productVideoRes;
@property (nonatomic, strong) NSArray<NSString *> *narrowImg;
@property (nonatomic, assign) CGFloat picRate;
@property (nonatomic, assign) NSUInteger saleCount;
@property (nonatomic, assign) NSUInteger remainCount;
@property (nonatomic, strong) NormalProductDetailComment *comment;
@property (nonatomic, assign) NSUInteger commentImgCount;
@property (nonatomic, assign) NSUInteger evaluate;
@property (nonatomic, strong) NSArray<NormalProductDetialCommentItem *> *commentList;
@property (nonatomic, strong) NormalProductDetailCountDown *countDown;
@property (nonatomic, strong) NSArray<NormalProdectDetailCoupon *> *coupon_provide;
@property (nonatomic, assign) BOOL canProvideCoupon;
@property (nonatomic, strong) NSString *detailUrl;
@property (nonatomic, strong) NSArray<NSString *> *fullCut;
@property (nonatomic, strong) NSArray<NSString *> *coupons;
@property (nonatomic, strong) NSString *originalPrice;
@property (nonatomic, strong) NSString *price;
@property (nonatomic, strong) NormalProductDetailInsurance *insurance;
@property (nonatomic, strong) NormalProductDetailNote *note;
@property (nonatomic, strong) NormalProductDetailShare *share;
@property (nonatomic, assign) BOOL isShowProductStandards;
@property (nonatomic, strong) NSString *standardTitle;
@property (nonatomic, strong) NSArray<ProductDetailStandard *> *product_standards;
@property (nonatomic, assign) NSInteger status;
@property (nonatomic, strong) NSString *statusDesc;
@property (nonatomic, assign) PlaceType placeType;
@property (nonatomic, strong) NSArray<NormalProductDetailPlace *> *place;
@property (nonatomic, strong) NSArray<NormalProductDetailStore *> *store;
@property (nonatomic, assign) NSUInteger advisoryCount;
@property (nonatomic, strong) ProductDetailTime *time;
//selfDefine
@property (nonatomic, strong) NSAttributedString *attServeName;
@property (nonatomic, strong) NSAttributedString *attPromote;
@property (nonatomic, strong) NSString *priceStr;
@property (nonatomic, strong) NSAttributedString *attNum;
@property (nonatomic, strong) NSArray<NSAttributedString *> *attApply;
@property (nonatomic, strong) NSArray<RecommendProduct *> *recommends;
@property (nonatomic, strong) NSArray<NormalProductDetailConsultItem *> *consults;
@property (nonatomic, assign) BOOL isCanBuy;
@property (nonatomic, strong) NSArray<CommentListItemModel *> *commentItemsArray;
@property (nonatomic, strong) CommonShareObject *shareObject;
@property (nonatomic, assign) NormalProductDetailColumnShowType showType;
@property (nonatomic, assign) BOOL webViewHasOpen;
@property (nonatomic, assign) BOOL webViewHasLoad;
@end
