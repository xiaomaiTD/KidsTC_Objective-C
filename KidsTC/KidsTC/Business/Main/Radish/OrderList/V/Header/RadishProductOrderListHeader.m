//
//  RadishProductOrderListHeader.m
//  KidsTC
//
//  Created by 詹平 on 2016/12/5.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "RadishProductOrderListHeader.h"

@implementation RadishProductOrderListHeader

- (IBAction)action:(UIButton *)sender {
    if (self.actionBlock) self.actionBlock();
}

@end
