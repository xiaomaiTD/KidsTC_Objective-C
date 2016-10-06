//
//  FlashServiceOrderDetailToolBar.m
//  KidsTC
//
//  Created by zhanping on 8/17/16.
//  Copyright © 2016 詹平. All rights reserved.
//

#import "FlashServiceOrderDetailToolBar.h"
#import "NSString+Category.h"

@interface FlashServiceOrderDetailToolBar ()
@property (nonatomic, strong) NSMutableArray<FlashServiceOrderDetailToolBarButton *> *btns;
@end

@implementation FlashServiceOrderDetailToolBar

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
    
    [_btns enumerateObjectsUsingBlock:^(FlashServiceOrderDetailToolBarButton * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        CGFloat button_x = button_margin + (button_margin + button_w) * idx;
        obj.frame = CGRectMake(button_x, button_y, button_w, button_h);
    }];
}

- (void)setData:(FlashServiceOrderDetailData *)data{
    _data = data;
    
    [self.btns makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self.btns removeAllObjects];
    
    UIColor *color = [UIColor lightGrayColor];
    
    if (data.canRefund) {
        [self addBtnWithTitle:@"申请退款" actionType:ActionTypeRefund color:color];
    }

    if (data.isShowSendConsumeCode) {
        [self addBtnWithTitle:@"获取消费码" actionType:ActionTypeGetCode color:COLOR_PINK];
    }else if (data.isLink && [data.statusDesc isNotNull]){
        [self addBtnWithTitle:data.statusDesc actionType:ActionTypeLinkAction color:COLOR_PINK];
    }
    self.hidden = _btns.count<1;
}

- (void)addBtnWithTitle:(NSString *)title actionType:(FlashServiceOrderDetailToolBarButtonActionType)type color:(UIColor *)color{
    FlashServiceOrderDetailToolBarButton *btn = [FlashServiceOrderDetailToolBarButton btnWithTitlw:title actionType:type color:color];
    [btn addTarget:self action:@selector(action:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:btn];
    [self.btns addObject:btn];
}

- (void)action:(FlashServiceOrderDetailToolBarButton *)sender {
    if ([self.delegate respondsToSelector:@selector(flashServiceOrderDetailToolBar:btn:actionType:value:)]) {
        [self.delegate flashServiceOrderDetailToolBar:self btn:sender actionType:sender.tag value:nil];
    }
}

@end
