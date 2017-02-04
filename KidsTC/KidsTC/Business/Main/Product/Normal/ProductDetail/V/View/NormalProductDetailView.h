//
//  NormalProductDetailView.h
//  KidsTC
//
//  Created by 詹平 on 2017/2/3.
//  Copyright © 2017年 zhanping. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NormalProductDetailData.h"

typedef enum : NSUInteger {
    
    NormalProductDetailViewActionTypeShowAddress = 1,
    NormalProductDetailViewActionTypeAddNewConsult,
    NormalProductDetailViewActionTypeMoreConsult,
    NormalProductDetailViewActionTypeOpenWebView,
    NormalProductDetailViewActionTypeWebViewFinishLoad,
    NormalProductDetailViewActionTypeComment,
    NormalProductDetailViewActionTypeMoreComment,
    NormalProductDetailViewActionTypeCoupon,
    NormalProductDetailViewActionTypeShowDate,
    NormalProductDetailViewActionTypeSegue,
    NormalProductDetailViewActionTypeSelectStandard,
    NormalProductDetailViewActionTypeStandard,
    NormalProductDetailViewActionTypeBuyStandard,
    NormalProductDetailViewActionTypeConsult,
    NormalProductDetailViewActionTypeContact,
    
    NormalProductDetailViewActionTypeToolBarConsult = 100,//在线咨询
    NormalProductDetailViewActionTypeAttention,//(添加/取消)关注
    NormalProductDetailViewActionTypeBuyNow,//立即购买
    NormalProductDetailViewActionTypeCountDownOver,//倒计时结束
    
} NormalProductDetailViewActionType;

@class NormalProductDetailView;
@protocol NormalProductDetailViewDelegate <NSObject>
- (void)normalProductDetailView:(NormalProductDetailView *)view actionType:(NormalProductDetailViewActionType)type value:(id)value;
@end

@interface NormalProductDetailView : UIView
@property (nonatomic, strong) NormalProductDetailData *data;
@property (nonatomic, weak) id<NormalProductDetailViewDelegate> delegate;
@end
