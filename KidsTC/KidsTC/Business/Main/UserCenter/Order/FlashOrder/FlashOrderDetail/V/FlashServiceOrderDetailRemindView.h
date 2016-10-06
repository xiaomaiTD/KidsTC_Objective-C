//
//  FlashServiceOrderDetailRemindView.h
//  KidsTC
//
//  Created by zhanping on 2016/9/18.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    FlashServiceOrderDetailRemindViewActionTypeLink=1,
    FlashServiceOrderDetailRemindViewActionTypeDelete,
} FlashServiceOrderDetailRemindViewActionType;

@class FlashServiceOrderDetailRemindView;
@protocol FlashServiceOrderDetailRemindViewDelegate <NSObject>
- (void)flashServiceOrderDetailRemindView:(FlashServiceOrderDetailRemindView *)view actionType:(FlashServiceOrderDetailRemindViewActionType)type;
@end

@interface FlashServiceOrderDetailRemindView : UIView
@property (nonatomic, weak) id<FlashServiceOrderDetailRemindViewDelegate> delegate;
@end
