//
//  ProductOrderFreeListHeader.m
//  KidsTC
//
//  Created by 詹平 on 2016/12/5.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "ProductOrderFreeListHeader.h"

@implementation ProductOrderFreeListHeader

- (IBAction)action:(UIButton *)sender {
    if (self.actionBlock) self.actionBlock();
}

@end
