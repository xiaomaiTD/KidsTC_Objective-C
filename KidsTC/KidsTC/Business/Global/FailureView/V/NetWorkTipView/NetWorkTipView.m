//
//  NetWorkTipView.m
//  KidsTC
//
//  Created by 詹平 on 2016/11/2.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "NetWorkTipView.h"

@implementation NetWorkTipView

- (void)awakeFromNib {
    [super awakeFromNib];
    self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.8];
    UITapGestureRecognizer *tapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
    [self addGestureRecognizer:tapGR];
}

- (void)tapAction:(UITapGestureRecognizer *)taPgr {
    if (self.tapActionBlock) {
        self.tapActionBlock();
    }
}

@end
