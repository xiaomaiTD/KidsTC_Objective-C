//
//  NormalProductDetailNaviRightView.h
//  KidsTC
//
//  Created by 詹平 on 2017/1/23.
//  Copyright © 2017年 zhanping. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    NormalProductDetailNaviRightViewActionTypeHistory = 1,
    NormalProductDetailNaviRightViewActionTypeMore,
} NormalProductDetailNaviRightViewActionType;

@class NormalProductDetailNaviRightView;
@protocol NormalProductDetailNaviRightViewDelegate <NSObject>
- (void)normalProductDetailNaviRightView:(NormalProductDetailNaviRightView *)view actionType:(NormalProductDetailNaviRightViewActionType)type value:(id)value;
@end

@interface NormalProductDetailNaviRightView : UIView
@property (nonatomic, weak) id<NormalProductDetailNaviRightViewDelegate> delegate;
@end
