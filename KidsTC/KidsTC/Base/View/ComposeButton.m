//
//  ComposeButton.m
//  KidsTC
//
//  Created by 詹平 on 2016/10/24.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "ComposeButton.h"

@implementation ComposeButton
+ (instancetype)btn:(ComposeButtonType)type {
    ComposeButton *btn = [self new];
    btn.type = type;
    return btn;
}

@end
