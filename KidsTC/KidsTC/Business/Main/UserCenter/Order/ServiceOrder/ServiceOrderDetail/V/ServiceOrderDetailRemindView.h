//
//  ServiceOrderDetailRemindView.h
//  KidsTC
//
//  Created by zhanping on 2016/9/18.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    ServiceOrderDetailRemindViewActionTypeLink=1,
    ServiceOrderDetailRemindViewActionTypeDelete,
} ServiceOrderDetailRemindViewActionType;

@class ServiceOrderDetailRemindView;
@protocol ServiceOrderDetailRemindViewDelegate <NSObject>
- (void)serviceOrderDetailRemindView:(ServiceOrderDetailRemindView *)view actionType:(ServiceOrderDetailRemindViewActionType)type;
@end

@interface ServiceOrderDetailRemindView : UIView
@property (nonatomic, weak) id<ServiceOrderDetailRemindViewDelegate> delegate;
@end
