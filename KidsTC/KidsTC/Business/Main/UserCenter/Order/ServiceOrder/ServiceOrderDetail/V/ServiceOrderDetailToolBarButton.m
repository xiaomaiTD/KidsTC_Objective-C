//
//  ServiceOrderDetailToolBarButton.m
//  KidsTC
//
//  Created by zhanping on 2016/9/19.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "ServiceOrderDetailToolBarButton.h"

@implementation ServiceOrderDetailToolBarButton

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.layer.borderWidth = 1;
        self.layer.borderColor = [UIColor lightGrayColor].CGColor;
    }
    return self;
}

+ (instancetype)btnWithTitlw:(NSString *)title actionType:(ServiceOrderDetailToolBarButtonActionType)type color:(UIColor *)color {
    ServiceOrderDetailToolBarButton *btn = [self new];
    [btn setTitle:title forState:UIControlStateNormal];
    btn.layer.borderColor = color.CGColor;
    [btn setTitleColor:color forState:UIControlStateNormal];
    btn.tag = type;
    return btn;
}

@end
