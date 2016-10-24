//
//  ComposeButton.h
//  KidsTC
//
//  Created by 詹平 on 2016/10/24.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    ComposeButtonTypeCompose = 1,
    ComposeButtonTypeSign,
} ComposeButtonType;

@interface ComposeButton : UIButton
@property (nonatomic, assign) ComposeButtonType type;
+ (instancetype)btn:(ComposeButtonType)type;
@end
