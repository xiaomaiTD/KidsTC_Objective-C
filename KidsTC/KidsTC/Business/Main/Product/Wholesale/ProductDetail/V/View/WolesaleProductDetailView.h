//
//  WolesaleProductDetailView.h
//  KidsTC
//
//  Created by 詹平 on 2016/12/26.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WolesaleProductDetailData.h"

typedef enum : NSUInteger {
    WolesaleProductDetailViewActionTypeRule = 1,//活动拼团
    WolesaleProductDetailViewActionTypeJoinOther,//参加其他团
    WolesaleProductDetailViewActionTypeTime,//显示时间
    WolesaleProductDetailViewActionTypeAddress,//显示位置
    WolesaleProductDetailViewActionTypeWebLoadFinish,//web加载完毕
    WolesaleProductDetailViewActionTypeOtherProduct,//其他拼团
    WolesaleProductDetailViewActionTypeLoadTeam,//加载参加其他团
    WolesaleProductDetailViewActionTypeLoadOtherProduct,//加载其他拼团
    
    WolesaleProductDetailViewActionTypeShare = 50,//分享
    WolesaleProductDetailViewActionTypeJoin,//我要参团
    WolesaleProductDetailViewActionTypeSale,//我要组团
    WolesaleProductDetailViewActionTypeMySale,//我的拼团
    WolesaleProductDetailViewActionTypeCountDownOver,//倒计时结束
} WolesaleProductDetailViewActionType;

@class WolesaleProductDetailView;
@protocol WolesaleProductDetailViewDelegate <NSObject>
- (void)wolesaleProductDetailView:(WolesaleProductDetailView *)view actionType:(WolesaleProductDetailViewActionType)type value:(id)value;
@end

@interface WolesaleProductDetailView : UIView
@property (nonatomic, strong) WolesaleProductDetailData *data;
@property (nonatomic, weak) id<WolesaleProductDetailViewDelegate> delegate;
@end
