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
#import "RadishProductDetailInsurance.h"
#import "RadishProductDetailNote.h"
#import "RadishProductDetailShare.h"
#import "RadishProductDetailStandard.h"
#import "RadishProductDetailStore.h"
#import "RadishProductDetailTime.h"
#import "RadishProductDetailCountDown.h"
#import "RadishProductDetailPlace.h"
#import "RecommendProduct.h"
#import "ProductDetailConsultItem.h"
#import "CommentListItemModel.h"
#import "CommonShareObject.h"

typedef enum : NSUInteger {
    RadishProductDetailTwoColumnShowTypeDetail=100,//详情
    RadishProductDetailTwoColumnShowTypeConsult//咨询
} RadishProductDetailTwoColumnShowType;

@interface RadishProductDetailData : NSObject
@property (nonatomic, strong) NSString *serverId;
@property (nonatomic, strong) NSString *commentNo;
@property (nonatomic, assign) NSInteger commentRelationType;
@property (nonatomic, strong) NSString *advisoryNo;
@property (nonatomic, assign) NSInteger advisoryType;
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
@property (nonatomic, strong) RadishProductDetailCountDown *countDown;
@property (nonatomic, strong) NSString *detailUrl;
@property (nonatomic, strong) NSString *price;
@property (nonatomic, strong) NSString *originalPrice;
@property (nonatomic, strong) NSString *radishCount;
@property (nonatomic, strong) RadishProductDetailInsurance *insurance;
@property (nonatomic, strong) RadishProductDetailNote *note;
@property (nonatomic, strong) RadishProductDetailShare *share;
@property (nonatomic, assign) BOOL isShowProductStandards;
@property (nonatomic, strong) NSString *standardTitle;
@property (nonatomic, strong) NSArray<RadishProductDetailStandard *> *product_standards;
@property (nonatomic, assign) NSInteger status;
@property (nonatomic, strong) NSString *statusDesc;
@property (nonatomic, assign) PlaceType placeType;
@property (nonatomic, strong) NSArray<RadishProductDetailPlace *> *place;
@property (nonatomic, strong) NSArray<RadishProductDetailStore *> *store;
@property (nonatomic, assign) NSUInteger advisoryCount;
@property (nonatomic, strong) RadishProductDetailTime *time;
@property (nonatomic, assign) BOOL isShowPrice;


@property (nonatomic, strong) NSString *priceDesc;
@property (nonatomic, strong) NSString *synopsis;
@property (nonatomic, assign) NSInteger seeNum;
@property (nonatomic, assign) NSInteger wantSeeNum;
@property (nonatomic, strong) NSString *img;
@property (nonatomic, assign) NSInteger currentPlaceIndex;
@property (nonatomic, strong) NSString *phone;

//selfDefine
@property (nonatomic, assign) BOOL isCanBuy;
@property (nonatomic, strong) NSAttributedString *attServeName;
@property (nonatomic, strong) NSAttributedString *attPromote;
@property (nonatomic, strong) NSArray<RecommendProduct *> *recommends;
@property (nonatomic, strong) NSArray<ProductDetailConsultItem *> *consults;
@property (nonatomic, strong) NSArray<CommentListItemModel *> *commentItemsArray;
@property (nonatomic, strong) CommonShareObject *shareObject;
//showType
@property (nonatomic, assign) RadishProductDetailTwoColumnShowType showType;
@property (nonatomic, assign) BOOL webViewHasOpen;
@property (nonatomic, assign) BOOL webViewHasLoad;
//apply
@property (nonatomic, strong) NSArray<NSAttributedString *> *attApply;

@end
