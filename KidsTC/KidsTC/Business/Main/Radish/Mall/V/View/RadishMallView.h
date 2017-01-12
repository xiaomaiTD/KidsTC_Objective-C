//
//  RadishMallView.h
//  KidsTC
//
//  Created by 詹平 on 2017/1/5.
//  Copyright © 2017年 zhanping. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RadishMallData.h"

typedef enum : NSUInteger {
    RadishMallViewActionTypeSegue = 1,
    RadishMallViewActionTypePlant,
    RadishMallViewActionTypeRule,
    RadishMallViewActionTypeLoadData = 100,
} RadishMallViewActionType;

@class RadishMallView;
@protocol RadishMallViewDelegate <NSObject>
- (void)radishMallView:(RadishMallView *)view actionType:(RadishMallViewActionType)type value:(id)value;
@end

@interface RadishMallView : UIView
@property (nonatomic, strong) RadishMallData *data;
@property (nonatomic, weak) id<RadishMallViewDelegate> delegate;
- (void)reloadData;
- (void)dealWithUI:(NSUInteger)loadCount;
@end
