//
//  RadishOrderDetailToolBar.m
//  KidsTC
//
//  Created by 詹平 on 2016/12/12.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "RadishOrderDetailToolBar.h"
#import "RadishOrderDetailBtnsView.h"
#import "NSString+Category.h"
#import "BuryPointManager.h"

CGFloat const kRadishOrderDetailToolBarH = 87;

@interface RadishOrderDetailToolBar ()<RadishOrderDetailBtnsViewDelegate>
@property (weak, nonatomic) IBOutlet RadishOrderDetailBtnsView *btnsView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *btnsViewH;
@property (weak, nonatomic) IBOutlet UIView *countDownView;
@property (weak, nonatomic) IBOutlet UILabel *countDownL;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *HLineH;
@end

@implementation RadishOrderDetailToolBar

- (void)awakeFromNib {
    [super awakeFromNib];
    _HLineH.constant = LINE_H;
    _btnsView.delegate = self;
    [NotificationCenter addObserver:self selector:@selector(countDown) name:kTCCountDownNoti object:nil];
}

- (void)setData:(RadishOrderDetailData *)data {
    _data = data;
    self.hidden = (data == nil);
    [self countDown];
    if (_data.btns.count>0) {
        self.btnsView.btnsAry = _data.btns;
        self.btnsView.hidden = NO;
        self.btnsViewH.constant = 59;
    }else{
        self.btnsView.hidden = YES;
        self.btnsViewH.constant = 0;
    }
}

- (void)countDown {
    RadishOrderDetailCountDown *countDown = self.data.countDown;
    
    NSString *str = countDown.countDownValueString;
    if ([str isNotNull]) {
        _countDownView.hidden = NO;
        _countDownL.text = str;
    }else{
        _countDownView.hidden = YES;
        [NotificationCenter removeObserver:self name:kTCCountDownNoti object:nil];
        if (countDown.showCountDown && !countDown.countDownOver) {
            countDown.countDownOver = YES;
            if ([self.delegate respondsToSelector:@selector(radishOrderDetailToolBar:actionType:value:)]) {
                [self.delegate radishOrderDetailToolBar:self actionType:RadishOrderDetailToolBarActionTypeCountDownOver value:_data];
            }
        }
    }
}

- (void)dealloc{
    [NotificationCenter removeObserver:self name:kTCCountDownNoti object:nil];
}

#pragma mark - RadishOrderDetailBtnsViewDelegate
- (void)radishOrderDetailBtnsView:(RadishOrderDetailBtnsView *)view actionBtn:(UIButton *)btn value:(id)value {
    if ([self.delegate respondsToSelector:@selector(radishOrderDetailToolBar:actionType:value:)]) {
        [self.delegate radishOrderDetailToolBar:self actionType:btn.tag value:_data];
        [self buryPoint:btn.tag];
    }
}

- (void)buryPoint:(NSInteger)type {
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    NSString *orderId = self.data.orderId;
    if ([orderId isNotNull]) {
        [params setObject:orderId forKey:@"orderId"];
    }
    [params setObject:@(type) forKey:@"optionType"];
    [BuryPointManager trackEvent:@"event_click_order_option" actionId:21615 params:params];
}
@end
