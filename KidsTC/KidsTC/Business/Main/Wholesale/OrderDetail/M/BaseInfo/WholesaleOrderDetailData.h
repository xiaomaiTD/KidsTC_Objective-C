//
//  WholesaleOrderDetailData.h
//  KidsTC
//
//  Created by 詹平 on 2016/12/28.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WholesaleProductDetailBase.h"
#import "WholesaleOrderDetailUser.h"
#import "WholesaleOrderDetailCountDown.h"
#import "WholesaleOrderDetailPartner.h"
#import "WholesalePickDateSKU.h"

typedef enum : NSUInteger {
    FightGroupOpenGroupStepSelect = 1,//选择自己喜欢的团
    FightGroupOpenGroupStepPay,//支付开团
    FightGroupOpenGroupStepShare,//邀请好友参团
    FightGroupOpenGroupStepSuccess//人满成团
} FightGroupOpenGroupStep;

typedef enum : NSUInteger {
    FightGroupBtnStatusShare = 1,//邀请好友参团
    FightGroupBtnStatusBuy = 2,//我要参团
    FightGroupBtnStatusMySale = 3,//我的拼团
    FightGroupBtnStatusFull = 4,//人数已满
    FightGroupBtnStatusProductHome = 5,//更多拼团
} FightGroupBtnStatus;

typedef enum : NSUInteger {
    FightGroupOpenGroupStatusNotShow = 1,//不显示
    FightGroupOpenGroupStatusOpenGroupSuccess = 2,//开团成功
    FightGroupOpenGroupStatusOpenGroupFailure = 3,//开团失败
    FightGroupOpenGroupStatusJoinGroupSuccess = 4,//参团成功
    FightGroupOpenGroupStatusJoinGroupFailure = 5,//参团失败
} FightGroupOpenGroupStatus;

@interface WholesaleOrderDetailData : NSObject
@property (nonatomic, strong) NSString *uid;
@property (nonatomic, strong) WholesaleProductDetailBase *fightGroupBase;
@property (nonatomic, assign) long long openGroupSysNo;
@property (nonatomic, assign) FightGroupOpenGroupStep openGroupStep;
@property (nonatomic, assign) FightGroupBtnStatus btnStatus;
@property (nonatomic, strong) WholesaleOrderDetailUser *openGroupUser;
@property (nonatomic, assign) NSInteger surplusUserCount;
@property (nonatomic, strong) NSString *surplusDesc;
@property (nonatomic, assign) FightGroupOpenGroupStatus openGroupStatus;
@property (nonatomic, assign) BOOL isShowRemainTime;
@property (nonatomic, assign) NSTimeInterval remainTime;
@property (nonatomic, strong) NSString *currentUserOpenGroup;
@property (nonatomic, strong) WholesaleOrderDetailCountDown *countDown;
@property (nonatomic, strong) WholesalePickDateSKU *sku;
//selfDefine
@property (nonatomic, strong) NSArray<WholesaleOrderDetailPartner *> *partners;
@property (nonatomic, strong) NSArray<WholesaleProductDetailCount *> *partnerCounts;
@end
