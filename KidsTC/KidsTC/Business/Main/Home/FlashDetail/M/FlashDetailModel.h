//
//  FlashDetailModel.h
//  KidsTC
//
//  Created by zhanping on 5/16/16.
//  Copyright © 2016 KidsTC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KTCCommentManager.h"

typedef NS_ENUM(NSInteger, FDPriceStatus) {
    FDPriceStatus_NoAchieved=1,//未达到
    FDPriceStatus_Flashing,//进行中
    FDPriceStatus_Achieved,//已达到
    FDPriceStatus_CurrentAchieved//目前已达到
};
@interface FDPriceConfigsItem : NSObject
@property (nonatomic, assign) NSInteger peopleNum;
@property (nonatomic, assign) double price;
@property (nonatomic, assign) FDPriceStatus priceStatus;
@property (nonatomic, strong) NSString *priceStatusName;
@end

@interface FDPromotionLinkItem : NSObject
@property (nonatomic, strong) NSString *linkKey;
@property (nonatomic, strong) NSString *color;
@property (nonatomic, strong) UIColor *uiColor;
@property (nonatomic, assign) NSInteger linkType;
@property (nonatomic, strong) NSDictionary *params;
@end

@interface FDStoreItem : NSObject
@property (nonatomic, strong) NSString *storeId;
@property (nonatomic, strong) NSString *storeName;
@property (nonatomic, assign) NSInteger level;
@property (nonatomic, strong) NSString *distance;
@property (nonatomic, strong) NSString *phone;
@property (nonatomic, assign) NSInteger hotCount;
@property (nonatomic, assign) NSInteger attentNum;
@property (nonatomic, strong) NSString *imgUrl;
@property (nonatomic, strong) NSString *mapAddress;
@property (nonatomic, strong) NSString *address;
@end

@interface FDComment : NSObject
@property (nonatomic, assign) NSInteger all;
@property (nonatomic, assign) NSInteger good;
@property (nonatomic, assign) NSInteger normal;
@property (nonatomic, assign) NSInteger bad;
@property (nonatomic, assign) NSInteger pic;
@end

@interface FDNote : NSObject
@property (nonatomic, strong) NSString *imgUrl;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *note;
@end

@interface FDBuyNoticeItem : NSObject
@property (nonatomic, strong) NSString *clause;
@property (nonatomic, strong) NSString *notice;
@end

@interface FSScoreDetailItem : NSObject
@property (nonatomic, strong) NSString *Key;
@property (nonatomic, strong) NSString *ScoreName;
@property (nonatomic, assign) NSInteger Score;
@end
@interface FCSoreItem : NSObject
@property (nonatomic, assign) NSInteger OverallScore;
@property (nonatomic, strong) NSArray<FSScoreDetailItem *> *ScoreDetail;
@end

@interface FDCommentListItem : NSObject
@property (nonatomic, assign) NSInteger cid;//id
@property (nonatomic, strong) NSString *time;
@property (nonatomic, strong) NSString *content;
@property (nonatomic, strong) NSArray<NSArray *> *imageUrl;//attention
@property (nonatomic, assign) BOOL isPraise;
@property (nonatomic, assign) NSInteger praiseCount;
@property (nonatomic, assign) NSInteger replyCount;
@property (nonatomic, strong) NSString *userImgUrl;
@property (nonatomic, strong) NSString *userName;
@property (nonatomic, strong) NSString *replyUser;
@property (nonatomic, strong) NSString *supplierReplyContent;
@property (nonatomic, strong) FCSoreItem *score;
@end

@interface FDShare : NSObject
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *desc;
@property (nonatomic, strong) NSString *imgUrl;
@property (nonatomic, strong) NSString *linkUrl;
@end
/**
 UnPaid                = 2,//我要闪购，可以参团未支付
 WaitPrePaid           = 3,//预付定金，可以参团待预付(已经下单)
 
 FlashSuccessUnPay     = 10,//立付尾款，开团成功（已预付，没有进入确认页确认）
 */

/**
 
 需要进入【结算】页面的两种状态：
 FDDataStatus_UnPrePaid             = 2,//我要闪购，可以参团未支付
 FDDataStatus_FlashSuccessUnPay     = 10,//立付尾款，开团成功（已预付，没有进入确认页确认）
 
 需要进入【选择支付方式】的两种状态：
 FDDataStatus_WaitPrePaid           = 3,//预付定金，可以参团待预付(已经下单)
 FDDataStatus_FlashSuccessWaitPay   = 11,//立付尾款，开团成功（已预付，已进入确认页确认）
 
 */

/**
 FDDataStatus_WaitBuy               = 4,//等待开团，等待开团（已预付）
 FDDataStatus_HadPaid               = 12,//闪购成功，已购买
 */
