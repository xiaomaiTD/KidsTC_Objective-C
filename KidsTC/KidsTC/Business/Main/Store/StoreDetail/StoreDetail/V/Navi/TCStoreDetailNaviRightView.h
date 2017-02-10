//
//  TCStoreDetailNaviRightView.h
//  KidsTC
//
//  Created by 詹平 on 2017/1/23.
//  Copyright © 2017年 zhanping. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    TCStoreDetailNaviRightViewActionTypeHistory = 1,
    TCStoreDetailNaviRightViewActionTypeMore,
} TCStoreDetailNaviRightViewActionType;

@class TCStoreDetailNaviRightView;
@protocol TCStoreDetailNaviRightViewDelegate <NSObject>
- (void)tcStoreDetailNaviRightView:(TCStoreDetailNaviRightView *)view actionType:(TCStoreDetailNaviRightViewActionType)type value:(id)value;
@end

@interface TCStoreDetailNaviRightView : UIView
@property (nonatomic, weak) id<TCStoreDetailNaviRightViewDelegate> delegate;
@end
