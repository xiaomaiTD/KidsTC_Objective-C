//
//  ProductOrderTicketDetailHeader.m
//  KidsTC
//
//  Created by 詹平 on 2016/12/12.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "ProductOrderTicketDetailHeader.h"

@implementation ProductOrderTicketDetailHeader
- (IBAction)action:(UIButton *)sender {
    if (self.actionBlock) self.actionBlock();
}
@end
