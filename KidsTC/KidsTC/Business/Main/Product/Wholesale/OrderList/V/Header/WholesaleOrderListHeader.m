//
//  WholesaleOrderListHeader.m
//  KidsTC
//
//  Created by 詹平 on 2016/12/29.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "WholesaleOrderListHeader.h"

@implementation WholesaleOrderListHeader

- (IBAction)action:(UIButton *)sender {
    if (self.actionBlock) self.actionBlock();
}

@end
