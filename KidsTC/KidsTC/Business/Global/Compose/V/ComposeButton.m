//
//  ComposeButton.m
//  KidsTC
//
//  Created by 詹平 on 2016/10/24.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "ComposeButton.h"
#import "NSString+Category.h"
#import "UIButton+WebCache.h"

@implementation ComposeButton
+ (instancetype)btn:(ComposeButtonType)type data:(ComposeBtn *)btnData {
    ComposeButton *btn = [self new];
    btn.imageView.contentMode = UIViewContentModeScaleAspectFit;
    btn.type = type;
    btn.btnData = btnData;
    CALayer *layer = btn.layer;
    layer.shadowColor = [UIColor colorWithWhite:0 alpha:0.5].CGColor;
    layer.shadowOffset = CGSizeMake(2, 2);
    layer.shadowOpacity = 1;
    layer.shadowRadius = 4;
    NSString *name = @"";
    switch (type) {
        case ComposeButtonTypeCompose:
        {
            name = @"tabbar_compose_idea";
        }
            break;
        case ComposeButtonTypeSign:
        {
            name = @"tabbar_compose_review";
        }
            break;
    }
    
    if (btnData.iconCode == ComposeBtnIconTypeUrl &&
        [btnData.iconUrl isNotNull]) {
        [btn sd_setImageWithURL:[NSURL URLWithString:btnData.iconUrl] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:name]];
    }else{
        [btn setImage:[UIImage imageNamed:name] forState:UIControlStateNormal];
    }
    
    return btn;
}

@end
