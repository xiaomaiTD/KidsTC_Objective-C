//
//  WholesaleSettlementPayTypeItemView.h
//  KidsTC
//
//  Created by 詹平 on 2016/12/29.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WholesaleSettlementPayTypeItemView;
@protocol WholesaleSettlementPayTypeItemViewDelegate <NSObject>
- (void)didClickWholesaleSettlementPayTypeItemView:(WholesaleSettlementPayTypeItemView *)view;
@end

@interface WholesaleSettlementPayTypeItemView : UIView
@property (nonatomic, assign) BOOL select;
@property (nonatomic, assign) BOOL enable;
@property (weak, nonatomic) IBOutlet UILabel *nameTipL;
@property (nonatomic, weak) id<WholesaleSettlementPayTypeItemViewDelegate> delegate;
@end
