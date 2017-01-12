//
//  SeckillOtherView.h
//  KidsTC
//
//  Created by 詹平 on 2017/1/11.
//  Copyright © 2017年 zhanping. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SeckillOtherItem.h"

typedef enum : NSUInteger {
    SeckillOtherViewActionTypeDidSelectItem,
    SeckillOtherViewActionTypeDidHide,
} SeckillOtherViewActionType;

@class SeckillOtherView;
@protocol SeckillOtherViewDelegate <NSObject>
- (void)seckillOtherView:(SeckillOtherView *)view actionType:(SeckillOtherViewActionType)type value:(id)value;
@end

@interface SeckillOtherView : UIView
@property (nonatomic, strong) NSArray<SeckillOtherItem *> *data;
@property (nonatomic, weak) id<SeckillOtherViewDelegate> delegate;
- (void)show;
- (void)hide:(void(^)(BOOL finish))completion;
@end
