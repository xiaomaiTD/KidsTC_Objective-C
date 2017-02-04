//
//  FlashBuyProductDetailData.h
//  KidsTC
//
//  Created by 詹平 on 2017/1/22.
//  Copyright © 2017年 zhanping. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FlashBuyProductDetailPriceConfig.h"
#import "FlashBuyProductDetailPromotionLink.h"
#import "FlashBuyProductDetailStore.h"
#import "FlashBuyProductDetailNote.h"
#import "FlashBuyProductDetailBuyNotice.h"
#import "FlashBuyProductDetailComment.h"
#import "FlashBuyProductDetailCommentListItem.h"
#import "FlashBuyProductDetailShare.h"
#import "CommentListItemModel.h"
#import "CommonShareObject.h"
#import "StoreListItemModel.h"

typedef enum : NSUInteger {
    FlashBuyProductDetailStatusNotStart              = 1,//闪购尚未开始，未到预约时间
    FlashBuyProductDetailStatusUnPrePaid             = 2,//我要闪购，可以参团未支付
    FlashBuyProductDetailStatusWaitPrePaid           = 3,//预付定金，可以参团待预付(已经下单)
    FlashBuyProductDetailStatusWaitBuy               = 4,//等待开团，等待开团（已预付）
    FlashBuyProductDetailStatusFlashFailedUnPrePaid  = 5,//闪购结束，开团失败(未预付)
    FlashBuyProductDetailStatusFlashFailedPrePaid    = 6,//闪购结束，开团失败（已预付）
    FlashBuyProductDetailStatusRefunding             = 7,//退款中，开团失败（已预付）- 在订单中
    FlashBuyProductDetailStatusRefunded              = 8,//退款成功，开团失败（已预付）-在订单中
    FlashBuyProductDetailStatusFlashSuccessNoPrePaid = 9,//闪购结束，开团成功（未预付）
    FlashBuyProductDetailStatusFlashSuccessUnPay     = 10,//立付尾款，开团成功（已预付，没有进入确认页确认）
    FlashBuyProductDetailStatusFlashSuccessWaitPay   = 11,//立付尾款，开团成功（已预付，已进入确认页确认）
    FlashBuyProductDetailStatusHadPaid               = 12,//闪购成功，已购买
    FlashBuyProductDetailStatusProductRunOut         = 13,//已售罄
    FlashBuyProductDetailStatusProductNotSale        = 14,//暂不销售
    FlashBuyProductDetailStatusBuyTimeEnd            = 15,//闪购结束，购买时间已过
    FlashBuyProductDetailStatusEvaluted              = 16,//已评价，已评价 -在订单中
    FlashBuyProductDetailStatusWaitEvalute           = 17,//去评价，去评价 -在订单中
    FlashBuyProductDetailStatusUnLogIn               = 100//我要闪购，未登录：立即参加
} FlashBuyProductDetailStatus;

typedef enum : NSUInteger {
    FlashBuyProductDetailShowTypeDetail = 1,
    FlashBuyProductDetailShowTypeStore,
    FlashBuyProductDetailShowTypeComment,
} FlashBuyProductDetailShowType;

@interface FlashBuyProductDetailData : NSObject
@property (nonatomic, strong) NSString *fsSysNo;
@property (nonatomic, strong) NSString *serveId;
@property (nonatomic, strong) NSString *serveName;
@property (nonatomic, strong) NSString *simpleName;
@property (nonatomic, strong) NSString *content;
@property (nonatomic, assign) FlashBuyProductDetailStatus status;
@property (nonatomic, strong) NSString *statusDesc;
@property (nonatomic, strong) NSString *orderNo;
@property (nonatomic, assign) BOOL isLink;
@property (nonatomic, assign) BOOL isShowCountDown;
@property (nonatomic, assign) NSTimeInterval countDownValue;
@property (nonatomic, strong) NSString *countDownStr;
@property (nonatomic, assign) NSInteger level;
@property (nonatomic, strong) NSString *price;
@property (nonatomic, strong) NSString *prepaidPrice;
@property (nonatomic, assign) NSInteger evaluate;
@property (nonatomic, assign) NSInteger saleCount;
@property (nonatomic, assign) NSInteger remainCount;
@property (nonatomic, assign) NSInteger prepaidNum;
@property (nonatomic, strong) NSArray<FlashBuyProductDetailPriceConfig *> *priceConfigs;
@property (nonatomic, assign) BOOL isFavor;
@property (nonatomic, strong) NSArray<NSString *> *imgUrl;
@property (nonatomic, strong) NSArray<NSString *> *narrowImg;
@property (nonatomic, strong) NSString *flowImg;
@property (nonatomic, strong) NSString *flowLinkUrl;
@property (nonatomic, assign) CGFloat picRate;
@property (nonatomic, strong) NSString *promote;
@property (nonatomic, strong) NSArray<FlashBuyProductDetailPromotionLink *> *promotionLink;
@property (nonatomic, strong) NSArray<NSString *> *age;
@property (nonatomic, strong) NSString *dateTime;
@property (nonatomic, strong) NSArray<FlashBuyProductDetailStore *> *store;
@property (nonatomic, assign) NSInteger productType;
@property (nonatomic, strong) FlashBuyProductDetailComment *comment;
@property (nonatomic, assign) NSInteger commentImgCount;
@property (nonatomic, strong) FlashBuyProductDetailNote *note;
@property (nonatomic, strong) NSArray<FlashBuyProductDetailBuyNotice *> *buyNotice;
@property (nonatomic, strong) NSArray<FlashBuyProductDetailCommentListItem *> *commentList;
@property (nonatomic, assign) BOOL isOpenRemind;
@property (nonatomic, strong) NSString *detailUrl;
@property (nonatomic, strong) FlashBuyProductDetailShare *share;
@property (nonatomic, assign) ProductDetailType productRedirect;
//selfDefine
@property (nonatomic, strong) NSAttributedString *attServeName;
@property (nonatomic, strong) NSAttributedString *attPromote;
@property (nonatomic, strong) NSAttributedString *attContent;
@property (nonatomic, assign) FlashBuyProductDetailShowType showType;
@property (nonatomic, assign) BOOL webViewHasLoad;
@property (nonatomic, strong) NSArray<StoreListItemModel *> *storeModels;
@property (nonatomic, strong) NSArray<CommentListItemModel *> *commentItemsArray;
@property (nonatomic, strong) CommonShareObject *shareObject;
@property (nonatomic, strong) SegueModel *segueModel;
@property (nonatomic, assign) BOOL countDownOver;
@property (nonatomic, strong) NSString *countDownValueString;
@end
