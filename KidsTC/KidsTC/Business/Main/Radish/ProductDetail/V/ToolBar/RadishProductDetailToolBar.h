//
//  RadishProductDetailToolBar.h
//  KidsTC
//
//  Created by 詹平 on 2017/1/6.
//  Copyright © 2017年 zhanping. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RadishProductDetailData.h"

extern CGFloat const kRadishProductDetailToolBarH;

typedef enum : NSUInteger {
    RadishProductDetailToolBarActionTypeConsult = 300,//在线咨询
    RadishProductDetailToolBarActionTypeAttention,//(添加/取消)关注
    RadishProductDetailToolBarActionTypeBuyNow,//立即购买
} RadishProductDetailToolBarActionType;

@class RadishProductDetailToolBar;
@protocol RadishProductDetailToolBarDelegate <NSObject>
- (void)radishProductDetailToolBar:(RadishProductDetailToolBar *)toolBar actionType:(RadishProductDetailToolBarActionType)type value:(id)value;
@end

@interface RadishProductDetailToolBar : UIView
@property (nonatomic, weak) id<RadishProductDetailToolBarDelegate> delegate;
@property (nonatomic, strong) RadishProductDetailData *data;
@end
