//
//  SeckillSliderCountDownView.m
//  KidsTC
//
//  Created by 詹平 on 2017/1/11.
//  Copyright © 2017年 zhanping. All rights reserved.
//

#import "SeckillSliderCountDownView.h"
#import "NSString+Category.h"

@interface SeckillSliderCountDownView ()
@property (weak, nonatomic) IBOutlet UIView *countDownView;
@property (weak, nonatomic) IBOutlet UILabel *descL;
@property (weak, nonatomic) IBOutlet UIView *dayView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *dayViewW;
@property (weak, nonatomic) IBOutlet UILabel *dayL;
@property (weak, nonatomic) IBOutlet UILabel *hourL;
@property (weak, nonatomic) IBOutlet UILabel *minuteL;
@property (weak, nonatomic) IBOutlet UILabel *secondL;
@end

@implementation SeckillSliderCountDownView

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.dayL.layer.cornerRadius = 2;
    self.dayL.layer.masksToBounds = YES;
    self.hourL.layer.cornerRadius = 2;
    self.hourL.layer.masksToBounds = YES;
    self.minuteL.layer.cornerRadius = 2;
    self.minuteL.layer.masksToBounds = YES;
    self.secondL.layer.cornerRadius = 2;
    self.secondL.layer.masksToBounds = YES;
    
    [NotificationCenter addObserver:self selector:@selector(countDown) name:kTCCountDownNoti object:nil];
}

- (void)setData:(SeckillDataData *)data {
    _data = data;
    self.descL.text = data.countDownDesc;
    [self countDown];
}

- (void)countDown {
    SeckillDataData *data = self.data;
    NSString *str = data.countDownValueString;
    if ([str isNotNull]) {
        self.countDownView.hidden = NO;
        self.dayL.text = data.daysLeft;
        if ([data.daysLeft isNotNull]) {
            self.dayView.hidden = NO;
            self.dayViewW.constant = 37;
        }else{
            self.dayView.hidden = YES;
            self.dayViewW.constant = 0;
        }
        self.hourL.text = data.hoursLeft;
        self.minuteL.text = data.minuteLeft;
        self.secondL.text = data.secondLeft;
    }else{
        self.countDownView.hidden = YES;
        if (data.isShowCountDown && !data.countDownOver) {
            data.countDownOver = YES;
            if ([self.delegate respondsToSelector:@selector(seckillSliderCountDownViewCountDownOver:)]) {
                [self.delegate seckillSliderCountDownViewCountDownOver:self];
            }
        }
    }
}

- (void)dealloc {
    [NotificationCenter removeObserver:self name:kTCCountDownNoti object:nil];
}

@end
