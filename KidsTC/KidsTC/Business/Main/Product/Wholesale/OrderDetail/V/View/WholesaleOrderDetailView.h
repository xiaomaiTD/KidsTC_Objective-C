//
//  WholesaleOrderDetailView.h
//  KidsTC
//
//  Created by 詹平 on 2016/12/27.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WholesaleOrderDetailData.h"

typedef enum : NSUInteger {
    WholesaleOrderDetailViewActionTypeRule = 1,//拼团玩法
    WholesaleOrderDetailViewActionTypeLoadPartners,//加载参团记录
    WholesaleOrderDetailViewActionTypeBuy = 50,//去支付
    WholesaleOrderDetailViewActionTypeMySale,//用户自己的拼团信息
    WholesaleOrderDetailViewActionTypeProductHome,//更多拼团
    WholesaleOrderDetailViewActionTypeShare,//分享
    WholesaleOrderDetailViewActionTypeConsult,//在线咨询
} WholesaleOrderDetailViewActionType;

@class WholesaleOrderDetailView;
@protocol WholesaleOrderDetailViewDelegate <NSObject>
- (void)wholesaleOrderDetailView:(WholesaleOrderDetailView *)view actionType:(WholesaleOrderDetailViewActionType)type value:(id)value;
@end

@interface WholesaleOrderDetailView : UIView
@property (nonatomic, strong) WholesaleOrderDetailData *data;
@property (nonatomic, weak) id<WholesaleOrderDetailViewDelegate> delegate;
@end
