//
//  WolesaleProductDetailToolBar.h
//  KidsTC
//
//  Created by 詹平 on 2016/12/26.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WolesaleProductDetailData.h"
extern CGFloat const kWolesaleProductDetailToolBarH;

typedef enum : NSUInteger {
    WolesaleProductDetailToolBarActionTypeShare = 50,//分享
    WolesaleProductDetailToolBarActionTypeJoin,//我要参团
    WolesaleProductDetailToolBarActionTypeSale,//我要组团
    WolesaleProductDetailToolBarActionTypeMySale,//我的拼团
    WolesaleProductDetailToolBarActionTypeCountDownOver,//倒计时结束
} WolesaleProductDetailToolBarActionType;

@class WolesaleProductDetailToolBar;
@protocol WolesaleProductDetailToolBarDelegate <NSObject>
- (void)wolesaleProductDetailToolBar:(WolesaleProductDetailToolBar *)toolBar actionType:(WolesaleProductDetailToolBarActionType)type value:(id)value;
@end

@interface WolesaleProductDetailToolBar : UIView
@property (nonatomic, strong) WolesaleProductDetailData *data;
@property (nonatomic, weak) id<WolesaleProductDetailToolBarDelegate> delegate;
@end
