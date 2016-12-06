//
//  SearchTableViewFooter.m
//  KidsTC
//
//  Created by 詹平 on 2016/12/6.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "SearchTableViewFooter.h"

@implementation SearchTableViewFooter


- (IBAction)action:(UIButton *)sender {
    if (self.actionBlock) {
        self.actionBlock();
    }
}

@end