typedef enum : NSUInteger {
    FDDataStatus_NotStart              = 1,//闪购尚未开始，未到预约时间
    FDDataStatus_UnPrePaid             = 2,//我要闪购，可以参团未支付
    FDDataStatus_WaitPrePaid           = 3,//预付定金，可以参团待预付(已经下单)
    FDDataStatus_WaitBuy               = 4,//等待开团，等待开团（已预付）
    FDDataStatus_FlashFailedUnPrePaid  = 5,//闪购结束，开团失败(未预付)
    FDDataStatus_FlashFailedPrePaid    = 6,//闪购结束，开团失败（已预付）
    FDDataStatus_Refunding             = 7,//退款中，开团失败（已预付）- 在订单中
    FDDataStatus_Refunded              = 8,//退款成功，开团失败（已预付）-在订单中
    FDDataStatus_FlashSuccessNoPrePaid = 9,//闪购结束，开团成功（未预付）
    FDDataStatus_FlashSuccessUnPay     = 10,//立付尾款，开团成功（已预付，没有进入确认页确认）
    FDDataStatus_FlashSuccessWaitPay   = 11,//立付尾款，开团成功（已预付，已进入确认页确认）
    FDDataStatus_HadPaid               = 12,//闪购成功，已购买
    FDDataStatus_ProductRunOut         = 13,//已售罄
    FDDataStatus_ProductNotSale        = 14,//暂不销售
    FDDataStatus_BuyTimeEnd            = 15,//闪购结束，购买时间已过
    FDDataStatus_Evaluted              = 16,//已评价，已评价 -在订单中
    FDDataStatus_WaitEvalute           = 17,//去评价，去评价 -在订单中
    FDDataStatus_UnLogIn               = 100//我要闪购，未登录：立即参加
} FDDataStatus;



@class FDCommentLayout;
@interface FDData : NSObject
@property (nonatomic, strong) NSString *fsSysNo;
@property (nonatomic, strong) NSString *serveId;
@property (nonatomic, strong) NSString *serveName;
@property (nonatomic, strong) NSString *simpleName;
@property (nonatomic, strong) NSString *content;
@property (nonatomic, assign) FDDataStatus status;
@property (nonatomic, strong) NSString *statusDesc;
@property (nonatomic, strong) NSString *orderNo;
@property (nonatomic, assign) BOOL isLink;
@property (nonatomic, assign) BOOL isShowCountDown;
@property (nonatomic, assign) long countDownValue;
@property (nonatomic, strong) NSAttributedString *countDownValueString;
@property (nonatomic, strong) NSString *countDownStr;
@property (nonatomic, assign) NSInteger level;
@property (nonatomic, assign) double price;
@property (nonatomic, assign) double prepaidPrice;
@property (nonatomic, assign) NSInteger evaluate;
@property (nonatomic, assign) NSInteger saleCount;
@property (nonatomic, assign) NSInteger remainCount;
@property (nonatomic, assign) NSInteger prepaidNum;
@property (nonatomic, strong) NSArray<FDPriceConfigsItem *> *priceConfigs;
@property (nonatomic, assign) BOOL isFavor;
@property (nonatomic, strong) NSArray<NSString *> *imgUrl;
@property (nonatomic, strong) NSArray<NSString *> *narrowImg;
@property (nonatomic, strong) NSString *flowImg;
@property (nonatomic, strong) NSString *flowLinkUrl;
@property (nonatomic, strong) NSString *picRate;
@property (nonatomic, strong) NSString *promote;
@property (nonatomic, strong) NSArray<FDPromotionLinkItem *> *promotionLink;
@property (nonatomic, strong) NSArray<NSString *> *age;
@property (nonatomic, strong) NSString *dateTime;
@property (nonatomic, strong) NSArray<NSDictionary *> *store;
@property (nonatomic, strong) NSArray<FDStoreItem *> *storeModels;
@property (nonatomic, assign) CommentRelationType productType;
@property (nonatomic, strong) FDComment *comment;
@property (nonatomic, assign) NSInteger commentImgCount;
@property (nonatomic, strong) FDNote *note;
@property (nonatomic, strong) NSArray<FDBuyNoticeItem *> *buyNotice;
@property (nonatomic, strong) NSArray<NSDictionary *> *commentList;
@property (nonatomic, strong) NSArray<FDCommentListItem *> *commentModelList;
@property (nonatomic, strong) NSArray<FDCommentLayout *> *commentModelLayouts;
//@property (nonatomic, strong) <#type#> *product_relation;
@property (nonatomic, assign) BOOL isOpenRemind;
@property (nonatomic, strong) NSString *detailUrl;
@property (nonatomic, strong) FDShare *share;
@end

@interface FlashDetailModel : NSObject
@property (nonatomic, strong) FDData *data;
@end
