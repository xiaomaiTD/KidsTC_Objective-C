//
//  WholesaleSettlementToolBar.m
//  KidsTC
//
//  Created by 詹平 on 2016/12/26.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "WholesaleSettlementToolBar.h"

@interface WholesaleSettlementToolBar ()
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *HLineH;

@end

@implementation WholesaleSettlementToolBar

- (void)awakeFromNib {
    [super awakeFromNib];
    self.HLineH.constant = LINE_H;
}

@end
