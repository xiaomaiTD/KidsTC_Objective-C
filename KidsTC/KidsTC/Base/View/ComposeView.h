//
//  ComposeView.h
//  KidsTC
//
//  Created by 詹平 on 2016/10/24.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    ComposeViewActionTypeCompose = 1,
    ComposeViewActionTypeSign,
} ComposeViewActionType;

@class ComposeView;
@protocol ComposeViewDelegate <NSObject>
- (void)composeView:(ComposeView *)view actionType:(ComposeViewActionType)type value:(id)value;
@end

@interface ComposeView : UIView
@property (nonatomic, weak) id<ComposeViewDelegate> delegate;
- (void)show;
- (void)hide;
@end
