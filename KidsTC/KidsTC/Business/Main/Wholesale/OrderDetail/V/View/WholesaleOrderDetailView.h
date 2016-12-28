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
    WholesaleOrderDetailViewActionTypeShare = 50,//分享
    WholesaleOrderDetailViewActionTypeHome,//首页
    WholesaleOrderDetailViewActionTypeBuy,//去支付
    WholesaleOrderDetailViewActionTypeMySale,//用户自己的拼团信息
    WholesaleOrderDetailViewActionTypeProductHome,//更多拼团
} WholesaleOrderDetailViewActionType;

@class WholesaleOrderDetailView;
@protocol WholesaleOrderDetailViewDelegate <NSObject>
- (void)wholesaleOrderDetailView:(WholesaleOrderDetailView *)view actionType:(WholesaleOrderDetailViewActionType)type value:(id)value;
@end

@interface WholesaleOrderDetailView : UIView
@property (nonatomic, strong) WholesaleOrderDetailData *data;
@property (nonatomic, weak) id<WholesaleOrderDetailViewDelegate> delegate;
@end
