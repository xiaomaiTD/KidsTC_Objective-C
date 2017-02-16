//
//  WholesaleSettlementToolBar.h
//  KidsTC
//
//  Created by 詹平 on 2016/12/26.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WholesaleSettlementData.h"

extern CGFloat const kWholesaleSettlementToolBarH;

@class WholesaleSettlementToolBar;
@protocol WholesaleSettlementToolBarDelegate <NSObject>
- (void)didClickWholesaleSettlementToolBar:(WholesaleSettlementToolBar *)toolBar;
@end

@interface WholesaleSettlementToolBar : UIView
@property (nonatomic, strong) WholesaleSettlementData *data;
@property (nonatomic, weak) id<WholesaleSettlementToolBarDelegate> delegate;
- (void)setAddressBGViewHide:(BOOL)hide;
@end
