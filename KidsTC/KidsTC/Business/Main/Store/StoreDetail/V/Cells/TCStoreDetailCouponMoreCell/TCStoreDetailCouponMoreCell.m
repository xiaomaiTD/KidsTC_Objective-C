//
//  TCStoreDetailCouponMoreCell.m
//  KidsTC
//
//  Created by 詹平 on 2017/2/8.
//  Copyright © 2017年 zhanping. All rights reserved.
//

#import "TCStoreDetailCouponMoreCell.h"

@implementation TCStoreDetailCouponMoreCell


- (IBAction)action:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(tcStoreDetailBaseCell:actionType:value:)]) {
        [self.delegate tcStoreDetailBaseCell:self actionType:TCStoreDetailBaseCellActionTypeCouponMore value:nil];
    }
}
@end
