//
//  RadishSettlementToolBar.h
//  KidsTC
//
//  Created by 詹平 on 2016/12/26.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RadishSettlementData.h"

extern CGFloat const kRadishSettlementToolBarH;

@class RadishSettlementToolBar;
@protocol RadishSettlementToolBarDelegate <NSObject>
- (void)didClickRadishSettlementToolBar:(RadishSettlementToolBar *)toolBar;
@end

@interface RadishSettlementToolBar : UIView
@property (nonatomic, strong) RadishSettlementData *data;
@property (nonatomic, weak) id<RadishSettlementToolBarDelegate> delegate;
- (void)setAddressBGViewHide:(BOOL)hide;
@end
