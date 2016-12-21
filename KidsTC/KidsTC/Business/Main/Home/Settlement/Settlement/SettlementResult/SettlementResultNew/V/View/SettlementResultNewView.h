//
//  SettlementResultNewView.h
//  KidsTC
//
//  Created by 詹平 on 2016/12/21.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProductDetailData.h"

typedef enum : NSUInteger {
    SettlementResultNewViewActionTypeOrderDetail = 1,
    SettlementResultNewViewActionTypeGoHome,
    
    SettlementResultNewViewActionTypeLoadRecommend,
    SettlementResultNewViewActionTypeSegue,
} SettlementResultNewViewActionType;

@class SettlementResultNewView;
@protocol SettlementResultNewViewDelegate <NSObject>
- (void)settlementResultNewView:(SettlementResultNewView *)view actionType:(SettlementResultNewViewActionType)type value:(id)value;
@end

@interface SettlementResultNewView : UIView
@property (nonatomic, assign) BOOL paid;
@property (nonatomic, assign) ProductDetailType productType;
@property (nonatomic, strong) ProductDetailData *data;
@property (nonatomic, weak) id<SettlementResultNewViewDelegate> delegate;
- (void)reloadData:(NSInteger)count;
@end
