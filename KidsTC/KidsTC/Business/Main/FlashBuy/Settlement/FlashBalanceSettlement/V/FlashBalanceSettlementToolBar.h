//
//  FlashBalanceSettlementToolBar.h
//  KidsTC
//
//  Created by zhanping on 8/17/16.
//  Copyright © 2016 詹平. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FlashSettlementModel.h"
@interface FlashBalanceSettlementToolBar : UIView
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UIButton *btn;
@property (nonatomic, weak) FlashSettlementData *data;
@property (nonatomic, copy) void (^actionBlock)();
@end
