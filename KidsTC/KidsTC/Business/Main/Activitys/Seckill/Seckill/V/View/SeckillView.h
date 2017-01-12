//
//  SeckillView.h
//  KidsTC
//
//  Created by 詹平 on 2017/1/10.
//  Copyright © 2017年 zhanping. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SeckillTimeData.h"
#import "SeckillDataData.h"

typedef enum : NSUInteger {
    SeckillViewActionTypeSegue = 1,//通用跳转
    SeckillViewActionTypeRemind,//设置提醒
    
    SeckillViewActionTypeSeckillTime = 200,//选择场次时间
    
    SeckillViewActionTypeHome = 300,//首页
    SeckillViewActionTypePocket,//我的购物袋
    SeckillViewActionTypeOther,//其他优惠活动
    
} SeckillViewActionType;

@class SeckillView;
@protocol SeckillViewDelegate <NSObject>
- (void)seckillView:(SeckillView *)view actionType:(SeckillViewActionType)type value:(id)value;
@end

@interface SeckillView : UIView
@property (nonatomic, strong) SeckillTimeData *timeData;
@property (nonatomic, strong) SeckillDataData *dataData;
@property (nonatomic, weak) id<SeckillViewDelegate> delegate;
@end
