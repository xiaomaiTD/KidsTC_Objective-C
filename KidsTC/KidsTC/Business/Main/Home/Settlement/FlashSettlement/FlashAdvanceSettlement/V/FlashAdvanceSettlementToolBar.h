//
//  FlashAdvanceSettlementToolBar.h
//  KidsTC
//
//  Created by zhanping on 8/16/16.
//  Copyright © 2016 詹平. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FlashSettlementModel.h"
@interface FlashAdvanceSettlementToolBar : UIView
@property (weak, nonatomic) IBOutlet UILabel *label;
@property (weak, nonatomic) IBOutlet UIButton *btn;
@property (nonatomic, weak) FlashSettlementModel *model;
@property (nonatomic, copy) void (^actionBlock)();
@end
