//
//  TCStoreDetailView.h
//  KidsTC
//
//  Created by 詹平 on 2017/2/8.
//  Copyright © 2017年 zhanping. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TCStoreDetailData.h"

typedef enum : NSUInteger {
    TCStoreDetailViewActionTypeCollect = 1,
    TCStoreDetailViewActionTypePhone,
    TCStoreDetailViewActionTypePreferentialPackageMore,
    TCStoreDetailViewActionTypeCoupon,
    TCStoreDetailViewActionTypeCouponMore,
    TCStoreDetailViewActionTypeSegue,
    TCStoreDetailViewActionTypePackageMore,
    TCStoreDetailViewActionTypeWebLoadFinish,
    TCStoreDetailViewActionTypeCommentWrite,
    TCStoreDetailViewActionTypeComment,
    TCStoreDetailViewActionTypeCommentMore,
    TCStoreDetailViewActionTypeFacility,
    
    TCStoreDetailViewActionTypeLike = 100,
    TCStoreDetailViewActionTypeWrite,
    TCStoreDetailViewActionTypeAppoiment,
    
} TCStoreDetailViewActionType;

@class TCStoreDetailView;
@protocol TCStoreDetailViewDelegate <NSObject>
- (void)tcStoreDetailView:(TCStoreDetailView *)view actionType:(TCStoreDetailViewActionType)type value:(id)value;
@end

@interface TCStoreDetailView : UIView
@property (nonatomic, weak) id<TCStoreDetailViewDelegate> delegate;
@property (nonatomic, strong) TCStoreDetailData *data;
- (void)relodData;
@end
