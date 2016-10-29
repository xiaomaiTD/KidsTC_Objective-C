//
//  ProductDetailData.h
//  KidsTC
//
//  Created by 詹平 on 2016/10/26.
//  Copyright © 2016年 zhanping. All rights reserved.
//
#import "ProductDetailPromotionLink.h"
#import "ProductDetailBuyNotice.h"
#import "ProductDetailComment.h"
#import "ProduceDetialCommentItem.h"
#import "ProdectDetailCoupon.h"
#import "ProductDetailInsurance.h"
#import "ProductDetailNote.h"
#import "ProductDetailShare.h"
#import "ProductDetailStandard.h"
#import "ProductDetailStore.h"
#import "ProductDetailTime.h"
#import "ProductDetailRecommendItem.h"
#import "CommentListItemModel.h"
#import "ProductDetailConsultItem.h"
#import "CommonShareObject.h"

typedef enum : NSUInteger {
    TCProductTypeService = 1,//服务
    TCProductTypeActivity = 2,//活动
    TCProductTypeMaterialObject = 3//实物
} TCProductType;

@interface ProductDetailData : NSObject
@property (nonatomic, strong) NSString *serveId;
@property (nonatomic, strong) NSString *chId;
@property (nonatomic, strong) NSString *priceSort;
@property (nonatomic, strong) NSString *priceSortName;
@property (nonatomic, strong) NSString *simpleName;
@property (nonatomic, strong) NSString *serveName;
@property (nonatomic, strong) NSString *promote;
@property (nonatomic, assign) TCProductType productType;
@property (nonatomic, strong) NSString *content;
@property (nonatomic, strong) NSArray<NSString *> *applyContent;
@property (nonatomic, strong) NSArray<ProductDetailPromotionLink *> *promotionLink;
@property (nonatomic, assign) NSUInteger buyMinNum;
@property (nonatomic, assign) NSUInteger buyMaxNum;
@property (nonatomic, assign) BOOL isFavor;
@property (nonatomic, strong) NSArray<ProductDetailBuyNotice *> *buyNotice;
@property (nonatomic, strong) NSArray<NSString *> *narrowImg;
@property (nonatomic, assign) CGFloat picRate;
@property (nonatomic, assign) NSUInteger evaluate;
@property (nonatomic, assign) NSUInteger saleCount;
@property (nonatomic, assign) NSUInteger remainCount;
@property (nonatomic, strong) ProductDetailComment *comment;
@property (nonatomic, assign) NSUInteger commentImgCount;
@property (nonatomic, strong) NSArray<ProduceDetialCommentItem *> *commentList;
@property (nonatomic, assign) BOOL showCountDown;
@property (nonatomic, assign) NSTimeInterval countDownTime;
@property (nonatomic, strong) NSArray<ProdectDetailCoupon *> *coupon_provide;
@property (nonatomic, assign) BOOL canProvideCoupon;
@property (nonatomic, strong) NSString *detailUrl;
@property (nonatomic, strong) NSArray<NSString *> *fullCut;
@property (nonatomic, strong) NSArray<NSString *> *coupons;
@property (nonatomic, strong) NSString *originalPrice;
@property (nonatomic, strong) NSString *price;
@property (nonatomic, strong) ProductDetailInsurance *insurance;
@property (nonatomic, strong) ProductDetailNote *note;
@property (nonatomic, strong) ProductDetailShare *share;
@property (nonatomic, strong) NSArray<ProductDetailStandard *> *product_standards;
@property (nonatomic, assign) NSInteger status;
@property (nonatomic, strong) NSString *statusDesc;
@property (nonatomic, strong) NSArray<ProductDetailStore *> *store;
@property (nonatomic, assign) NSUInteger advisoryCount;
@property (nonatomic, strong) ProductDetailTime *time;

#pragma mark - selfDefine

//info
@property (nonatomic, strong) NSAttributedString *attServeName;
@property (nonatomic, strong) NSAttributedString *attPromote;
@property (nonatomic, strong) NSString *priceStr;
@property (nonatomic, strong) NSAttributedString *attNum;

//apply
@property (nonatomic, strong) NSArray<NSAttributedString *> *attApply;

//recommend
@property (nonatomic, strong) NSArray<ProductDetailRecommendItem *> *recommends;

//consult
@property (nonatomic, strong) NSArray<ProductDetailConsultItem *> *consults;

//canBuy
@property (nonatomic, assign) BOOL isCanBuy;

//评论详情
@property (nonatomic, strong) NSArray<CommentListItemModel *> *commentItemsArray;

//shareObj
@property (nonatomic, strong) CommonShareObject *shareObject;

@end



