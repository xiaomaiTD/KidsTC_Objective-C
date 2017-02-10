//
//  TCStoreDetailToolBar.h
//  KidsTC
//
//  Created by 詹平 on 2017/2/8.
//  Copyright © 2017年 zhanping. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TCStoreDetailData.h"

extern CGFloat const kTCStoreDetailToolBarH;

typedef enum : NSUInteger {
    TCStoreDetailToolBarActionTypeLike = 100,
    TCStoreDetailToolBarActionTypeWrite,
    TCStoreDetailToolBarActionTypeAppoiment,
} TCStoreDetailToolBarActionType;

@class TCStoreDetailToolBar;
@protocol TCStoreDetailToolBarDelegate <NSObject>
- (void)tcStoreDetailToolBar:(TCStoreDetailToolBar *)toolBar actionType:(TCStoreDetailToolBarActionType)type value:(id)value;
@end

@interface TCStoreDetailToolBar : UIView
@property (nonatomic, weak) id<TCStoreDetailToolBarDelegate> delegate;
@property (nonatomic, strong) TCStoreDetailData *data;
@end
