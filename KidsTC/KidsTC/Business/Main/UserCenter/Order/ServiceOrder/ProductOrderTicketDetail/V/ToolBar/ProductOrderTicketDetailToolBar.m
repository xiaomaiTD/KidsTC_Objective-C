//
//  ProductOrderTicketDetailToolBar.m
//  KidsTC
//
//  Created by 詹平 on 2016/12/12.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "ProductOrderTicketDetailToolBar.h"
#import "ProductOrderTicketDetailBtnsView.h"
#import "NSString+Category.h"

CGFloat const kProductOrderTicketDetailToolBarH = 87;

@interface ProductOrderTicketDetailToolBar ()<ProductOrderTicketDetailBtnsViewDelegate>
@property (weak, nonatomic) IBOutlet ProductOrderTicketDetailBtnsView *btnsView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *btnsViewH;
@property (weak, nonatomic) IBOutlet UIView *countDownView;
@property (weak, nonatomic) IBOutlet UILabel *countDownL;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *HLineH;
@end

@implementation ProductOrderTicketDetailToolBar

- (void)awakeFromNib {
    [super awakeFromNib];
    _HLineH.constant = LINE_H;
    _btnsView.delegate = self;
    [NotificationCenter addObserver:self selector:@selector(countDown) name:kTCCountDownNoti object:nil];
}

- (void)setData:(ProductOrderTicketDetailData *)data {
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
    ProductOrderTicketDetailCountDown *countDown = self.data.countDown;
    NSString *str = countDown.countDownValueString;
    if ([str isNotNull]) {
        _countDownView.hidden = NO;
        _countDownL.text = str;
    }else{
        _countDownView.hidden = YES;
        [NotificationCenter removeObserver:self name:kTCCountDownNoti object:nil];
        if (countDown.showCountDown && !countDown.countDownOver) {
            countDown.countDownOver = YES;
            if ([self.delegate respondsToSelector:@selector(productOrderTicketDetailToolBar:actionType:value:)]) {
                [self.delegate productOrderTicketDetailToolBar:self actionType:ProductOrderTicketDetailToolBarActionTypeCountDownOver value:_data];
            }
        }
    }
}

- (void)dealloc{
    [NotificationCenter removeObserver:self name:kTCCountDownNoti object:nil];
}

#pragma mark - ProductOrderTicketDetailBtnsViewDelegate
- (void)productOrderTicketDetailBtnsView:(ProductOrderTicketDetailBtnsView *)view actionBtn:(UIButton *)btn value:(id)value {
    if ([self.delegate respondsToSelector:@selector(productOrderTicketDetailToolBar:actionType:value:)]) {
        [self.delegate productOrderTicketDetailToolBar:self actionType:btn.tag value:_data];
    }
}

@end
