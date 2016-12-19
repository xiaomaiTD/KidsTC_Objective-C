//
//  ProductDetailCountDownView.m
//  KidsTC
//
//  Created by 詹平 on 2016/11/1.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "ProductDetailCountDownView.h"
#import "ATCountDown.h"
#import "ToolBox.h"

CGFloat const kProductDetailCountDownViewHeight = 30;

@interface ProductDetailCountDownView ()
@property (weak, nonatomic) IBOutlet UILabel *label1;
@property (weak, nonatomic) IBOutlet UILabel *countdownLabel;
@property (weak, nonatomic) IBOutlet UIView *countdownBGView;
@property (weak, nonatomic) IBOutlet UIView *gapView;
@property (nonatomic, strong) ATCountDown *countdownTimer;
@end

@implementation ProductDetailCountDownView


- (void)setData:(ProductDetailData *)data {
    _data = data;
    
    UIColor *yell = [UIColor colorWithRed:0.688  green:0.621  blue:0.545 alpha:1];
    
    self.label1.textColor = yell;
    self.countdownLabel.textColor = yell;
    self.gapView.backgroundColor = yell;
    
    ProductDetailCountDown *countDown = data.countDown;
    if (countDown.showCountDown && countDown.countDownTime>0 && (_data.priceSort != PriceSortSecKill)) {
        self.hidden = NO;
        [self startCountDown:countDown.countDownTime];
    }else{
        self.hidden = YES;
    }
}

- (void)startCountDown:(NSTimeInterval)time {
    if (!self.countdownTimer) {
        self.countdownTimer = [[ATCountDown alloc] initWithLeftTimeInterval:time];
    }
    WeakSelf(self)
    [self.countdownTimer startCountDownWithCurrentTimeLeft:^(NSTimeInterval currentTimeLeft) {
        StrongSelf(self)
        NSString *string = [ToolBox countDownTimeStringWithLeftTime:currentTimeLeft];
        [self.countdownLabel setText:string];
    } completion:^{
        [self stopCountDown];
        if ([self.delegate respondsToSelector:@selector(productDetailCountDownView:actionType:value:)]) {
            [self.delegate productDetailCountDownView:self actionType:ProductDetailCountDownViewActionTypeCountDonwFinished value:nil];
        }
    }];
}

- (void)stopCountDown {
     self.hidden = YES;
    if (!self.countdownTimer) {
        return;
    }
    [self.countdownTimer stopCountDown];
    self.countdownTimer = nil;
}

@end
