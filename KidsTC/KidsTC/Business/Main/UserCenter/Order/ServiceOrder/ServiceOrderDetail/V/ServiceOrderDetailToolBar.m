//
//  ServiceOrderDetailToolBar.m
//  KidsTC
//
//  Created by zhanping on 8/15/16.
//  Copyright © 2016 詹平. All rights reserved.
//

#import "ServiceOrderDetailToolBar.h"


@interface ServiceOrderDetailToolBar ()
@property (nonatomic, strong) NSMutableArray<ServiceOrderDetailToolBarButton *> *btns;
@end

@implementation ServiceOrderDetailToolBar

- (void)awakeFromNib{
    [super awakeFromNib];
    self.layer.borderWidth = LINE_H;
    self.layer.borderColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.3].CGColor;
    self.hidden = YES;
    self.btns = [NSMutableArray new];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat button_margin = 12;
    NSUInteger count = _btns.count;
    
    CGFloat button_y = button_margin;
    CGFloat button_w = (SCREEN_WIDTH - (count+1) * button_margin)/count;
    CGFloat button_h = CGRectGetHeight(self.frame) - button_margin * 2;
    
    [_btns enumerateObjectsUsingBlock:^(ServiceOrderDetailToolBarButton * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        CGFloat button_x = button_margin + (button_margin + button_w) * idx;
        obj.frame = CGRectMake(button_x, button_y, button_w, button_h);
    }];
}

- (void)setData:(ServiceOrderDetailData *)data{
    _data = data;
    
    self.hidden = NO;
    
    [self.btns makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self.btns removeAllObjects];
    
    UIColor *color = [UIColor lightGrayColor];
    
    switch (data.orderState) {
        case ServiceOrderDetailOrderStateWaitPay://待付款
        {
            [self addBtnWithTitle:@"取消订单" actionType:ActionTypeCancleOrder color:color];
            [self addBtnWithTitle:@"立即支付" actionType:ActionTypePayNow color:color];
        }
            break;
        case ServiceOrderDetailOrderStateWaitUse://待使用
        case ServiceOrderDetailOrderStatePartUse://部分使用
        {
            if (data.totalPrice>0) [self addBtnWithTitle:@"申请退款" actionType:ActionTypeApplyRefund color:color];
            [self addBtnWithTitle:@"获取消费码" actionType:ActionTypeGetConsumerCode color:color];
        }
            break;
        case ServiceOrderDetailOrderStateWaitComment://待评价
        {
            [self addBtnWithTitle:@"评论晒单" actionType:ActionTypeComment color:color];
        }
            break;
        case ServiceOrderDetailOrderStateCanceled://订单已取消
        case ServiceOrderDetailOrderStateRefunding://退款中
        case ServiceOrderDetailOrderStateRefundSuccess://退款成功
        case ServiceOrderDetailOrderStateRefundFailure://退款失败
        case ServiceOrderDetailOrderStateHasComment://已评价
        case ServiceOrderDetailOrderStateHasOverTime://已过期
        {}
            break;
    }
    if (data.isBuyAgain) [self addBtnWithTitle:@"再次购买" actionType:ActionTypeBuyAgain color:COLOR_PINK];
    
    self.hidden = _btns.count<1;
}

- (void)addBtnWithTitle:(NSString *)title actionType:(ServiceOrderDetailToolBarButtonActionType)type color:(UIColor *)color{
    ServiceOrderDetailToolBarButton *btn = [ServiceOrderDetailToolBarButton btnWithTitlw:title actionType:type color:color];
    [btn addTarget:self action:@selector(action:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:btn];
    [self.btns addObject:btn];
}

- (void)action:(ServiceOrderDetailToolBarButton *)sender {
    if ([self.delegate respondsToSelector:@selector(serviceOrderDetailToolBar:btn:actionType:value:)]) {
        [self.delegate serviceOrderDetailToolBar:self btn:sender actionType:(ServiceOrderDetailToolBarButtonActionType)sender.tag value:nil];
    }
}
@end
