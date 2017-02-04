//
//  FlashServiceOrderDetailToolBarButton.m
//  KidsTC
//
//  Created by zhanping on 2016/9/20.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "FlashServiceOrderDetailToolBarButton.h"

@implementation FlashServiceOrderDetailToolBarButton

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.layer.borderWidth = 1;
        self.layer.borderColor = [UIColor lightGrayColor].CGColor;
    }
    return self;
}

+ (instancetype)btnWithTitlw:(NSString *)title actionType:(FlashServiceOrderDetailToolBarButtonActionType)type color:(UIColor *)color {
    FlashServiceOrderDetailToolBarButton *btn = [self new];
    [btn setTitle:title forState:UIControlStateNormal];
    btn.layer.borderColor = color.CGColor;
    [btn setTitleColor:color forState:UIControlStateNormal];
    btn.tag = type;
    return btn;
}

@end
