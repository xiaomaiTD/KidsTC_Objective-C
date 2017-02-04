//
//  NormalProductDetailToolBar.h
//  KidsTC
//
//  Created by 詹平 on 2017/2/3.
//  Copyright © 2017年 zhanping. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NormalProductDetailData.h"

extern CGFloat const kNormalProductDetailToolBarH;

typedef enum : NSUInteger {
    NormalProductDetailToolBarActionTypeConsult = 100,//在线咨询
    NormalProductDetailToolBarActionTypeAttention,//(添加/取消)关注
    NormalProductDetailToolBarActionTypeBuyNow,//立即购买
    NormalProductDetailToolBarActionTypeCountDownOver,//倒计时结束
} NormalProductDetailToolBarActionType;

@class NormalProductDetailToolBar;
@protocol NormalProductDetailToolBarDelegate <NSObject>
- (void)normalProductDetailToolBar:(NormalProductDetailToolBar *)toolBar actionType:(NormalProductDetailToolBarActionType)type value:(id)value;
@end

@interface NormalProductDetailToolBar : UIView
@property (nonatomic, strong) NormalProductDetailData *data;
@property (nonatomic, weak) id<NormalProductDetailToolBarDelegate> delegate;
@end
