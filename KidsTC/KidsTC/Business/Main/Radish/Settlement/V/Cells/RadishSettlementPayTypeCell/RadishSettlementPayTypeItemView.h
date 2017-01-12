//
//  RadishSettlementPayTypeItemView.h
//  KidsTC
//
//  Created by 詹平 on 2016/12/29.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RadishSettlementPayTypeItemView;
@protocol RadishSettlementPayTypeItemViewDelegate <NSObject>
- (void)didClickRadishSettlementPayTypeItemView:(RadishSettlementPayTypeItemView *)view;
@end

@interface RadishSettlementPayTypeItemView : UIView
@property (nonatomic, assign) BOOL select;
@property (nonatomic, assign) BOOL enable;
@property (weak, nonatomic) IBOutlet UILabel *nameTipL;
@property (nonatomic, weak) id<RadishSettlementPayTypeItemViewDelegate> delegate;
@end
