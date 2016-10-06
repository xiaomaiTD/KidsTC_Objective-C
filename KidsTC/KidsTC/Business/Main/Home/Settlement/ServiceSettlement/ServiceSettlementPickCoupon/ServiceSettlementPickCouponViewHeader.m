//
//  ServiceSettlementPickCouponViewHeader.m
//  KidsTC
//
//  Created by zhanping on 8/13/16.
//  Copyright © 2016 詹平. All rights reserved.
//

#import "ServiceSettlementPickCouponViewHeader.h"

@implementation ServiceSettlementPickCouponViewHeader


- (IBAction)action:(UIButton *)sender {
    if (self.actionBlock) self.actionBlock();
}
@end
