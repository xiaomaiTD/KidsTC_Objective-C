//
//  FlashServiceOrderDetailToolBarButton.h
//  KidsTC
//
//  Created by zhanping on 2016/9/20.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    ActionTypeRefund=1,
    ActionTypeGetCode,
    ActionTypeLinkAction
} FlashServiceOrderDetailToolBarButtonActionType;

@interface FlashServiceOrderDetailToolBarButton : UIButton
+ (instancetype)btnWithTitlw:(NSString *)title actionType:(FlashServiceOrderDetailToolBarButtonActionType)type color:(UIColor *)color;
@end
