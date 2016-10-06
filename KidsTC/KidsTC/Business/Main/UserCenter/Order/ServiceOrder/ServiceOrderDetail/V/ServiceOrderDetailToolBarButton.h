//
//  ServiceOrderDetailToolBarButton.h
//  KidsTC
//
//  Created by zhanping on 2016/9/19.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    ActionTypeCancleOrder=1,//取消订单
    ActionTypePayNow,//立即支付
    ActionTypeApplyRefund,//申请退款
    ActionTypeGetConsumerCode,//获取消费码
    ActionTypeComment,//发表评论
    ActionTypeBuyAgain//再次购买
} ServiceOrderDetailToolBarButtonActionType;

@interface ServiceOrderDetailToolBarButton : UIButton
+ (instancetype)btnWithTitlw:(NSString *)title actionType:(ServiceOrderDetailToolBarButtonActionType)type color:(UIColor *)color;
@end
